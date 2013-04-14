require linux.inc

DESCRIPTION = "Linux kernel"
KERNEL_IMAGETYPE = "uImage"

COMPATIBLE_MACHINE = "(beagleboard|beaglebone)"

DEFAULT_PREFERENCE_beaglebone = "-1"

# The main PR is now using MACHINE_KERNEL_PR, for omap3 see conf/machine/include/omap3.inc
MACHINE_KERNEL_PR_append = "a"

FILESPATH =. "${FILE_DIRNAME}/linux-mainline-3.9:${FILE_DIRNAME}/linux-mainline-3.9/${MACHINE}:"

S = "${WORKDIR}/git"

PV = "3.8.0+3.9-rc5"

SRC_URI = "SEDMEURI"
SRCREV_pn-${PN} = "SEDMEREV"

do_configure_prepend() {
	if [ -e ${WORKDIR}/am335x-pm-firmware.bin ] ; then
		cp ${WORKDIR}/am335x-pm-firmware.bin ${S}/firmware
	fi

	cp ${WORKDIR}/db.txt ${S}/net/wireless
}
