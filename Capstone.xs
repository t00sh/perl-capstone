/****************************************************************************/
/* capstone-perl - A Perl wrapper for the capstone-engine library           */
/*                                                                          */
/* Copyright 2015, -TOSH-                                                   */
/* File coded by -TOSH-                                                     */
/*                                                                          */
/* This file is part of capstone-perl.                                      */
/*                                                                          */
/* capstone-perl is free software: you can redistribute it and/or modify    */
/* it under the terms of the GNU General Public License as published by     */
/* the Free Software Foundation, either version 3 of the License, or        */
/* (at your option) any later version.                                      */
/*                                                                          */
/* capstone-perl is distributed in the hope that it will be useful,         */
/* but WITHOUT ANY WARRANTY; without even the implied warranty of           */
/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the            */
/* GNU General Public License for more details.                             */
/*                                                                          */
/* You should have received a copy of the GNU General Public License        */
/* along with capstone-perl.  If not, see <http://www.gnu.org/licenses/>    */
/****************************************************************************/

/* Perl XS wrapper for capstone-engine */

#define PERL_NO_GET_CONTEXT
#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include "ppport.h"

#include <capstone/capstone.h>


MODULE = Capstone   PACKAGE = cshPtr  PREFIX = csh_

# csh object destructor
void
csh_DESTROY(handle)
    csh *handle

    CODE:
        cs_close(handle);
        Safefree(handle);


    
MODULE = Capstone   PACKAGE = Capstone
    
# Wrapper to cs_open()
csh*
open(arch,mode)
    cs_arch arch
    cs_mode mode

    PREINIT:
        cs_err err;

    CODE:
        Newx(RETVAL, 1, csh);

        err = cs_open(arch, mode, RETVAL);

        if(err != CS_ERR_OK) {
               Safefree(RETVAL);
               XSRETURN_UNDEF;
        }

    OUTPUT:
        RETVAL

# Wrapper to cs_option()
int
option(handle,type,value)
    csh *handle
    cs_opt_type type
    size_t value


    PREINIT:
        cs_err err;

    CODE:
        err = cs_option(*handle, type, value);

        if(err != CS_ERR_OK) {
            RETVAL = 0;
        } else {
            RETVAL = 1;
        }

    OUTPUT:
        RETVAL


# Wrapper to cs_disasm()
SV*
disasm(handle,code,address,count)
    csh *handle
    SV *code
    UV address
    size_t count


    PREINIT:
        size_t ret, i;
        HV *hash;
        cs_insn *insn;

    PPCODE:
        printf("%p\n", handle);
        if(SvTYPE(code) != SVt_PV) {
            croak("<code> argument not an array scalar");
        }

        ret = cs_disasm(*handle, SvPVbyte(code, SvCUR(code)), SvCUR(code), address, count, &insn);

        for(i = 0; i < ret; i++) {
           hash = newHV();
           hv_store(hash, "address", 7, newSVuv(insn[i].address), 0);
           hv_store(hash, "mnemonic", 8, newSVpv(insn[i].mnemonic, strlen(insn[i].mnemonic)), 0);
           hv_store(hash, "op_str", 6, newSVpv(insn[i].op_str, strlen(insn[i].op_str)), 0);
           PUSHs(newRV_noinc((SV *)hash) );
        }

        if(ret) {
            cs_free(insn, ret);
        }

# Wrapper to cs_version()
SV*
version()

    PREINIT:
        int major, minor;

    PPCODE:
        cs_version(&major, &minor);

        EXTEND(SP, 2);
        XST_mIV(0, major);
        XST_mIV(1, minor);
        XSRETURN(2);


# Wrapper to cs_support()
int
support(query)
    int query

    CODE:
        RETVAL = cs_support(query);

    OUTPUT:
        RETVAL
