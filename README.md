# FreeBASIC in Docker

This repository contains a Dockerfile that allows you to build an Ubuntu container which includes FreeBASIC preinstalled. 

It includes:

  - a Linux 64bit compiler `fbc <program.bas>`
  - a Windows 64bit compiler `wine /fbc-wine/FreeBASIC-1.10.1-winlibs-gcc-9.3.0/fbc64.exe <program.bas>`
  - WASM/emscripten/js target compatibility `fbc -target js-asmjs -Wl "-s ASYNCIFY=1" <program.bas>`
  - a packer to pack all the needed linux libraries into the linux binary: `packelf.sh <program.compiled> <program.compiled.packed>`

To build the container:
  - `docker build ./ -t pfeilspielcompiler`

To run the container:
  - `cd <path_where_the_source_code_is>`
  - `docker run -it -v ./:/src pfeilspielcompiler`
