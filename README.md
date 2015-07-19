# NAME

Capstone - Perl extension for capstone-engine

# SYNOPSIS

    use Capstone ':all';

    $cs = Capstone->new(CS_ARCH_X86, CS_MODE_64) || die "Can't init Capstone\n";
    @insn = $cs->dis("\x4c\x8d\x25\xee\xa6\x20\x00\x90\xcd\x80", 0x040000a, 0);

    foreach(@insn) {
      printf "0x%.16x    %s %s\n", $_->{address}, $_->{mnemonic}, $_->{op_str};
    }

# DESCRIPTION

This module is a Perl wrapper of the capstone-engine library.

Capstone is a disassembly framework with the target of becoming the ultimate
disasm engine for binary analysis and reversing in the security community.

Created by Nguyen Anh Quynh, then developed and maintained by a small community,
Capstone offers some unparalleled features:

\- Support multiple hardware architectures: ARM, ARM64 (ARMv8), Mips, PPC, Sparc,
  SystemZ, XCore and X86 (including X86\_64).

\- Having clean/simple/lightweight/intuitive architecture-neutral API.

\- Provide details on disassembled instruction (called \\u201cdecomposer\\u201d by others).

\- Provide semantics of the disassembled instruction, such as list of implicit
  registers read & written.

\- Implemented in pure C language, with lightweight wrappers for C++, C#, Go,
  Java, Lua, NodeJS, Ocaml, Python, Ruby, Rust & Vala ready (available in
  main code, or provided externally by the community).

\- Native support for all popular platforms: Windows, Mac OSX, iOS, Android,
  Linux, \*BSD, Solaris, etc.

\- Thread-safe by design.

\- Special support for embedding into firmware or OS kernel.

\- High performance & suitable for malware analysis (capable of handling various
  X86 malware tricks).

\- Distributed under the open source BSD license.

Further information is available at http://www.capstone-engine.org

# SEE ALSO

http://capstone-engine.org/

## Exportable methods

- new(arch, mode)

    Constructor of cshPtr object.
    Take two arguments, the arch (CS\_ARCH\_\*) and the mode (CS\_MODE\_\*).
    See capstone-engine documentation

- dis(code, address, num)

    Disassemble code, and return at least num instructions.
    Set num to 0 if you want disassemble all the code.

    Instructions start at address <address>

    See capstone-engine documentation.

## Exportable functions

- version()

    Return a list of two scalars, the first is the major version, and the second
    is the minor version

- support(value)

    Test if the library support an architecture.
    Use CS\_ARCH\_\* constant (see capstone documentation)

# AUTHOR

Tosh, <tosh@t0x0sh.org>

# COPYRIGHT AND LICENSE

Copyright (C) 2015 by Tosh

This library is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.                              
