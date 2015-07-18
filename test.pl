#! /opt/perl5/bin/perl

use ExtUtils::testlib;
use Capstone ':all';
use Data::Dumper;
    
use strict;
use warnings;


printf "Capstone version %d.%d\n", Capstone::version();
print "Support ALL : " . Capstone::support(CS_ARCH_ALL) . "\n\n";

my $cs = Capstone->new(CS_ARCH_X86, CS_MODE_64);

$cs->set_option(CS_OPT_SYNTAX, CS_OPT_SYNTAX_ATT);

my @insn = $cs->dis("\x4c\x8d\x25\xee\xa6\x20\x00\x90\x90\xcd\x80", 0xabcd, 0);

foreach(@insn) {
    printf "0x%.16x  %-30s   %s %s\n",
    $_->{address},
    hexlify($_->{bytes}),
    $_->{mnemonic}, 
    $_->{op_str};
}

sub hexlify {
    my $bytes = shift;

    return join ' ', map { sprintf "%.2x", ord($_) } split //, $bytes;
}
