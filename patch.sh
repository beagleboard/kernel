#!/bin/bash
# (c) 2009 - 2012 Koen Kooi <koen@dominion.thruhere.net>
# (c) 2012 Robert Nelson <robertcnelson@gmail.com>
# This script will take a set of directories with patches and make a git tree out of it
# After all the patches are applied it will output a SRC_URI fragment you can copy/paste into a recipe
set -e

# don't use builtin 'echo' from /bin/sh
export ECHO="$(which echo)"

DIR="$PWD"
PATCHPATH="${DIR}/patches"
EXPORTPATH="${DIR}/export"

#For TAG, use mainline Kernel tags
TAG="v3.2"
EXTRATAG=""

#EXTERNAL_TREE="git://arago-project.org/git/projects/linux-am33x.git"
#EXTERNAL_BRANCH="v3.2-staging"
#EXTERNAL_SHA="e8004dad869568692ca2a45c04e8464ce48cc4d7"

PATCHSET="dirs"

git_kernel_stable () {
	git pull git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git master --tags || true
}

git_pull_torvalds () {
	git pull git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master --tags || true
	#Maybe, we need a stable tag '3.0.2'?
	git tag | grep ${TAG} >/dev/null || git_kernel_stable
}

if [ ! -d ${DIR}/kernel ] ; then
	mkdir -p ${DIR}/kernel
fi

cd ${DIR}/kernel

if [ ! -f ./.git/config ] ; then
	git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git .
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

if [ -d ${EXPORTPATH} ] ; then
	rm -rf ${EXPORTPATH} || true
fi

# apply patches
for patchset in ${PATCHSET} ; do
	mkdir -p ${EXPORTPATH}/$patchset
	patchcount=0
	for patch in $(ls -1 ${PATCHPATH}/$patchset/*.patch | sort -n) ; do
		$ECHO -n "$patch: "
		git am -q $patch && echo applied || exit 1
		let patchcount=$patchcount+1
	done
	git format-patch -${patchcount} --quiet -o ${EXPORTPATH}/$patchset
	git commit --allow-empty -a -m "${TAG}-${patchset}${EXTRATAG}"
done

if [ -f ${DIR}/src-uri.txt ] ; then
	rm -rf ${DIR}/src-uri.txt || true
fi

if [ -f ${DIR}/patch_script.sh ] ; then
	rm -rf ${DIR}/patch_script.sh || true
fi

# export patches and output SRC_URI for them
for patchset in ${PATCHSET} ; do
	for patch in $(ls -1 ${EXPORTPATH}/$patchset/*.patch | sort -n) ; do
		patch=${patch##*/}
		echo "            file://${patchset}/$patch \\" >> ${DIR}/src-uri.txt
		echo "	git am \"\${DIR}/patches/${patchset}/$patch\"" >> ${DIR}/patch_script.sh
	done
done

