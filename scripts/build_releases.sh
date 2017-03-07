#!/bin/sh

function cmd_to_devnull() {
    $* > /dev/null 2>/dev/null
    if test $? -ne 0
    then
        echo "[-] Command \"$*\" failed"
        exit 1
    fi
}

CS_VERSION=$(grep "VERSION =" lib/Capstone.pm | awk -F\' '{print $2}')

echo "[+] Adding GIT tag v$CS_VERSION"
cmd_to_devnull git tag v$CS_VERSION
cmd_to_devnull git push origin v$CS_VERSION


echo ""
echo ""
echo "~~~~~~~~~~~~ CPAN ~~~~~~~~~~~~~~"
echo "[+] Genere CPAN archive"
if test ! -d pkgs/cpan
then
    mkdir pkgs/cpan
fi
cmd_to_devnull scripts/gen_cpan_zip.sh
echo "[+] You can upload pkgs/cpan/Capstone-$CS_VERSION.zip to : https://pause.perl.org/pause/authenquery?ACTION=add_uri"

echo ""
echo ""
echo "~~~~~~~~~~ ArchLinux ~~~~~~~~~~~"
echo "[+] Genere archlinux package"

cd pkgs/archlinux
sed -i -r "s/pkgver=.+/pkgver=$CS_VERSION/g" PKGBUILD

SHA_SUMS=$(makepkg -g 2>/dev/null)
sed -i -r "s/sha256sums=.+/$SHA_SUMS/g" PKGBUILD

cmd_to_devnull mksrcinfo
cmd_to_devnull chmod 0644 PKGBUILD .SRCINFO
cmd_to_devnull git add PKGBUILD .SRCINFO
git commit -m v$CS_VERSION >/dev/null 2>/dev/null
cmd_to_devnull git push
cmd_to_devnull makepkg -f --source

echo "[+] You can upload pkg/archlinux/*.src.tar.gz to : https://aur.archlinux.org/submit/"

echo "[+] Capstone v$CS_VERSION released !"
