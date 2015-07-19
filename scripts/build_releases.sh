#!/bin/sh

set -e

if test -z $1
then
    echo "Usage : $0 <version> (e.g. \"1.3\")"
    exit 1
fi

echo "[+] Genere readme's"
scripts/gen_readmes.sh
git add README*
git commit -m "Regenere README's" || expr 1
git push

echo "[+] Adding GIT tag v$1"
git tag v$1
git push origin v$1

echo ""
echo ""
echo "~~~~~~~~~~~~ CPAN ~~~~~~~~~~~~~~"
echo "[+] Genere CPAN archive"
scripts/gen_cpan_zip.sh
echo "[+] You can upload pkgs/cpan/Capstone.zip to : https://pause.perl.org/pause/authenquery?ACTION=add_uri"

echo ""
echo ""
echo "~~~~~~~~~~ ArchLinux ~~~~~~~~~~~"
echo "[+] Genere archlinux package"
cd pkgs/archlinux
sed -i -r "s/pkgver=.+/pkgver=$1/g" PKGBUILD
SHA_SUMS=$(makepkg -g)
sed -i -r "s/sha256sums=.+/$SHA_SUMS/g" PKGBUILD
mksrcinfo
git add PKGBUILD .SRCINFO
git commit -m "Release v$1"
git push
makepkg --source
echo "[+] You can upload pkg/archlinux/*.src.tar.gz to : https://aur.archlinux.org/submit/"

