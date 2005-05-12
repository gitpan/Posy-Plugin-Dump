package Posy::Plugin::Dump;
use strict;
use warnings;

=head1 NAME

Posy::Plugin::Dump - Posy plugin to aid debugging by dumping object contents.

=head1 VERSION

This describes version B<0.47> of Posy::Plugin::Dump.

=cut

our $VERSION = '0.47';

=head1 SYNOPSIS

    @plugins = qw(Posy::Core
	...
	Posy::Plugin::Dump));
    @actions = qw(init_params
	    parse_path
	    ...
	    dump
	);

=head1 DESCRIPTION

This plugin is for developers to aid debugging by "dumping" the contents of
$self and the "state" hashes to STDERR when it is called.  Provides a 'dump'
method which can be put as an action into the actions list or into the
entry_actions list (or both).

=head2 Activation

This plugin needs to be added to both the plugins list and the actions
list.  It doesn't really matter where it is in the plugins list.

In the (entry_)actions list, it goes whereever you want it to go.

=cut
use Data::Dumper;

=head1 Flow Action Methods

Methods implementing actions.

=head2 dump

    $self->dump();
    $self->dump($flow_state);
    $self->dump($flow_state, $current_entry, $entry_state);

Dump object data (for debugging)

This can be called as a flow action or as an entry action, and will
dump the given state hashes accordingly.

=cut
sub dump {
    my $self = shift;
    my $flow_state = (@_ ? shift : undef);
    my $current_entry = (@_ ? shift : undef);
    my $entry_state = (@_ ? shift : undef);

    my $class = ref $self;
    my $oh = \*STDERR;
    print $oh "Posy=", Dumper($self);
    if (exists $self->{cgi} and defined $self->{cgi})
    {
	print $oh "params:\n";
	my @params = $self->{cgi}->param();
	foreach my $param (@params)
	{
	    print $oh "$param=", $self->{cgi}->param($param), "\n";
	}
    }
    if (defined $flow_state)
    {
	print $oh "flow_state=", Dumper($flow_state);
    }
    if (defined $current_entry)
    {
	print $oh "current_entry=", Dumper($current_entry);
    }
    if (defined $entry_state)
    {
	print $oh "entry_state=", Dumper($entry_state);
    }
} # dump

=head1 INSTALLATION

Installation needs will vary depending on the particular setup a person
has.

=head2 Administrator, Automatic

If you are the administrator of the system, then the dead simple method of
installing the modules is to use the CPAN or CPANPLUS system.

    cpanp -i Posy::Plugin::Dump

This will install this plugin in the usual places where modules get
installed when one is using CPAN(PLUS).

=head2 Administrator, By Hand

If you are the administrator of the system, but don't wish to use the
CPAN(PLUS) method, then this is for you.  Take the *.tar.gz file
and untar it in a suitable directory.

To install this module, run the following commands:

    perl Build.PL
    ./Build
    ./Build test
    ./Build install

Or, if you're on a platform (like DOS or Windows) that doesn't like the
"./" notation, you can do this:

   perl Build.PL
   perl Build
   perl Build test
   perl Build install

=head2 User With Shell Access

If you are a user on a system, and don't have root/administrator access,
you need to install Posy somewhere other than the default place (since you
don't have access to it).  However, if you have shell access to the system,
then you can install it in your home directory.

Say your home directory is "/home/fred", and you want to install the
modules into a subdirectory called "perl".

Download the *.tar.gz file and untar it in a suitable directory.

    perl Build.PL --install_base /home/fred/perl
    ./Build
    ./Build test
    ./Build install

This will install the files underneath /home/fred/perl.

You will then need to make sure that you alter the PERL5LIB variable to
find the modules, and the PATH variable to find the scripts (posy_one,
posy_static).

Therefore you will need to change:
your path, to include /home/fred/perl/script (where the script will be)

	PATH=/home/fred/perl/script:${PATH}

the PERL5LIB variable to add /home/fred/perl/lib

	PERL5LIB=/home/fred/perl/lib:${PERL5LIB}

=head1 REQUIRES

    Data::Dumper
    Posy::Core
    Posy

    Test::More

=head1 SEE ALSO

perl(1).
Posy
Data::Dumper

=head1 BUGS

Please report any bugs or feature requests to the author.

=head1 AUTHOR

    Kathryn Andersen (RUBYKAT)
    perlkat AT katspace dot com
    http://www.katspace.com

=head1 COPYRIGHT AND LICENCE

Copyright (c) 2004-2005 by Kathryn Andersen

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut

1; # End of Posy::Plugin::Dump
__END__
