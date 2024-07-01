#!/bin/bash
#
# SPDX-FileCopyrightText: 2023 - 2024 MaerchenfeeimGarten
# 
# SPDX-License-Identifier:  AGPL-3.0-only
#


ADDITIONAL_ARGUMENTS="-exx"      #see https://www.freebasic.net/wiki/ProPgErrorHandling

cd /src/src
echo "==> Target: Linux 64 <=="
fbc $ADDITIONAL_ARGUMENTS "Pfeilspiel TNG international.bas"

echo "==> Sub-Target: Linux 64 - packed <=="
packelf.sh "Pfeilspiel TNG international" "Pfeilspiel TNG international.packed"

echo "==> Target: Windows 64 <=="
wine /fbc-wine/FreeBASIC-1.10.1-winlibs-gcc-9.3.0/fbc64.exe $ADDITIONAL_ARGUMENTS  "Pfeilspiel TNG international.bas"

echo "==> Target: Web aka WASM aka html <=="
fbc -target js-asmjs -Wl "-s ASYNCIFY=1" "Pfeilspiel TNG international.bas"
rm "Pfeilspiel TNG international.html"

echo "==> Target: DOS(Box) <=="
cp "Pfeilspiel TNG international.bas" PF4DOS.BAS
SDL_VIDEODRIVER=dummy dosbox -conf /dosbox.conf
rm PF4DOS.BAS

mkdir /src/bin

echo "==> Target: collect and clean up <=="
mv "Pfeilspiel TNG international" ../bin/Pfeilspiel_TNG_international
mv "Pfeilspiel TNG international.wasm" ../bin/.
mv "Pfeilspiel TNG international.js" ../bin/.
cp "index.html" ../bin/.
mv "Pfeilspiel TNG international.exe" ../bin/Pfeilspiel_TNG_international.exe
mv "Pfeilspiel TNG international.packed" ../bin/Pfeilspiel_TNG_international.packed
mv "PF4DOS.EXE" ../bin/PFEIL.EXE
cp -rf ./fonts ../bin

chmod -R go+rw /src/bin

