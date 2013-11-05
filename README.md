kernel
======

Kernel for the beagleboard.org boards

usage
======

3.13 patchset:

```
git checkout origin/3.13 -b 3.13
./patch.sh
```

To build it:

```
cd kernel
cp ../configs/beaglebone .config
make ARCH=arm LOADADDR=0x80008000 uImage dtbs
```

copy over zImage, uImage, am335x-bone.dtb, and am335x-boneblack.dtb to /boot (on the large ext4 partition)

Status
======

 * I2C: working
 * SPI: working
 * MMC: mmc1 working, mmc2 working
 * USB host: working
 * USB gadget: working: usb eth, usb drive
 * HDMI: working
 * LCDC: lcd3/lcd4/lcd7/dvi: untested
 * TS: untested
 * ADC: untested
 * PWM: untested
 * PMIC: untested
 * PMIC PWM: untested
 * CPUfreq: not working
 * Capes: untested
 * AUDIO: untested

Bootlog (needs update)
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

