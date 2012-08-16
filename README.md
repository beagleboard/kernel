kernel
======

Kernel for the beagleboard.org boards

usage
======

beaglebone-3.2 patchset:

git checkout origin/beaglebone-3.2 -b beaglebone-3.2

./patch.sh

detailed usage (cross compilation)
==============

1. Setup Linux host

 Install Ubuntu 12.04 from http://www.ubuntu.com/download/desktop

 I installed the 64-bit version onto a Mac Pro.

 First thing is to install and configure some needed utilities:

     $ sudo apt-get install -y git vim
     $ git config --global user.email "jdk@ti.com"
     $ git config --global user.name "Jason Kridner"

2. Setup toolchain

 Install Angstrom Distribution toolchain from http://www.angstrom-distribution.org/toolchains

 I installed the 64-bit toolchain with qte tools dated 18-Mar-2011 with an
 md5sum of b0737d1865d2f0787463de19b81ba180.

     $ wget http://www.angstrom-distribution.org/toolchains/angstrom-2011.03-x86_64-linux-armv7a-linux-gnueabi-toolchain-qte-4.6.3.tar.bz2
     $ md5sum angstrom-2011.03-x86_64-linux-armv7a-linux-gnueabi-toolchain-qte-4.6.3.tar.bz2 
     b0737d1865d2f0787463de19b81ba180  angstrom-2011.03-x86_64-linux-armv7a-linux-gnueabi-toolchain-qte-4.6.3.tar.bz2
     $ sudo tar xjf angstrom-2011.03-x86_64-linux-armv7a-linux-gnueabi-toolchain-qte-4.6.3.tar.bz2 -C /
     $ source /usr/local/angstrom/arm/environment-setup 
     $ echo 'source /usr/local/angstrom/arm/environment-setup' >> ~/.bashrc

3. Download, configure and build kernel

    $ git clone git@github.com:beagleboard/kernel.git

