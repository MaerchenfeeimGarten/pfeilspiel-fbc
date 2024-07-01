<!---
#
# SPDX-FileCopyrightText: 2023 - 2024 MaerchenfeeimGarten
# 
# SPDX-License-Identifier:  AGPL-3.0-only
#
--->

# DE: FreeBASIC in Docker zum Bauen von Pfeilspiel TNG international
# EN: FreeBASIC inside Docker for building Pfeilspiel TNG international

Dieses Repository enthält eine Dockerfile sowie weitere, benötigte Daten, um das in FreeBasic programmierte ["Pfeilspiel TNG international"](https://codeberg.org/MaerchenfeeimGarten/Pfeilspiel) zu bauen. Und zwar für Windows, Linux, HTML+WASM+JS+CSS sowie DOS.


This repository contains the Dockerfile as well as other data required to build the [Pfeilspiel TNG international"](https://codeberg.org/MaerchenfeeimGarten/Pfeilspiel) programmed in FreeBasic. It compiles for Windows, Linux, HTML+WASM+JS+CSS and DOS.

```
git clone <URL dieses Git-Repositories / url of this git repo >
git clone https://codeberg.org/MaerchenfeeimGarten/Pfeilspiel
cd <Name dieses Git-Repositories / name of this git repo >
docker build -t pfeilspiel-fbc #Bauen des Containers / Build the container
cd ../Pfeilspiel
docker run -it -v ./:/src pfeilspiel-fbc # Nutzung des Containers zum Compilieren des Pfeilspiels / Usage of the container to compile the Pfeilspiel
cd bin # Ordner öffnen, der die gebauten Programmdateien enthält / go to the folder containing the program files build
```
