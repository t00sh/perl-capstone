#!/usr/bin/perl

use Data::Dumper;
use ExtUtils::testlib;
use Capstone ':all';

use strict;
use warnings;

my $CODE = "\x4c\x8d\x25\xee\xa6\x20\x00\x90\x90\xcd\x80\x41\x5c\x41\x57";
my $ADDRESS = 0x040000;

printf "Capstone version %d.%d\n", Capstone::version();
print "Support ARCH_ALL : " . Capstone::support(CS_ARCH_ALL) . "\n\n";

print "[+] Create disassembly engine\n";
my $cs = Capstone->new(CS_ARCH_X86, CS_MODE_64)
    || die "[-] Can't create capstone object\n";

print "[+] Set AT&T syntax\n";
$cs->set_option(CS_OPT_SYNTAX, CS_OPT_SYNTAX_ATT)
    || die "[-] Can't set CS_OPT_SYNTAX_ATT option\n";

print "[+] Set details ON\n";
$cs->set_option(CS_OPT_DETAIL, CS_OPT_ON)
    || die "[-] Can't set CS_OPT_DETAIL ON\n";

print "[+] Disassemble some code\n\n";
my @insn = $cs->dis($CODE, $ADDRESS, 0);

foreach(@insn) {
    printf "    0x%.16x  %-30s   %s %s\n",
    $_->{address},
    hexlify($_->{bytes}),
    $_->{mnemonic},
    $_->{op_str};
}

print "[+] " . scalar(@insn) . " instructions disassembled\n";

print Dumper(\@insn);

sub hexlify {
    my $bytes = shift;

    return join ' ', map { sprintf "%.2x", ord($_) } split //, $bytes;
}
