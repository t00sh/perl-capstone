#!/bin/sh

ZIP_ARCHIVE="Capstone.zip"

zip $ZIP_ARCHIVE $(cat MANIFEST)

echo "DONE"
