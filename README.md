kernel
======

Kernel for the beagleboard.org boards

usage
======

3.7 patchset:

git checkout origin/3.7 -b 3.7
./patch.sh

To build it:

cd kernel
make uImage dtbs

copy over uImage and am335x-bone.dtb to /boot

uEnv.txt:

devtree=/boot/am335x-bone.dtb
dtboot=run mmcargs; ext2load mmc ${mmcdev}:2 ${kloadaddr} ${bootfile} ; ext2load mmc ${mmcdev}:2 ${fdtaddr} ${devtree} ; bootm ${kloadaddr} - ${fdtaddr}
uenvcmd=run dtboot
optargs=consoleblank=0

Status
======

I2C: working
SPI: untested
MMC: mmc1 working, mmc2 untested, mmc3 need crossbar support in the EDMA driver
USB host: only mass storage
USB gadget: untested
LCDC: no DT support
TS: no DT support
ADC: no DT support
PWM: untested
PMIC: working
PMIC PWM: working, needs DT entry
CPUfreq: working
Capes: none work

Bootlog
======

```
## Booting kernel from Legacy Image at 80007fc0 ...
   Image Name:   Linux-3.5.0-rc6-12265-g4361219
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    3739468 Bytes = 3.6 MiB
   Load Address: 80008000
   Entry Point:  80008000
   Verifying Checksum ... OK
   XIP Kernel Image ... OK
OK 

Starting kernel ...

[    0.000000] Booting Linux on physical CPU 0
[    0.000000] Linux version 3.5.0-rc6-12265-g4361219 (koen@Angstrom-F16-vm-rpm) (gcc version 4.5.4 20120305 (prerelease) (GCC) ) #9 SMP Tue Jul 24 15:11:06 CEST 2012
[    0.000000] CPU: ARMv7 Processor [413fc082] revision 2 (ARMv7), cr=10c53c7d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
[    0.000000] Machine: Generic AM33XX (Flattened Device Tree), model: TI AM335x BeagleBone
[    0.000000] Memory policy: ECC disabled, Data cache writeback
[    0.000000] PERCPU: Embedded 8 pages/cpu @c0eda000 s11520 r8192 d13056 u32768
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 64768
[    0.000000] Kernel command line: console=ttyO0,115200n8 run_hardware_tests root=/dev/mmcblk0p2 ro rootfstype=ext4 rootwait ip=none
[    0.000000] PID hash table entries: 1024 (order: 0, 4096 bytes)
[    0.000000] Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
[    0.000000] Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
[    0.000000] Memory: 245676k/245676k available, 16468k reserved, 0K highmem
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
[    0.000000]     vmalloc : 0xd0800000 - 0xff000000   ( 744 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xd0000000   ( 256 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
[    0.000000]       .text : 0xc0008000 - 0xc0683cd4   (6640 kB)
[    0.000000]       .init : 0xc0684000 - 0xc06d2d00   ( 316 kB)
[    0.000000]       .data : 0xc06d4000 - 0xc07766c8   ( 650 kB)
[    0.000000]        .bss : 0xc07766ec - 0xc0cd0f08   (5483 kB)
[    0.000000] Hierarchical RCU implementation.
[    0.000000] NR_IRQS:474
[    0.000000] IRQ: Found an INTC at 0xfa200000 (revision 5.0) with 128 interrupts
[    0.000000] Total of 128 interrupts on 1 active controller
[    0.000000] OMAP clockevent source: GPTIMER1 at 24000000 Hz
[    0.000000] sched_clock: 32 bits at 24MHz, resolution 41ns, wraps every 178956ms
[    0.000000] OMAP clocksource: GPTIMER2 at 24000000 Hz
[    0.000000] Console: colour dummy device 80x30
[    0.000000] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
[    0.000000] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.000000] ... MAX_LOCK_DEPTH:          48
[    0.000000] ... MAX_LOCKDEP_KEYS:        8191
[    0.000000] ... CLASSHASH_SIZE:          4096
[    0.000000] ... MAX_LOCKDEP_ENTRIES:     16384
[    0.000000] ... MAX_LOCKDEP_CHAINS:      32768
[    0.000000] ... CHAINHASH_SIZE:          16384
[    0.000000]  memory used by lock dependency info: 3695 kB
[    0.000000]  per task-struct memory footprint: 1152 bytes
[    0.107334] pid_max: default: 32768 minimum: 301
[    0.108217] Security Framework initialized
[    0.108532] Mount-cache hash table entries: 512
[    0.118508] CPU0: thread -1, cpu 0, socket -1, mpidr 0
[    0.118595] Setting up static identity map for 0x804ac358 - 0x804ac3c8
[    0.120600] Brought up 1 CPUs
[    0.120631] SMP: Total of 1 processors activated (330.83 BogoMIPS).
[    0.151189] dummy:
[    0.153843] NET: Registered protocol family 16
[    0.154620] GPMC revision 6.0
[    0.154919] gpmc: irq-20 could not claim: err -22
[    0.183495] OMAP GPIO hardware version 0.1
[    0.203494] hw-breakpoint: debug architecture 0x4 unsupported.
[    0.291298] bio: create slab <bio-0> at 0
[    0.403920] omap-dma-engine omap-dma-engine: OMAP DMA engine driver
[    0.411619] SCSI subsystem initialized
[    0.415223] usbcore: registered new interface driver usbfs
[    0.415894] usbcore: registered new interface driver hub
[    0.416917] usbcore: registered new device driver usb
[    0.436433] omap_i2c i2c.13: bus -1 rev2.4.0 at 100 kHz
[    0.451441] omap_i2c i2c.14: bus -1 rev2.4.0 at 100 kHz
[    0.466986] omap_i2c i2c.15: bus -1 rev2.4.0 at 100 kHz
[    0.477576] Switching to clocksource gp_timer
[    0.639310] NET: Registered protocol family 2
[    0.640397] IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.643558] TCP established hash table entries: 8192 (order: 4, 65536 bytes)
[    0.644099] TCP bind hash table entries: 8192 (order: 6, 294912 bytes)
[    0.649505] TCP: Hash tables configured (established 8192 bind 8192)
[    0.649603] TCP: reno registered
[    0.649641] UDP hash table entries: 256 (order: 2, 20480 bytes)
[    0.650127] UDP-Lite hash table entries: 256 (order: 2, 20480 bytes)
[    0.651280] NET: Registered protocol family 1
[    0.653116] RPC: Registered named UNIX socket transport module.
[    0.653144] RPC: Registered udp transport module.
[    0.653161] RPC: Registered tcp transport module.
[    0.653177] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.654455] NetWinder Floating Point Emulator V0.97 (double precision)
[    0.870139] VFS: Disk quotas dquot_6.5.2
[    0.870584] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[    0.874124] NFS: Registering the id_resolver key type
[    0.874715] Key type id_resolver registered
[    0.876421] jffs2: version 2.2. (NAND) (SUMMARY)  © 2001-2006 Red Hat, Inc.
[    0.878283] msgmni has been set to 479
[    0.882599] io scheduler noop registered
[    0.882632] io scheduler deadline registered
[    0.882963] io scheduler cfq registered (default)
[    0.886321] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.895122] serial.7: ttyO0 at MMIO 0x44e09000 (irq = 72) is a OMAP UART0
[    1.419181] console [ttyO0] enabled
[    1.425060] serial.8: ttyO1 at MMIO 0x48022000 (irq = 73) is a OMAP UART1
[    1.434417] serial.9: ttyO2 at MMIO 0x48024000 (irq = 74) is a OMAP UART2
[    1.443590] serial.10: ttyO3 at MMIO 0x481a6000 (irq = 44) is a OMAP UART3
[    1.453077] omap_uart serial.11: [UART-1]: failure [serial_omap_probe]: -22
[    1.460687] omap_uart: probe of serial.11 failed with error -22
[    1.467463] omap_uart serial.12: [UART-1]: failure [serial_omap_probe]: -22
[    1.474996] omap_uart: probe of serial.12 failed with error -22
[    1.521599] brd: module loaded
[    1.549756] loop: module loaded
[    1.560709] mtdoops: mtd device (mtddev=name/number) must be supplied
[    1.569076] OneNAND driver initializing
[    1.583258] usbcore: registered new interface driver asix
[    1.590023] usbcore: registered new interface driver cdc_ether
[    1.597090] usbcore: registered new interface driver smsc95xx
[    1.603919] usbcore: registered new interface driver net1080
[    1.610446] usbcore: registered new interface driver cdc_subset
[    1.617439] usbcore: registered new interface driver zaurus
[    1.624132] usbcore: registered new interface driver cdc_ncm
[    1.632783] usbcore: registered new interface driver cdc_wdm
[    1.638907] Initializing USB Mass Storage driver...
[    1.644795] usbcore: registered new interface driver usb-storage
[    1.651278] USB Mass Storage support registered.
[    1.657490] usbcore: registered new interface driver libusual
[    1.664452] usbcore: registered new interface driver usbtest
[    1.670542] musb-hdrc: version 6.0, ?dma?, otg (peripheral+host)
[    1.680698] musb-hdrc musb-hdrc.0: USB OTG mode controller at d08be000 using PIO, IRQ 18
[    1.690474] musb-hdrc musb-hdrc.1: MUSB HDRC host driver
[    1.698895] musb-hdrc musb-hdrc.1: new USB bus registered, assigned bus number 1
[    1.707809] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    1.715018] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.722647] usb usb1: Product: MUSB HDRC host driver
[    1.727856] usb usb1: Manufacturer: Linux 3.5.0-rc6-12265-g4361219 musb-hcd
[    1.735206] usb usb1: SerialNumber: musb-hdrc.1
[    1.745300] hub 1-0:1.0: USB hub found
[    1.749479] hub 1-0:1.0: 1 port detected
[    1.756260] musb-hdrc musb-hdrc.1: USB Host mode controller at d08c0800 using PIO, IRQ 19
[    1.767948] mousedev: PS/2 mouse device common for all mice
[    1.779781] i2c /dev entries driver
[    1.788277] Driver for 1-wire Dallas network protocol.
[    1.803067] usbcore: registered new interface driver usbhid
[    1.809234] dsps_interrupt 374: VBUS error workaround (delay coming)
[    1.816307] usbhid: USB HID core driver
[    1.820334] oprofile: hardware counters not available
[    1.825692] oprofile: using timer interrupt.
[    1.831358] TCP: cubic registered
[    1.834856] Initializing XFRM netlink socket
[    1.839595] NET: Registered protocol family 17
[    1.844387] NET: Registered protocol family 15
[    1.849624] Key type dns_resolver registered
[    1.854708] VFP support v0.3: implementor 41 architecture 3 part 30 variant c rev 3
[    1.862947] ThumbEE CPU extension supported.
[    1.880778] clock: disabling unused clocks to save power
[    1.894464] drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
[    1.905677] Waiting for root device /dev/mmcblk0p2...

	<hang>
```

```
Booting from USB:

root@beaglebone:~# uname -a
Linux beaglebone 3.5.0-rc6-12271-g776fa63 #22 SMP Tue Jul 24 17:41:33 CEST 2012 armv7l GNU/Linux
root@beaglebone:~# lsusb 
Bus 001 Device 002: ID 13fe:1d00 Kingston Technology Company Inc. DataTraveler 2.0 1GB/4GB Flash Drive / Patriot Xporter 4GB Flash Drive
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
root@beaglebone:~# cat /proc/cmdline 
console=ttyO0,115200n8 root=/dev/sda1 ro rootfstype=ext4 rootwait
root@beaglebone:~# df -h
Filesystem                Size      Used Available Use% Mounted on
/dev/root                 1.9G    100.1M      1.7G   5% /
devtmpfs                119.9M         0    119.9M   0% /dev
tmpfs                   120.0M         0    120.0M   0% /dev/shm
tmpfs                   120.0M    432.0K    119.6M   0% /run
tmpfs                   120.0M     92.0K    120.0M   0% /sys/fs/cgroup
tmpfs                   120.0M         0    120.0M   0% /tmp
root@beaglebone:~#
```
