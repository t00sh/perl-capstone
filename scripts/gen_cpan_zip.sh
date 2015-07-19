#!/bin/sh

ZIP_ARCHIVE="pkgs/cpan/Capstone.zip"

zip $ZIP_ARCHIVE $(cat MANIFEST) || exit 1

echo "DONE"
