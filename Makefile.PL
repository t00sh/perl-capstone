use 5.014000;
use ExtUtils::MakeMaker;

# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
my $cflags = `pkg-config --cflags capstone`;
chomp $cflags if $cflags;
my $define = '-DCAPSTONE_FROM_PKGCONFIG' if $cflags;
my $ldflags = `pkg-config --libs capstone` || '-lcapstone';
chomp $ldflags if $ldflags;

WriteMakefile(
    NAME              => 'Capstone',
    VERSION_FROM      => 'lib/Capstone.pm',
    PREREQ_PM         => {},
    ABSTRACT_FROM     => 'lib/Capstone.pm',
    AUTHOR            => 'Tosh <tosh@t0x0sh.org>',
    LICENSE           => 'GPL_3',
    LIBS              => [$ldflags],
    DEFINE            => $define || '',
    INC               => ($cflags || '') . ' -I.',
);
