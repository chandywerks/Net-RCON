Net::RCON
=========

This module provides an interface to an RCON (remote console) server.

RCON is typically implemented by game servers to allow servers admins to control their game servers without direct access to the machine the server is running on.

This module is based on the spec detailed here, https://developer.valvesoftware.com/wiki/Source_RCON_Protocol

See perldoc for usage details.

### INSTALLATION

You can use the cpan or cpanm CLI utility to install the package from CPAN. This will attempt to satisfy all the dependencies for you.

If you wish to install this module manually download the [tar.gz package](https://metacpan.org/module/Net::RCON) and run the following,

	tar -xvf Net-RCON-#.##.tar.gz
	cd Net-RCON-#.##
	perl Makefile.PL
	make test
	sudo make install

### BUILDING PACKAGE FROM GIT

If you wish the build a package from the git repository you will need git and the Dist::Zilla application along with the PodWeaver plugin.

To build a package from git:

	git clone https://github.com/chandwer/Net-RCON.git
	dzil build

To install the built package:

	cd Net-RCON-#.##
	perl Makefile.PL
	make test
	sudo make install

### DEPENDENCIES

* IO::Socket;

### AUTHOR

Chris Handwerker 2016 <<chris.handwerker@gmail.com>>

### LICENSE

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.
