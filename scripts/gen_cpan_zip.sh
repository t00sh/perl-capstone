#!/bin/sh

ZIP_ARCHIVE="cpan/Capstone.zip"

zip $ZIP_ARCHIVE $(cat MANIFEST)

echo "DONE"
