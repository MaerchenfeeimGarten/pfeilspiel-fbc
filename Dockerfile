FROM ubuntu:22.04

SHELL ["/bin/bash", "-c"]

RUN apt-get update -qq \
    && apt-get install -y gcc libncurses5-dev libffi-dev libgl1-mesa-dev libx11-dev libxext-dev libxrender-dev libxrandr-dev libxpm-dev wine

RUN apt-get update -qq \
    && apt-get install -y p7zip-full
    
ADD FreeBASIC-1.10.0-ubuntu-22.04-x86_64.tar.gz /fbc-install/
ADD FreeBASIC-1.10.0-winlibs-gcc-9.3.0.7z /fbc-wine/

WORKDIR /fbc-wine

#RUN 7z e ./FreeBASIC-1.10.0-winlibs-gcc-9.3.0.7z
#ADD FreeBASIC-1.07.3-linux-aarch64.tar.xz /fbc-install

#Source: https://github.com/oufm/packelf/blob/master/packelf.sh
ADD packelf.sh /usr/bin
RUN chmod ugo+x /usr/bin/packelf.sh


WORKDIR /fbc-install/FreeBASIC-1.10.0-ubuntu-22.04-x86_64
RUN ls -hal ; ./install.sh -i

WORKDIR /
RUN rm -rf /fbc-install
