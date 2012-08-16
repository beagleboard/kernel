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

This example is for building the BeagleBone 3.2.x kernel and includes lots
of other assumptions as well. This is simply meant as an example to fill in
some possible points of confusion.

1. Setup Linux host

 Install Ubuntu 12.04 from http://www.ubuntu.com/download/desktop

 I installed the 64-bit version onto a Mac Pro.

 First thing is to install and configure some needed utilities:

 ```bash
 ~$ sudo apt-get install -y git vim openssh-server
 ~$ git config --global user.email "jdk@ti.com"
 ~$ git config --global user.name "Jason Kridner"
 ```

2. Setup toolchain

 Install Angstrom Distribution toolchain from http://www.angstrom-distribution.org/toolchains

 I installed the 64-bit toolchain with qte tools dated 18-Mar-2011 with an
 md5sum of b0737d1865d2f0787463de19b81ba180.

 ```bash
 ~$ wget http://www.angstrom-distribution.org/toolchains/angstrom-2011.03-x86_64-linux-armv7a-linux-gnueabi-toolchain-qte-4.6.3.tar.bz2
 ~$ md5sum angstrom-2011.03-x86_64-linux-armv7a-linux-gnueabi-toolchain-qte-4.6.3.tar.bz2 
 b0737d1865d2f0787463de19b81ba180  angstrom-2011.03-x86_64-linux-armv7a-linux-gnueabi-toolchain-qte-4.6.3.tar.bz2
 ~$ sudo tar xjf angstrom-2011.03-x86_64-linux-armv7a-linux-gnueabi-toolchain-qte-4.6.3.tar.bz2 -C /
 ~$ source /usr/local/angstrom/arm/environment-setup 
 ~$ echo 'source /usr/local/angstrom/arm/environment-setup' >> ~/.bashrc
 ```

3. Download, configure and build kernel

 In this example, I am using a particular patch revision version for the
 beaglebone 3.2.x kernel.

 ```bash
 ~$ git clone git://github.com/beagleboard/kernel.git
 ~$ cd kernel
 ~/kernel$ git checkout 6a7c4284a16fed3dae87f4aef78b59c902e4da84 -b beaglebone-3.2
 ~/kernel$ ./patch.sh
 ~/kernel$ cp patches/beaglebone/defconfig kernel/.config
 ~/kernel$ cd kernel
 ~/kernel/kernel$ ARCH=arm CROSS_COMPILE=$TARGET_SYS- make
 ```

 At this point I experienced http://pastebin.com/1S1TCzt4, so I dumped the
 Angstrom toolchain that I had chosen above.
