#!/bin/sh -e
# binutils-PPU.sh by Naomi Peori (naomi@peori.ca)

BINUTILS="binutils-2.22"

if [ ! -d ${BINUTILS} ]; then

  ## Download the source code.
  if [ ! -f ${BINUTILS}.tar.bz ]; then wget --continue https://ftp.gnu.org/gnu/binutils/${BINUTILS}.tar.bz2; fi

  ## Download an up-to-date config.guess and config.sub
  if [ ! -f config.guess ]; then wget -O config.guess 'https://git.savannah.gnu.org/gitweb/?p=config.git;a=blob_plain;f=config.guess;hb=HEAD'; fi
  if [ ! -f config.sub ]; then wget -O config.sub 'https://git.savannah.gnu.org/gitweb/?p=config.git;a=blob_plain;f=config.sub;hb=HEAD'; fi

  ## Unpack the source code.
  tar xfvj ${BINUTILS}.tar.bz2

  ## Patch the source code.
  cat ../patches/${BINUTILS}-PS3.patch | patch -p1 -d ${BINUTILS}

  ## Replace config.guess and config.sub
  cp config.guess config.sub ${BINUTILS}

fi

if [ ! -d ${BINUTILS}/build-ppu ]; then

  ## Create the build directory.
  mkdir ${BINUTILS}/build-ppu

fi

## Enter the build directory.
cd ${BINUTILS}/build-ppu

## Configure the build.
../configure --prefix="$PS3DEV/ppu" --target="powerpc64-ps3-elf" \
    --disable-nls \
    --disable-shared \
    --disable-debug \
    --disable-dependency-tracking \
    --disable-werror \
    --enable-64-bit-bfd \
    --with-gcc \
    --with-gnu-as \
    --with-gnu-ld

## Compile and install.
${MAKE:-make} -j 4 && ${MAKE:-make} install
