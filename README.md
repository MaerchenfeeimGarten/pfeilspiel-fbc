# FreeBASIC in Docker zum Bauen von Pfeilspiel TNG international

Dieses Repository enthält eine Dockerfile sowie weitere, benötigte Daten, um das in FreeBasic programmierte ["Pfeilspiel TNG international"](https://codeberg.org/MaerchenfeeimGarten/Pfeilspiel) zu bauen. Und zwar für Windows, Linux, HTML+WASM+JS+CSS sowie DOS.


This repository contains the Dockerfile as well as other data required to build the [Pfeilspiel TNG international"](https://codeberg.org/MaerchenfeeimGarten/Pfeilspiel) programmed in FreeBasic. It compiles for Windows, Linux, HTML+WASM+JS+CSS and DOS.

```
git clone <url of this repo>
git clone https://codeberg.org/MaerchenfeeimGarten/Pfeilspiel
cd <nam of this repo>
docker build -t pfeilspiel-fbc #Bauen des Containers / Build the container
cd ../Pfeilspiel
docker run -it -v ./:/src pfeilspiel-fbc # Nutzung des Containers zum Compilieren des Pfeilspiels / Usage of the container to compile the Pfeilspiel

```
