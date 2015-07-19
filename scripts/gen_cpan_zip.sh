#!/bin/sh

ZIP_ARCHIVE="pkgs/cpan/Capstone.zip"

zip $ZIP_ARCHIVE $(cat MANIFEST)

echo "DONE"
