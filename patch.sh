#!/bin/bash
# (c) 2009 - 2013 Koen Kooi <koen@dominion.thruhere.net>
# (c) 2012 Robert Nelson <robertcnelson@gmail.com>
# This script will take a set of directories with patches and make a git tree out of it
# After all the patches are applied it will output a SRC_URI fragment you can copy/paste into a recipe
set -e

# don't use builtin 'echo' from /bin/sh
export ECHO="$(which echo)"

DIR="$PWD"
PATCHPATH="${DIR}/patches"
EXPORTPATH="${DIR}/export"

RECIPEDIR="linux-3.14"
RECIPENAME="linux-mainline_3.14.bb"
RECIPEFILE="${DIR}/recipes/${RECIPENAME}"

#For TAG, use mainline Kernel tags
TAG="v3.14.1"
EXTRATAG=""

EXTERNAL_TREE="https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git"
#EXTERNAL_BRANCH="master"
EXTERNAL_BRANCH="linux-3.14.y"
EXTERNAL_SHA="387df1bd3fc46bc695b317dda38b3254f4409036"

PATCHSET="dts fixes usb dts-bone dts-bone-capes static-capes"

git_kernel_stable () {
	git pull https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git master --tags || true
}

git_pull_torvalds () {
	git pull https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master --tags || true
	#Maybe, we need a stable tag '3.0.2'?
	git tag | grep ${TAG} >/dev/null || git_kernel_stable
}

if [ ! -d ${DIR}/kernel ] ; then
	mkdir -p ${DIR}/kernel
fi

cd ${DIR}/kernel

if [ ! -f ./.git/config ] ; then
	git clone https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git .
else
	git fetch
fi

git am --abort || echo "Do you need to make sure the patches apply cleanly first?"

# Always return to master, and remove patched branch...
git reset --hard
git checkout master -f
git describe
git branch -D tmp-patching-branch &>/dev/null || true
git branch -D tmp-patching-branch-sha &>/dev/null || true

#Do we have the tag?
git tag | grep ${TAG} | grep -v rc >/dev/null || git_pull_torvalds
git checkout -f ${TAG} -b tmp-patching-branch

if [ "${EXTERNAL_TREE}" ] ; then
	#we are pulling the  external tree into 1st branch, and checkout the SHA into a 2nd,
	#which saves a little pain in cleaning up master, when switching between different beagleboard branches
	git pull ${EXTERNAL_TREE} ${EXTERNAL_BRANCH}
	git checkout ${EXTERNAL_SHA} -b tmp-patching-branch-sha
fi

git describe

# newer gits will run 'git gc' after every patch if you don't prune
#git gc
#git prune

if [ -d ${EXPORTPATH} ] ; then
	rm -rf ${EXPORTPATH} || true
	rm -rf ${EXPORTPATH}-oe || true
fi

# apply patches
for patchset in ${PATCHSET} ; do
	CURRENTCOMMIT="$(git log --oneline --no-abbrev -1 | awk '{print $1}')"

	mkdir -p ${EXPORTPATH}/$patchset
	for patch in $(ls -1 ${PATCHPATH}/$patchset/*.patch | sort -n) ; do
		$ECHO -n "$patch: "
		git am -3 -q $patch && echo applied || exit 1
	done

	NEWCOMMIT="$(git log --oneline --no-abbrev -1 | awk '{print $1}')"

	git format-patch ${CURRENTCOMMIT}..${NEWCOMMIT} -o ${EXPORTPATH}/$patchset
	rm -rf ${PATCHPATH}/$patchset && cp -a ${EXPORTPATH}/$patchset ${PATCHPATH}

	git commit --allow-empty -a -m "${TAG}-${patchset}${EXTRATAG}"
done

mkdir -p ${EXPORTPATH}-oe/recipes-kernel/linux
cp ${RECIPEFILE} ${EXPORTPATH}-oe/recipes-kernel/linux/

if [ "${EXTERNAL_TREE}" ] ; then
	sed -i -e s:SEDMEREV:${EXTERNAL_SHA}: ${EXPORTPATH}-oe/recipes-kernel/linux/${RECIPENAME}
	sed -i -e s,SEDMEURI,${EXTERNAL_TREE}\;branch=${EXTERNAL_BRANCH}, ${EXPORTPATH}-oe/recipes-kernel/linux/${RECIPENAME}
	echo >> ${EXPORTPATH}-oe/recipes-kernel/linux/${RECIPENAME}
	echo 'SRC_URI += " \' >> ${EXPORTPATH}-oe/recipes-kernel/linux/${RECIPENAME}
fi

if [ -f ${DIR}/patch_script.sh ] ; then
	rm -rf ${DIR}/patch_script.sh || true
fi

# export patches and output SRC_URI for them
for patchset in ${PATCHSET} ; do
	for patch in $(ls -1 ${EXPORTPATH}/$patchset/*.patch | sort -n) ; do
		patch=${patch##*/}
		echo -e "\tfile://${patchset}/$patch \\" >> ${EXPORTPATH}-oe/recipes-kernel/linux/${RECIPENAME}
		echo "	git am \"\${DIR}/patches/${patchset}/$patch\"" >> ${DIR}/patch_script.sh
	done
done

mkdir -p ${EXPORTPATH}-oe/recipes-kernel/linux/${RECIPEDIR}

echo '	file://defconfig \' >> ${EXPORTPATH}-oe/recipes-kernel/linux/${RECIPENAME}
echo '  file://am335x-pm-firmware.bin \' >> ${EXPORTPATH}-oe/recipes-kernel/linux/${RECIPENAME}

if [ -e ${DIR}/logo_linux_clut224.ppm ] ; then
	cp ${DIR}/logo_linux_clut224.ppm ${EXPORTPATH}-oe/recipes-kernel/linux/${RECIPEDIR}/
	echo '  file://logo_linux_clut224.ppm \' >> ${EXPORTPATH}-oe/recipes-kernel/linux/${RECIPENAME}
fi

echo "\"" >> ${EXPORTPATH}-oe/recipes-kernel/linux/${RECIPENAME}

cp -a ${EXPORTPATH}/* ${EXPORTPATH}-oe/recipes-kernel/linux/${RECIPEDIR}/

mkdir -p ${EXPORTPATH}-oe/recipes-kernel/linux/${RECIPEDIR}/beaglebone
cp ${DIR}/configs/beaglebone ${EXPORTPATH}-oe/recipes-kernel/linux/${RECIPEDIR}/beaglebone/defconfig

if [ -e ${DIR}/kernel/am335x-pm-firmware.bin ] ; then
	cp ${DIR}/kernel/am335x-pm-firmware.bin ${EXPORTPATH}-oe/recipes-kernel/linux/${RECIPEDIR}/
fi

