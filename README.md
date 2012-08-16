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

This example is for building a dummy kernel module against the BeagleBone
3.2.x kernel and includes lots of other assumptions as well. This is simply
meant as an example to fill in some possible points of confusion.

1. Setup Linux host

 Install Ubuntu 12.04 from http://www.ubuntu.com/download/desktop

 I installed the 64-bit version onto a Mac Pro.

 First thing is to install and configure some needed utilities:

 ```bash
 ~$ sudo apt-get install -y git vim openssh-server gcc-arm-linux-gnueabi
 ~$ git config --global user.email "jdk@ti.com"
 ~$ git config --global user.name "Jason Kridner"
 ```

2. Download, configure and build kernel

 In this example, I am using a particular patch revision version for the
 beaglebone 3.2.x kernel.

 ```bash
 ~$ git clone git://github.com/beagleboard/kernel.git
 ~$ cd kernel
 ~/kernel$ git checkout 6a7c4284a16fed3dae87f4aef78b59c902e4da84 -b beaglebone-3.2
 ~/kernel$ ./patch.sh
 ~/kernel$ cp patches/beaglebone/defconfig kernel/arch/arm/configs/beaglebone_defconfig
 ~/kernel$ cd kernel
 ~/kernel$ export ARCH=arm
 ~/kernel$ export CROSS_COMPILE=arm-linux-gnueabi-
 ~/kernel/kernel$ make beaglebone_defconfig
 ~/kernel/kernel$ make
 ```

