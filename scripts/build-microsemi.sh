#!/usr/bin/env bash

# Safety settings, see https://gist.github.com/ilg-ul/383869cbb01f61a51c4d
set -o errexit  # Exit if command failed.
set -o pipefail # Exit if pipe failed.
set -o nounset  # Exit if variable not set.

# where the original script folder is located, didn't liked the download location after while
#BUILD_SCRIPT_LOCATION=~/Downloads/riscv-none-gcc-build.git/scripts
BUILD_SCRIPT_LOCATION=~/projects/liviu-modded-riscv-none-gcc-build/scripts


#SHARED_FOLDER_DESTINATION=/media/sf_VMSharedFolder/
SHARED_FOLDER_DESTINATION=/mnt/slower/VMSharedFolder/

# where all the mods are located
#BASE_URL="ftp://ftp.actel.com/incoming/tommy/riscv-tools"

#export RELEASE_VERSION="7.1.1-2-20171017"
export RELEASE_VERSION="7.2.0-1-20171109"

#export BINUTILS_ARCHIVE_URL="${BASE_URL}/riscv-binutils-gdb/archive/v${RELEASE_VERSION}.tar.gz"
#export GCC_ARCHIVE_URL="${BASE_URL}/riscv-none-gcc/archive/v${RELEASE_VERSION}.tar.gz"
#export NEWLIB_ARCHIVE_URL="${BASE_URL}/riscv-newlib/archive/v${RELEASE_VERSION}.tar.gz"

echo "Microsemi URLs:"
#env | grep ARCHIVE_URL

#livius original rv32i-ilp32--c rv32im-ilp32--c rv32iac-ilp32-- rv32imac-ilp32-- rv32imaf-ilp32f-- rv32imafc-ilp32f-rv32imafdc- rv64imac-lp64-- rv64imafdc-lp64d--
#ours MICROSEMI cores
#export GCC_MULTILIB="(rv32im-ilp32-- rv32ima-ilp32-- rv32imac-ilp32-- rv32imaf-ilp32f-- rv32imafc-ilp32f-- rv64imafd-lp64d-- rv64imac-lp64--)"

#not original tommy's setup, I messed up this one
#export GCC_MULTILIB="(rv32i-ilp32--c rv32im-ilp32--c rv32ima-ilp32--c rv32ia-ilp32--c rv32if-ilp32f--c rv32imf-ilp32f--c rv32iaf-ilp32f--c rv32imaf-ilp32f--c rv32imaf-ilp32f-rv32imafd-c rv64ima-lp64--c rv64imafd-lp64d--c)"

