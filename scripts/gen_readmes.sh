#!/bin/sh

echo "[+] Gen README.md"
pod2markdown.pl < lib/Capstone.pm > README.md

echo "[+] Gen README"
pod2text < lib/Capstone.pm > README
