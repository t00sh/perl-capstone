#!/bin/sh

if test -z $1
then
    echo "Usage : $0 <version>"
    exit 1
fi

ZIP_ARCHIVE="pkgs/cpan/Capstone-$1.zip"

zip $ZIP_ARCHIVE $(cat MANIFEST) || exit 1

echo "DONE"
