#!/bin/sh

if test -z $1
then
    echo "Usage : $0 <version> (e.g. \"1.3\")"
    exit 1
fi

function cmd_to_devnull() {
    $* > /dev/null 2>/dev/null
    if test $? -ne 0
    then
        echo "[-] Command \"$*\" failed"
        exit 1
    fi
}

echo "[+] Adding GIT tag v$1"
cmd_to_devnull git tag v$1
cmd_to_devnull git push origin v$1


echo ""
echo ""
echo "~~~~~~~~~~~~ CPAN ~~~~~~~~~~~~~~"
echo "[+] Genere CPAN archive"
if test ! -d pkgs/cpan
then
    mkdir pkgs/cpan
fi
cmd_to_devnull scripts/gen_cpan_zip.sh
echo "[+] You can upload pkgs/cpan/Capstone-$1.zip to : https://pause.perl.org/pause/authenquery?ACTION=add_uri"

echo ""
echo ""
echo "~~~~~~~~~~ ArchLinux ~~~~~~~~~~~"
echo "[+] Genere archlinux package"

cd pkgs/archlinux
sed -i -r "s/pkgver=.+/pkgver=$1/g" PKGBUILD

SHA_SUMS=$(makepkg -g 2>/dev/null)
sed -i -r "s/sha256sums=.+/$SHA_SUMS/g" PKGBUILD

cmd_to_devnull mksrcinfo
cmd_to_devnull chmod 0644 PKGBUILD .SRCINFO
cmd_to_devnull git add PKGBUILD .SRCINFO
git commit -m v$1 >/dev/null 2>/dev/null
cmd_to_devnull git push
cmd_to_devnull makepkg -f --source

echo "[+] You can upload pkg/archlinux/*.src.tar.gz to : https://aur.archlinux.org/submit/"

echo "[+] Capstone v$1 released !"
