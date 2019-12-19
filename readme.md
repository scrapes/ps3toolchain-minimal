
# 1. What does this do?
This Container builds upon the OpenSource ps3toolchain that houses a GCC Compiler
for the PPU and SPU as well as tools to sign and pack Projects to execute it directly
on the PS3.

Attention: this is minimal version of this toolkit, it was intended for libary production. 
The GDB(s) for PPU and SPU as well as the ps3libraries got stripped. This reduces the build time a bit.

# 2. Usage

You can clone this Repo and build it with docker build command:
```
docker build -t ps3toolchain-minimal .
```

After this you can use the image with:

```
docker run -v `pwd`:/build ps3toolchain-minimal [COMMAND]
```


If you want to skip building the Image (wich takes up to more than 30-45min.) you can pull the image from DockerHub.
To do this make:

```
docker pull scrapes/ps3toolchain-minimal
```

then use the toolchain with

```
docker run -v `pwd`:/build scrapes/ps3toolchain-minimal [COMMAND]
```

The command pallete of this Container contains the `make` command 
as well as all PSL1GHT tools such as fself.py.


# 3. Have fun Exploring and Building!!!

# 1-1. Dont want Docker?
If you wish to install this toolchain yourself, then do the following instructions:
NOTE: These instructions should work for Linux/Mac/MinGW but are only tested on Linux

 1) Set up your environment by installing the following software:
 
  ```
  autoconf, automake, bison, flex, gcc, libelf, make, makeinfo,
  ncurses, patch, python, subversion, wget, zlib, libtool, python,
  bzip2, gmp, pkg-config
  ```
  
  
 2) Add the following to your login script:

```
  export PS3DEV=/usr/local/ps3dev
  export PSL1GHT=$PS3DEV
  export PATH=$PATH:$PS3DEV/bin
  export PATH=$PATH:$PS3DEV/ppu/bin
  export PATH=$PATH:$PS3DEV/spu/bin
```

 3) Run the toolchain script:

```
  ./toolchain.sh
```
