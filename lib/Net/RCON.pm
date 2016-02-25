package Net::RCON;

use warnings;
use strict;

use IO::Socket;

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

	$self->{sock} = IO::Socket::INET->new( $self->{host} );

	# Send a SERVERDATA_AUTH pakcet

	# Check is SERVERDATA_AUTH_RESPONSE came back as valid or else return error

	return bless( $self, $class );
}

sub send {
	my ( $self, $type, $command ) = @_;

	$self->_send_rcon( 1, SERVERDATA_EXECCOMMAND, $command );

	my $response;

	while( ( $response = $self->_recv_rcon( 1, SERVERDATA_RESPONSE_VALUE ) ) == -1 ) {}

	# Process $response and return it
}

sub _send_rcon {
	my ( $self, $id, $type, $body ) = @_;

	# Build and send an rcon packet
}

sub _recv_rcon {
	my ( $self, $id, $type ) = @_;

	# Wait for packet to come back and check if the id and type match

	# Process and return response
}
