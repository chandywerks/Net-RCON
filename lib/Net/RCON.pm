package Net::RCON;

use warnings;
use strict;

use IO::Socket::INET;

use constant {
	SERVERDATA_RESPONSE_VALUE => 0,
	SERVERDATA_AUTH_RESPONSE  => 2,
	SERVERDATA_EXECCOMMAND    => 2,
	SERVERDATA_AUTH           => 3
};

sub new {
	my ( $class, $args ) = @_;

	my $self = {
		host     => $args->{host},
		port     => $args->{port},
		password => $args->{password},
	};

	$self->{sock} = IO::Socket::INET->new(
		PeerHost => $self->{host},
		PeerPort => $self->{port},
		Proto    => 'tcp'
	) or die "Unable to connect to the RCON server: $!\n";

	my $object = bless ( $self, $class );

	# Send a SERVERDATA_AUTH packet
	$object->_send_rcon( 1, SERVERDATA_AUTH, $self->{password} );

	# Check is SERVERDATA_AUTH_RESPONSE came back as valid
	if( !$self->_recv_rcon( 1, SERVERDATA_AUTH_RESPONSE ) ) {
		warn "Authentication to the RCON server failed";
		return undef;
	}

	return $object;
}

sub DESTROY {
	my ( $self ) = @_;

	$self->{sock}->close();
}

sub send {
	my ( $self, $command ) = @_;

	$self->_send_rcon( 1, SERVERDATA_EXECCOMMAND, $command );
	my $response = $self->_recv_rcon( 1, SERVERDATA_RESPONSE_VALUE );

	if( $response ) {
		return $response;
	} else {
		warn "RCON command $command failed. Unexpected response from the RCON server";
		return undef;
	}
}

sub _send_rcon {
	my ( $self, $id, $type, $message ) = @_;

	# Build RCON packet
	my $data = pack("VV", $id, $type) . $message . pack("xx");

	# Prepend packet size
	$data = pack("V", length($data)).$data;

	my $size = $self->{sock}->send( $data );
}

sub _recv_rcon {
	my ( $self, $id, $type ) = @_;

	# Get response
	my $response = "";
	$self->{sock}->recv( $response, 4096 );

	# Unpack response packet
	my ($size, $response_id, $response_type, $response_body) = unpack( "VVVa*", $response );

	# Make sure the response id is what we sent
	if( $response_id == $id && $response_type == $type && $size >= 10 && $size <= 4096) {
		# TODO it's possible that the response cannot fit in 4096 bytes
		# we eventually need to check for more response here

		return $response_body;
	} else {
		return undef;
	}
}
1;
