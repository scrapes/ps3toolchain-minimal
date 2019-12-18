FROM ubuntu:18.04
MAINTAINER Anton Scharnowski <a.scharnowski@thewavenetwork.com>

ENV PS3DEV /usr/local/ps3dev
ENV PSL1GHT ${PS3DEV}
ENV PATH ${PATH}:${PS3DEV}/bin:${PS3DEV}/ppu/bin:${PS3DEV}/spu/bin

RUN \
  apt-get -y update && \
  apt-get -y install autoconf bison build-essential flex git libelf-dev libgmp3-dev libncurses5-dev libssl-dev libtool-bin pkg-config python-dev texinfo wget zlib1g-dev && \
  apt-get -y clean autoclean autoremove && \
  rm -rf /var/lib/{apt,dpkg,cache,log}/

##Add Toolchain
ADD toolchain.sh toolchain.sh
ADD depends depends
ADD patches patches
ADD scripts scripts

RUN bash toolchain.sh -d
RUN bash toolchain.sh -s

WORKDIR /build
