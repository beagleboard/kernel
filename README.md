kernel
======

Kernel for the beagleboard.org boards

usage
======

beagleboard-3.4 patchset:

git checkout origin/beagleboard-3.4 -b beagleboard-3.4

./patch.sh

Board Maintainers List
---------------------

### BeagleBoard/PandaBoard
* defconfig: patches/beagleboard/defconfig
* Robert Nelson <robertcnelson@gmail.com>

omapdrm (with new bootargs)
---------------------
This uses the cma patchset (needed for omap3, mainline as of 3.5): git://git.linaro.org/people/mszyprowski/linux-dma-mapping.git 3.4-rc1-cma-v24

*ddx: http://cgit.freedesktop.org/xorg/driver/xf86-video-omap/

*libdrm: http://cgit.freedesktop.org/mesa/drm build with "--enable-omap-experimental-api"

CONFIG_DRM_OMAP=m (and resolution will be read from edid on bootup..)

CircuitCo ulcd (beaglexm):

video=DVI-D-1:800x480

With the old (CONFIG_FB_OMAP2) this would have been:

vram=12MB

defaultdisplay=dvi

dvimode=800x480MR-16@60

vram=${vram} omapfb.mode=${defaultdisplay}:${dvimode} omapdss.def_disp=${defaultdisplay}
