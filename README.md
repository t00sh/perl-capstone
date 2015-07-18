# NAME

Capstone - Perl extension for capstone-engine

# SYNOPSIS

    use Capstone ':all';

    $cs = Capstone->new(CS_ARCH_X86, CS_MODE_64) || die "Can't init Capstone\n";
    @insn = $cs->dis("\x4c\x8d\x25\xee\xa6\x20\x00jdslaaaaaaa", 0xFFFFFFFF, 0);

    foreach(@insn) {
      printf "0x%.16x    %s %s\n", $_->{address}, $_->{mnemonic}, $_->{op_str};
    }

# DESCRIPTION

This module is a Perl wrapper of the capstone-engine library.

# SEE ALSO

http://capstone-engine.org/

# AUTHOR

Tosh, <tosh@t0x0sh.org>

# COPYRIGHT AND LICENSE

Copyright (C) 2015 by Tosh

This library is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.                              
