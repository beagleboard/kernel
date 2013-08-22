kernel
======

Kernel for the beagleboard.org boards

usage
======

3.8 patchset:

```
git checkout origin/3.8 -b 3.8
./patch.sh
```

Get am335x-pm-firmware.bin from http://arago-project.org/git/projects/?p=am33x-cm3.git;a=tree;f=bin and copy it to kernel/firmware

To build it:

```
cd kernel
cp ../configs/beaglebone .config
make ARCH=arm CROSS_COMPILE=arm-xxxx-linux-gnueabi- uImage dtbs
```

copy over uImage and am335x-bone.dtb to /boot

uEnv.txt for the angstrom u-boot 2012.10:

```
devtree=/boot/am335x-bone.dtb
dtboot=run mmcargs; ext2load mmc ${mmcdev}:2 ${kloadaddr} ${bootfile} ; ext2load mmc ${mmcdev}:2 ${fdtaddr} ${devtree} ; bootm ${kloadaddr} - ${fdtaddr}
uenvcmd=run dtboot
optargs=consoleblank=0
```

uEnv.txt for vanilla u-boot 2012.10:

```
devtree=/boot/am335x-bone.dtb
dtboot=run mmcargs; ext2load mmc ${mmcdev}:2 ${loadaddr} ${bootfile} ; ext2load mmc ${mmcdev}:2 ${fdtaddr} ${devtree} ; bootm ${loadaddr} - ${fdtaddr}
uenvcmd=run dtboot
optargs=consoleblank=0
```

Status
======

 * I2C: working
 * SPI: working
 * MMC: mmc1 working, mmc2 working
 * USB host: working, replugging needs 'lsusb' to pick new devices, unless you use a hub in between
 * USB gadget: working
 * LCDC: working
 * TS: working
 * ADC: working
 * PWM: ehrpwm and ecap working
 * PMIC: working
 * PMIC PWM: working, kills ethernet
 * CPUfreq: working
 * Capes: Almost all, check firmware/capes
 * AUDIO: working, HDMI audio working as well

Bootlog
======

```
U-Boot SPL 2012.10-rc3-00001-gf260a85 (Oct 12 2012 - 21:44:47)
OMAP SD/MMC: 0
reading u-boot.img
reading u-boot.img


U-Boot 2012.10-rc3-00001-gf260a85 (Oct 12 2012 - 21:44:47)

I2C:   ready
DRAM:  256 MiB
WARNING: Caches not enabled
MMC:   OMAP SD/MMC: 0, OMAP SD/MMC: 1
Using default environment

Net:   cpsw
Hit any key to stop autoboot:  0 
SD/MMC found on device 0
reading uEnv.txt

232 bytes read
Loaded environment from uEnv.txt
Importing environment from mmc ...
Running uenvcmd ...
Loading file "/boot/uImage" from mmc device 0:2
3761392 bytes read
Loading file "/boot/am335x-bone.dtb" from mmc device 0:2
18975 bytes read
## Booting kernel from Legacy Image at 80007fc0 ...
   Image Name:   Linux-3.7.0-rc2
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    3761328 Bytes = 3.6 MiB
   Load Address: 80008000
   Entry Point:  80008000
   Verifying Checksum ... OK
## Flattened Device Tree blob at 80f80000
   Booting using the fdt blob at 0x80f80000
   XIP Kernel Image ... OK
OK
   Loading Device Tree to 8fe63000, end 8fe6aa1e ... OK
```

```
Starting kernel ...

[    0.059015] omap-gpmc omap-gpmc: failed to reserve memory
[    0.375284] tps65217-bl tps65217-bl: no platform data provided
[    0.512706] capebus bone:0: bone: Failed to read EEPROM at slot 0 (addr 0x54)
[    0.567255] capebus bone:0: bone: Failed to read EEPROM at slot 1 (addr 0x55)
[    0.718152] drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
systemd-fsck[72]: Angstrom-Cloud9-: clean, 30760/247504 files, 311621/988774 blocks

.---O---.
|       |                  .-.           o o
|   |   |-----.-----.-----.| |   .----..-----.-----.
|       |     | __  |  ---'| '--.|  .-'|     |     |
|   |   |  |  |     |---  ||  --'|  |  |  '  | | | |
'---'---'--'--'--.  |-----''----''--'  '-----'-'-'-'
                -'  |
                '---'

The Angstrom Distribution bone-mainline ttyO0

Angstrom v2012.10 - Kernel 3.7.0-rc2

bone-mainline login:
```

