#!/bin/sh

if test -z $1
then
    echo "Usage : $0 <version>"
    exit 1
fi

CPAN_PATH="pkgs/cpan"
ZIP_ARCHIVE="Capstone-$1.zip"

rm -rf $CPAN_PATH/"Capstone"

mkdir $CPAN_PATH/"Capstone"               || exit 1
cp $(cat MANIFEST) $CPAN_PATH/"Capstone"  || exit 1
cd $CPAN_PATH
zip -r $ZIP_ARCHIVE "Capstone"            || exit 1

rm -rf "Capstone"

echo "DONE"
