#! /opt/perl5/bin/perl

use ExtUtils::testlib;
use Capstone ':all';
use Data::Dumper;
    
use strict;
use warnings;

my $cs = Capstone->new(CS_ARCH_X86, CS_MODE_64);

$cs->set_option(CS_OPT_SYNTAX, CS_OPT_SYNTAX_ATT);

my @insn = $cs->dis("\x4c\x8d\x25\xee\xa6\x20\x00jdslaaaaaaa", 0xFFFFFFFF, 0);

foreach(@insn) {
    printf "0x%.16x    %s %s\n", $_->{address}, $_->{mnemonic}, $_->{op_str};
}

printf "Capstone version %d.%d\n", Capstone::version();
print "support : " . Capstone::support(3) . "\n";

print "ok\n";