#just brute force copy from https://groups.google.com/a/groups.riscv.org/forum/#!msg/sw-dev/nkiTe3stA2o/Ntb5x6y8AAAJ
#export GCC_MULTILIB="(rv32e-ilp32-- rv32ea-ilp32-- rv32eac-ilp32-- rv32ec-ilp32-- rv32em-ilp32-- rv32ema-ilp32-- rv32emac-ilp32-- rv32emc-ilp32-- rv32i-ilp32-- rv32ia-ilp32-- rv32iac-ilp32-- rv32iaf-ilp32-- rv32iaf-ilp32f-- rv32iafc-ilp32-- rv32iafc-ilp32f-- rv32iafd-ilp32-- rv32iafd-ilp32d-- rv32iafd-ilp32f-- rv32iafdc-ilp32-- rv32iafdc-ilp32d-- rv32iafdc-ilp32f-- rv32ic-ilp32-- rv32if-ilp32-- rv32if-ilp32f-- rv32ifc-ilp32-- rv32ifc-ilp32f-- rv32ifd-ilp32-- rv32ifd-ilp32d-- rv32ifd-ilp32f-- rv32ifdc-ilp32-- rv32ifdc-ilp32d-- rv32ifdc-ilp32f-- rv32im-ilp32-- rv32ima-ilp32-- rv32imac-ilp32-- rv32imaf-ilp32-- rv32imaf-ilp32f-- rv32imafc-ilp32-- rv32imafc-ilp32f-- rv32imafd-ilp32-- rv32imafd-ilp32d-- rv32imafd-ilp32f-- rv32imafdc-ilp32-- rv32imafdc-ilp32d-- rv32imafdc-ilp32f-- rv32imc-ilp32-- rv32imf-ilp32-- rv32imf-ilp32f-- rv32imfc-ilp32-- rv32imfc-ilp32f-- rv32imfd-ilp32-- rv32imfd-ilp32d-- rv32imfd-ilp32f-- rv32imfdc-ilp32-- rv32imfdc-ilp32d-- rv32imfdc-ilp32f-- rv64i-lp64-- rv64ia-lp64-- rv64iac-lp64-- rv64iaf-lp64-- rv64iaf-lp64f-- rv64iafc-lp64-- rv64iafc-lp64f-- rv64iafd-lp64-- rv64iafd-lp64d-- rv64iafd-lp64f-- rv64iafdc-lp64-- rv64iafdc-lp64d-- rv64iafdc-lp64f-- rv64ic-lp64-- rv64if-lp64-- rv64if-lp64f-- rv64ifc-lp64-- rv64ifc-lp64f-- rv64ifd-lp64-- rv64ifd-lp64d-- rv64ifd-lp64f-- rv64ifdc-lp64-- rv64ifdc-lp64d-- rv64ifdc-lp64f-- rv64im-lp64-- rv64ima-lp64-- rv64imac-lp64-- rv64imaf-lp64-- rv64imaf-lp64f-- rv64imafc-lp64-- rv64imafc-lp64f-- rv64imafd-lp64-- rv64imafd-lp64d-- rv64imafd-lp64f-- rv64imafdc-lp64-- rv64imafdc-lp64d-- rv64imafdc-lp64f-- rv64imc-lp64-- rv64imf-lp64-- rv64imf-lp64f-- rv64imfc-lp64-- rv64imfc-lp64f-- rv64imfd-lp64-- rv64imfd-lp64d-- rv64imfd-lp64f-- rv64imfdc-lp64-- rv64imfdc-lp64d-- rv64imfdc-lp64f-- )"

# all of them without rv32e
#export GCC_MULTILIB="(rv32i-ilp32-- rv32ia-ilp32-- rv32iac-ilp32-- rv32iaf-ilp32-- rv32iaf-ilp32f-- rv32iafc-ilp32-- rv32iafc-ilp32f-- rv32iafd-ilp32-- rv32iafd-ilp32d-- rv32iafd-ilp32f-- rv32iafdc-ilp32-- rv32iafdc-ilp32d-- rv32iafdc-ilp32f-- rv32ic-ilp32-- rv32if-ilp32-- rv32if-ilp32f-- rv32ifc-ilp32-- rv32ifc-ilp32f-- rv32ifd-ilp32-- rv32ifd-ilp32d-- rv32ifd-ilp32f-- rv32ifdc-ilp32-- rv32ifdc-ilp32d-- rv32ifdc-ilp32f-- rv32im-ilp32-- rv32ima-ilp32-- rv32imac-ilp32-- rv32imaf-ilp32-- rv32imaf-ilp32f-- rv32imafc-ilp32-- rv32imafc-ilp32f-- rv32imafd-ilp32-- rv32imafd-ilp32d-- rv32imafd-ilp32f-- rv32imafdc-ilp32-- rv32imafdc-ilp32d-- rv32imafdc-ilp32f-- rv32imc-ilp32-- rv32imf-ilp32-- rv32imf-ilp32f-- rv32imfc-ilp32-- rv32imfc-ilp32f-- rv32imfd-ilp32-- rv32imfd-ilp32d-- rv32imfd-ilp32f-- rv32imfdc-ilp32-- rv32imfdc-ilp32d-- rv32imfdc-ilp32f-- rv64i-lp64-- rv64ia-lp64-- rv64iac-lp64-- rv64iaf-lp64-- rv64iaf-lp64f-- rv64iafc-lp64-- rv64iafc-lp64f-- rv64iafd-lp64-- rv64iafd-lp64d-- rv64iafd-lp64f-- rv64iafdc-lp64-- rv64iafdc-lp64d-- rv64iafdc-lp64f-- rv64ic-lp64-- rv64if-lp64-- rv64if-lp64f-- rv64ifc-lp64-- rv64ifc-lp64f-- rv64ifd-lp64-- rv64ifd-lp64d-- rv64ifd-lp64f-- rv64ifdc-lp64-- rv64ifdc-lp64d-- rv64ifdc-lp64f-- rv64im-lp64-- rv64ima-lp64-- rv64imac-lp64-- rv64imaf-lp64-- rv64imaf-lp64f-- rv64imafc-lp64-- rv64imafc-lp64f-- rv64imafd-lp64-- rv64imafd-lp64d-- rv64imafd-lp64f-- rv64imafdc-lp64-- rv64imafdc-lp64d-- rv64imafdc-lp64f-- rv64imc-lp64-- rv64imf-lp64-- rv64imf-lp64f-- rv64imfc-lp64-- rv64imfc-lp64f-- rv64imfd-lp64-- rv64imfd-lp64d-- rv64imfd-lp64f-- rv64imfdc-lp64-- rv64imfdc-lp64d-- rv64imfdc-lp64f-- )"

