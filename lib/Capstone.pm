package Capstone;

use 5.022000;
use strict;
use warnings;

require Capstone_const;
require Exporter;

our $VERSION = '0.1';
our @ISA = qw(Exporter);

# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.

# This allows declaration	use Capstone ':all';
# If you do not need this, moving things directly into @EXPORT or @EXPORT_OK
# will save memory.
our %EXPORT_TAGS = ( 'all' => [ qw(CS_ARCH_X86 CS_ARCH_ARM CS_MODE_32 CS_MODE_64 CS_OPT_SYNTAX CS_OPT_SYNTAX_ATT) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = qw(
	
);

our $VERSION = '0.01';

require XSLoader;
XSLoader::load('Capstone', $VERSION);

# Preloaded methods go here.

sub new {
    my ($class, $arch, $mode) = @_;
    my $this = {};

    bless($this, $class);

    $this->{handle} = Capstone::open($arch, $mode);
    
    undef $this if(!defined($this->{handle}));

    return $this;
}

sub dis {
    my ($this, $code, $address, $num) = @_;

    return Capstone::disasm($this->{handle}, $code, $address, $num);
}

sub set_option {
    my ($this, $type, $value) = @_;

    return Capstone::option($this->{handle}, $type, $value);
}

1;

__END__

=head1 NAME

Capstone - Perl extension for capstone-engine

=head1 SYNOPSIS

  use Capstone 'all';

  $cs = Capstone->new(CS_ARCH_X86, CS_MODE_64) || die "Can't init Capstone\n";
  @insn = $cs->dis("\x4c\x8d\x25\xee\xa6\x20\x00jdslaaaaaaa", 0xFFFFFFFF, 0);

  foreach(@insn) {
    printf "0x%.16x    %s %s\n", $_->{address}, $_->{mnemonic}, $_->{op_str};
  }


=head1 DESCRIPTION

This module is a Perl wrapper of the capstone-engine library.

=head1 SEE ALSO

http://capstone-engine.org/

=head1 AUTHOR

Tosh, E<lt>tosh@t0x0sh.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2015 by Tosh

This library is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.                              

=cut
