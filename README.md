kernel
======

Kernel for the beagleboard.org boards

usage
======

3.12 patchset:

```
git checkout origin/3.12 -b 3.12
./patch.sh
```

To build it:

```
cd kernel
cp ../configs/beaglebone .config
make ARCH=arm LOADADDR=0x80008000 uImage dtbs
make ARCH=arm LOADADDR=0x80008000 modules
```

copy over zImage, uImage, am335x-bone.dtb, and am335x-boneblack.dtb to /boot (on the large ext4 partition)
install modules in /lib/modules/ (on the large ext4 partition)

Status
======

 * I2C: working
 * SPI: working
 * MMC: mmc1 working, mmc2 working
 * USB host: working
 * USB gadget: working: usb eth, usb drive, CDC ACM
 * HDMI: working
 * LCDC: lcd3/lcd4/lcd7/dvi: untested
 * TS: untested
 * ADC: untested
 * PWM: untested
 * PMIC: untested
 * PMIC PWM: untested
 * CPUfreq: working: https://github.com/beagleboard/kernel/commit/f803c5b206df66683046d2d6f5be545168faf85a
 * Capes: untested
 * AUDIO: untested
 * PowerDown: broken, device remains on after [halt]

Bootlog (needs update)
======

```
U-Boot 2013.04-dirty (Jun 19 2013 - 09:57:14)

I2C:   ready
DRAM:  512 MiB
WARNING: Caches not enabled
NAND:  No NAND device found!!!
0 MiB
MMC:   OMAP SD/MMC: 0, OMAP SD/MMC: 1
*** Warning - readenv() failed, using default environment

musb-hdrc: ConfigData=0xde (UTMI-8, dyn FIFOs, HB-ISO Rx, HB-ISO Tx, SoftConn)
musb-hdrc: MHDRC RTL version 2.0
musb-hdrc: setup fifo_mode 4
musb-hdrc: 28/31 max ep, 16384/16384 memory
USB Peripheral mode controller at 47401000 using PIO, IRQ 0
musb-hdrc: ConfigData=0xde (UTMI-8, dyn FIFOs, HB-ISO Rx, HB-ISO Tx, SoftConn)
musb-hdrc: MHDRC RTL version 2.0
musb-hdrc: setup fifo_mode 4
musb-hdrc: 28/31 max ep, 16384/16384 memory
USB Host mode controller at 47401800 using PIO, IRQ 0
Net:   <ethaddr> not set. Validating first E-fuse MAC
cpsw, usb_ether
Hit any key to stop autoboot:  0
gpio: pin 53 (gpio 53) value is 1
mmc0 is current device
micro SD card found
mmc0 is current device
gpio: pin 54 (gpio 54) value is 1
SD/MMC found on device 0
reading uEnv.txt
14 bytes read in 3 ms (3.9 KiB/s)
Loaded environment from uEnv.txt
Importing environment from mmc ...
gpio: pin 55 (gpio 55) value is 1
4403664 bytes read in 761 ms (5.5 MiB/s)
gpio: pin 56 (gpio 56) value is 1
24692 bytes read in 29 ms (831.1 KiB/s)
Booting from mmc ...
## Booting kernel from Legacy Image at 80007fc0 ...
   Image Name:   Linux-3.12.0-00080-g12cbe01
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    4403600 Bytes = 4.2 MiB
   Load Address: 80008000
   Entry Point:  80008000
   Verifying Checksum ... OK
## Flattened Device Tree blob at 80f80000
   Booting using the fdt blob at 0x80f80000
   XIP Kernel Image ... OK
OK
   Using Device Tree in place at 80f80000, end 80f89073
```

```
Starting kernel ...

[    0.284222] bone-capemgr bone_capemgr.6: slot #0: No cape found
[    0.328219] bone-capemgr bone_capemgr.6: slot #1: No cape found
[    0.372218] bone-capemgr bone_capemgr.6: slot #2: No cape found
[    0.416218] bone-capemgr bone_capemgr.6: slot #3: No cape found
[    0.432399] musb-hdrc musb-hdrc.0.auto: Falied to request rx1.
[    0.443835] musb-hdrc musb-hdrc.1.auto: Falied to request rx1.
[    7.081317] bone-capemgr bone_capemgr.6: failed to load firmware 'BB-BONE-EMMC-2G-00A0.dtbo'
[    7.090417] bone-capemgr bone_capemgr.6: loader: failed to load slot-4 BB-BONE-EMMC-2G:00A0 (prio 1)

.---O---.
|       |                  .-.           o o
|   |   |-----.-----.-----.| |   .----..-----.-----.
|       |     | __  |  ---'| '--.|  .-'|     |     |
|   |   |  |  |     |---  ||  --'|  |  |  '  | | | |
'---'---'--'--'--.  |-----''----''--'  '-----'-'-'-'
                -'  |
                '---'

The Angstrom Distribution beaglebone ttyO0

Angstrom v2012.12 - Kernel 3.12.0-00080-g12cbe01

beaglebone login:
```

