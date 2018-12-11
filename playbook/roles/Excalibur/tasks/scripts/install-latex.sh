#!/bin/bash

PACKNAME=LATEX_TOOLS
EXECNAME=install-tl
LATEXDEST=/usr/local/texlive/2018/

sudo mkdir -pm a=rwx "$LATEXDEST"

tar -xzf "$PACKNAME.tar.gz"

INSTALLDIR="$(find -maxdepth 1 -name "$EXECNAME*")"
cd "$INSTALLDIR"
echo I | sudo perl "$EXECNAME"

cd ../
rm -r "$INSTALLDIR"

exit 0
