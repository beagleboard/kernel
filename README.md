kernel
======

Kernel for the beagleboard.org boards

usage
======

beaglebone-3.6 patchset:

git checkout origin/beaglebone-3.6 -b beaglebone-3.6
./patch.sh

To build it:

cd kernel && make uImage-dtb.am335x-bone

