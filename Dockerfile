FROM ubuntu:22.04

SHELL ["/bin/bash", "-c"]

RUN apt-get update -qq \
    && apt-get install -y gcc libncurses5-dev libffi-dev libgl1-mesa-dev libx11-dev libxext-dev libxrender-dev libxrandr-dev libxpm-dev wine

RUN apt-get update -qq \
    && apt-get install -y p7zip-full git
    
ADD FreeBASIC-1.10.1-ubuntu-22.04-x86_64.tar.gz /fbc-install/
ADD FreeBASIC-1.10.1-winlibs-gcc-9.3.0.7z /fbc-wine/

WORKDIR /fbc-wine

RUN 7z x ./FreeBASIC-1.10.1-winlibs-gcc-9.3.0.7z
#ADD FreeBASIC-1.07.3-linux-aarch64.tar.xz /fbc-install

#Source: https://github.com/oufm/packelf/blob/master/packelf.sh
ADD packelf.sh /usr/bin
RUN chmod ugo+x /usr/bin/packelf.sh

WORKDIR /fbc-install/FreeBASIC-1.10.1-ubuntu-22.04-x86_64
RUN ls -hal ; ./install.sh -i

RUN apt-get update -qq \
  && apt-get install -y xz-utils make build-essential

RUN mkdir /emsdk

WORKDIR /emsdk
RUN git clone https://github.com/emscripten-core/emsdk.git
RUN git clone https://github.com/freebasic/fbc.git

WORKDIR /emsdk/emsdk
RUN git pull
RUN ./emsdk install latest
RUN ./emsdk activate latest
RUN source ./emsdk_env.sh

ENV PATH=/emsdk/emsdk:/emsdk/emsdk/upstream/emscripten:/emsdk/emsdk/node/16.20.0_64bit/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ENV EMSDK=/emsdk/emsdk
ENV EMSDK_NODE=/emsdk/emsdk/node/16.20.0_64bit/bin/node

WORKDIR /emsdk/fbc
RUN echo $PATH
RUN make rtlib gfxlib2 TARGET=asmjs-unknown-emscripten ENABLE_STANDALONE=1

ENV PATH=/emsdk/fbc:/emsdk/emsdk:/emsdk/emsdk/upstream/emscripten:/emsdk/emsdk/node/16.20.0_64bit/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

WORKDIR /emsdk/fbc/lib/
RUN cp -r fb_rtlib.js fb_shell.html fbextra.x termlib_min.js js-asmjs/ /lib/.
RUN cp -r fb_rtlib.js fb_shell.html fbextra.x termlib_min.js js-asmjs/ /usr/local/lib/freebasic/.
RUN cp -r fb_rtlib.js fb_shell.html fbextra.x termlib_min.js js-asmjs/ /usr/local/include/freebasic/.


#RUN dpkg --add-architecture i386 && apt-get update && apt-get install wine32

WORKDIR /
RUN rm -rf /fbc-install

ADD compile.sh /compile.sh
RUN chmod 777 /compile.sh

RUN apt-get update -qq \
    && apt-get install -y dosbox zip ziptool
    
ADD dosbox.conf /dosbox.conf

RUN mkdir /fbc-dos
WORKDIR /fbc-dos

ADD FreeBASIC-1.10.1-dos.zip /fbc-dos/
RUN unzip /fbc-dos/FreeBASIC-1.10.1-dos.zip
RUN rm /fbc-dos/*.zip
RUN mv /fbc-dos/F* /fbc-dos/fbc

ADD cwsdpmi.zip /fbc-dos/
RUN unzip ./cwsdpmi.zip



ENTRYPOINT /compile.sh