#only native abi combinations with all possible archs without E
#export GCC_MULTILIB="(rv32i-ilp32-- rv32ia-ilp32-- rv32iac-ilp32-- rv32iaf-ilp32-- rv32iaf-ilp32f-- rv32iafc-ilp32f-- rv32iafd-ilp32d-- rv32iafdc-ilp32d-- rv32ic-ilp32-- rv32if-ilp32f-- rv32ifc-ilp32f-- rv32ifd-ilp32d-- rv32ifdc-ilp32d-- rv32im-ilp32-- rv32ima-ilp32-- rv32imac-ilp32-- rv32imaf-ilp32f-- rv32imafc-ilp32f-- rv32imafd-ilp32d-- rv32imafdc-ilp32d-- rv32imc-ilp32-- rv32imf-ilp32f-- rv32imfc-ilp32f-- rv32imfd-ilp32d-- rv32imfdc-ilp32d-- rv64i-lp64-- rv64ia-lp64-- rv64iac-lp64-- rv64iaf-lp64f-- rv64iafc-lp64f-- rv64iafd-lp64-- rv64iafd-lp64d-- rv64iafdc-lp64d-- rv64ic-lp64-- rv64if-lp64f-- rv64ifc-lp64f-- rv64ifd-lp64d-- rv64ifdc-lp64d-- rv64im-lp64-- rv64ima-lp64-- rv64imac-lp64-- rv64imaf-lp64f-- rv64imafc-lp64f-- rv64imafd-lp64d-- rv64imafdc-lp64d-- rv64imc-lp64-- rv64imf-lp64f-- rv64imfc-lp64f-- rv64imfd-lp64d-- rv64imfdc-lp64d-- )"

#only our existing&planned devices and their downgrades with native abis
#export GCC_MULTILIB="(rv32i-ilp32-- rv32ia-ilp32-- rv32iac-ilp32-- rv32iaf-ilp32-- rv32iaf-ilp32f-- rv32iafc-ilp32f-- rv32ic-ilp32-- rv32if-ilp32f-- rv32ifc-ilp32f-- rv32im-ilp32-- rv32ima-ilp32-- rv32imac-ilp32-- rv32imaf-ilp32f-- rv32imafc-ilp32f-- rv32imc-ilp32-- rv32imf-ilp32f-- rv32imfc-ilp32f-- rv64i-lp64-- rv64ia-lp64-- rv64iac-lp64-- rv64iaf-lp64f-- rv64iafc-lp64f-- rv64iafd-lp64d-- rv64iafdc-lp64d-- rv64ic-lp64-- rv64if-lp64f-- rv64ifc-lp64f-- rv64ifd-lp64d-- rv64ifdc-lp64d-- rv64im-lp64-- rv64ima-lp64-- rv64imac-lp64-- rv64imaf-lp64f-- rv64imafc-lp64f-- rv64imafd-lp64d-- rv64imafdc-lp64d-- rv64imc-lp64-- rv64imf-lp64f-- rv64imfc-lp64f-- rv64imfd-lp64d-- rv64imfdc-lp64d-- )"

