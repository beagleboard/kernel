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
 ~$ sudo apt-get install -y git lzop gcc-arm-linux-gnueabi uboot-mkimage
 ~$ git config --global user.email "jkridner@example.com"
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
 ~/kernel$ wget http://arago-project.org/git/projects/?p=am33x-cm3.git\;a=blob_plain\;f=bin/am335x-pm-firmware.bin\;hb=HEAD -O kernel/firmware/am335x-pm-firmware.bin
 ~/kernel$ md5sum kernel/firmware/am335x-pm-firmware.bin 
 17d6a4c24d3cb720aa9ed4522cb891fc  kernel/firmware/am335x-pm-firmware.bin
 ~/kernel$ export ARCH=arm
 ~/kernel$ export CROSS_COMPILE=arm-linux-gnueabi-
 ~/kernel$ cd kernel
 ~/kernel/kernel$ make beaglebone_defconfig
 ~/kernel/kernel$ make -j4
 ~/kernel/kernel$ make uImage
 ~/kernel/kernel$ mkdir ~/kernel/rootfs
 ~/kernel/kernel$ make INSTALL_MOD_PATH=~/kernel/rootfs modules_install
 ~/kernel/kernel$ cd
 ```

3. Install the kernel

 ```bash
 ~/$ scp kernel/kernel/arch/arm/boot/uImage root@beaglebone.local:/boot/uImage-3.2.25+
 ~/$ cd kernel/rootfs
 ~/kernel/rootfs$ find -H -depth | cpio -o -H crc | ssh root@beaglebone.local 'cd /; cpio -i'
 ~/kernel/rootfs$ cd
 ~/$ ssh root@beaglebone.local 'cd /boot; rm uImage'
 ~/$ ssh root@beaglebone.local 'cd /boot; ln -s uImage-3.2.25+ uImage'
 ~/$ ssh root@beaglebone.local 'mount /dev/mmcblk0p1 /mnt'
 ~/$ ssh root@beaglebone.local 'cp /boot/uImage-3.2.25+ /mnt/uImage'
 ```

 Reboot the board.

 ```bash
 ~/$ ssh root@beaglebone.local 'uname -a'
 Linux beaglebone 3.2.25+ #1 Thu Aug 16 01:23:21 EDT 2012 armv7l GNU/Linux
 ```

4. Build and run "Hello World" kernel module

 This is borrowed from https://groups.google.com/d/topic/beagleboard/BKnNkP3qzQs/discussion

 ```bash
 ~/$ mkdir hello; cd hello
 ```

 ~/hello/hello.c
 ```c
 #include <linux/module.h>       /* Needed by all modules */
 #include <linux/kernel.h>       /* Needed for KERN_INFO */
 #include <linux/init.h>         /* Needed for the macros */
 
 static int __init hello_start(void)
 {
 printk(KERN_INFO "Loading hello module...\n");
 printk(KERN_INFO "Hello world\n");
 return 0;
 }
 
 static void __exit hello_end(void)
 {
 printk(KERN_INFO "Goodbye Mr.\n");
 }

 module_init(hello_start);
 module_exit(hello_end);
 ```

 ~/hello/Makefile
 ```Makefile
 obj-m := hello.o

 KDIR  := ${HOME}/kernel/rootfs/lib/modules/3.2.25+/build
 PWD   := ${HOME}/hello

 default:
 	make -C $(KDIR) SUBDIRS=$(PWD) modules
 ```

 ```bash
 ~/hello$ make
 ~/hello$ scp hello.ko root@beaglebone.local:
 ~/hello$ ssh root@beaglebone.local '/sbin/insmod ./hello.ko; dmesg | tail'
 [  826.052825] hello: module license 'unspecified' taints kernel.
 [  826.052856] Disabling lock debugging due to kernel taint
 [  826.053741] Loading hello module...
 [  826.053771] Hello world
 ```

