use strict;
use warnings;

use Test::More tests => 3;

BEGIN { use_ok('Capstone', ':all'); }

ok(Capstone::version() == (3,0));

ok(Capstone::support(CS_ARCH_ALL));