#remove the default toolchain multilib rv64gc?
export GCC_MULTILIB="(rv32i-ilp32-- rv32ia-ilp32-- rv32iac-ilp32-- rv32iaf-ilp32-- rv32iaf-ilp32f-- rv32iafc-ilp32f-- rv32ic-ilp32-- rv32if-ilp32f-- rv32ifc-ilp32f-- rv32im-ilp32-- rv32ima-ilp32-- rv32imac-ilp32-- rv32imaf-ilp32f-- rv32imafc-ilp32f-- rv32imc-ilp32-- rv32imf-ilp32f-- rv32imfc-ilp32f-- rv64i-lp64-- rv64ia-lp64-- rv64iac-lp64-- rv64iaf-lp64f-- rv64iafc-lp64f-- rv64iafd-lp64d-- rv64iafdc-lp64d-- rv64ic-lp64-- rv64if-lp64f-- rv64ifc-lp64f-- rv64ifd-lp64d-- rv64ifdc-lp64d-- rv64im-lp64-- rv64ima-lp64-- rv64imac-lp64-- rv64imaf-lp64f-- rv64imafc-lp64f-- rv64imafd-lp64d-- rv64imc-lp64-- rv64imf-lp64f-- rv64imfc-lp64f-- rv64imfd-lp64d-- rv64imfdc-lp64d--)"


#export branding="GNU Microsemi RISC-V Embedded GCC"
#export branding="GNU MCU Eclipse RISC-V Embedded GCC (Microsemi build)"

#detect how many threads your machine / VM has, and then try to use all of them
THREADS=`grep -c ^processor /proc/cpuinfo`
echo "$THREADS detected, will try to build on all of these"

#export JOBS_OPTIONS="--output-sync=recurse"

# the --native flag will try natively build
#bash $BUILD_SCRIPT_LOCATION/build-good.sh --deb32 --win32 --configure-cache --jobs 32 --without-pdf --draft
#bash $BUILD_SCRIPT_LOCATION/build.sh --deb32 --win32 --configure-cache --jobs 32 --without-pdf --draft --xml
#bash $BUILD_SCRIPT_LOCATION/build.sh --deb32 --configure-cache --jobs 32 --without-pdf --draft
#bash $BUILD_SCRIPT_LOCATION/build.sh --win64 --disable-strip --jobs $THREADS --without-pdf --draft
#bash $BUILD_SCRIPT_LOCATION/build.sh --win64 --disable-strip --jobs $THREADS --without-pdf --draft
#bash $BUILD_SCRIPT_LOCATION/build.sh --win64 --disable-strip --jobs $THREADS --without-pdf --draft --avoid-docker
bash $BUILD_SCRIPT_LOCATION/build.sh --win64 --disable-strip --jobs $THREADS --without-pdf --draft

# -n to skip existing files, but copy new ones to shared folder
echo "Copy deploy files to shared folder from the VM to the host"
cp -n ~/Work/riscv-none-gcc/deploy/*.* $SHARED_FOLDER_DESTINATION

# copy finished builds automaticaly to ftp after we are done and because ncftpput doesn't support skipping existing 
# files and copy everything every time is tedious I use the --DD which will delete the files locally when uploaded.
# I still have copy in the shared folder but this way I will not upload the same file multiple times.
# BTW you migh need to install this tool: 
# sudo apt-get install ncftp
# Maybe try the WPUT or http://lftp.yar.ru/
#ncftpput -u $FTP_UPLOAD_USER -p $FTP_UPLOAD_PASSWORD -R -DD $FTP_UPLOAD_HOST  $FTP_UPLOAD_DIR ~/Work/riscv-none-gcc/deploy/

exit 0