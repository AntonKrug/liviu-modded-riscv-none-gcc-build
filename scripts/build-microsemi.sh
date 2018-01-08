#!/usr/bin/env bash

# Safety settings, see https://gist.github.com/ilg-ul/383869cbb01f61a51c4d
set -o errexit  # Exit if command failed.
set -o pipefail # Exit if pipe failed.
set -o nounset  # Exit if variable not set.

MULTILIBS=""

usage() {
    echo "Usage:"
    echo " -m small|large (will use selected set of multilibs)"
    echo "Example: ./build-microsemi.sh -m large"
    exit 0
}

while getopts ":m:" args; do
    case "${args}" in
        m)
            MULTILIBS="${OPTARG}"
            ;;

        *)
            usage
            ;;
    esac
done

if [ -z "$MULTILIBS" ]
then
    usage
fi

exit
# where the original script folder is located, didn't liked the download location after while
#BUILD_SCRIPT_LOCATION=~/Downloads/riscv-none-gcc-build.git/scripts
BUILD_SCRIPT_LOCATION=~/projects/liviu-modded-riscv-none-gcc-build/scripts

# FTP UPLOADS: Set your credentials here to have automated FTP uploads
#FTP_UPLOAD_HOST=
#FTP_UPLOAD_DIR=
#FTP_UPLOAD_USER=
#FTP_UPLOAD_PASSWORD=

#SHARED_FOLDER_DESTINATION=/media/sf_VMSharedFolder/
SHARED_FOLDER_DESTINATION=/mnt/slower/VMSharedFolder/

# where all the mods are located
#BASE_URL="ftp://ftp.actel.com/incoming/tommy/riscv-tools"

#export RELEASE_VERSION="7.1.1-2-20171017"
export RELEASE_VERSION="7.2.0-1-20171109"

#export BINUTILS_ARCHIVE_URL="${BASE_URL}/riscv-binutils-gdb/archive/v${RELEASE_VERSION}.tar.gz"
#export GCC_ARCHIVE_URL="${BASE_URL}/riscv-none-gcc/archive/v${RELEASE_VERSION}.tar.gz"
#export NEWLIB_ARCHIVE_URL="${BASE_URL}/riscv-newlib/archive/v${RELEASE_VERSION}.tar.gz"

# Multilibs settings:
# livius original rv32i-ilp32--c rv32im-ilp32--c rv32iac-ilp32-- rv32imac-ilp32-- rv32imaf-ilp32f-- rv32imafc-ilp32f-rv32imafdc- rv64imac-lp64-- rv64imafdc-lp64d--

if [ "$MULTILIBS" -eq "small" ]
then
    #ours MICROSEMI cores, which is default small set of multilibs when no arguments are passed
    export GCC_MULTILIB="(rv32im-ilp32-- rv32ima-ilp32-- rv32imac-ilp32-- rv32imaf-ilp32f-- rv32imafc-ilp32f-- rv64imafd-lp64d-- rv64imac-lp64--)"
fi

if [ "$MULTILIBS" -eq "large" ]
then
    # All combinations can be aquired from https://groups.google.com/a/groups.riscv.org/forum/#!msg/sw-dev/nkiTe3stA2o/Ntb5x6y8AAAJ
    # Removed the rv32e combinations, removed all non-native abi combinations for all remaining archs, 
    # removed D for rv32 combinations, removed rv64gc (imafdc) becuase it's the default one supported by stdlib:

    export GCC_MULTILIB="(rv32i-ilp32-- rv32ia-ilp32-- rv32iac-ilp32-- rv32iaf-ilp32-- rv32iaf-ilp32f-- rv32iafc-ilp32f-- rv32ic-ilp32-- rv32if-ilp32f-- rv32ifc-ilp32f-- rv32im-ilp32-- rv32ima-ilp32-- rv32imac-ilp32-- rv32imaf-ilp32f-- rv32imafc-ilp32f-- rv32imc-ilp32-- rv32imf-ilp32f-- rv32imfc-ilp32f-- rv64i-lp64-- rv64ia-lp64-- rv64iac-lp64-- rv64iaf-lp64f-- rv64iafc-lp64f-- rv64iafd-lp64d-- rv64iafdc-lp64d-- rv64ic-lp64-- rv64if-lp64f-- rv64ifc-lp64f-- rv64ifd-lp64d-- rv64ifdc-lp64d-- rv64im-lp64-- rv64ima-lp64-- rv64imac-lp64-- rv64imaf-lp64f-- rv64imafc-lp64f-- rv64imafd-lp64d-- rv64imc-lp64-- rv64imf-lp64f-- rv64imfc-lp64f-- rv64imfd-lp64d-- rv64imfdc-lp64d--)"
fi

echo "Building following multilibs: $GCC_MULTILIB"

export branding="GNU MCU Eclipse RISC-V Embedded GCC (Microsemi build)"

#detect how many threads your machine / VM has, and then try to use all of them
THREADS=`grep -c ^processor /proc/cpuinfo`
echo "$THREADS detected, will try to build on all of these"

#export JOBS_OPTIONS="--output-sync=recurse"

# the --native flag will try natively build
#bash $BUILD_SCRIPT_LOCATION/build.sh --deb32 --win32 --configure-cache --jobs 32 --without-pdf --draft --xml
#bash $BUILD_SCRIPT_LOCATION/build.sh --win64 --disable-strip --jobs $THREADS --without-pdf --draft --avoid-docker
bash $BUILD_SCRIPT_LOCATION/build.sh --win64 --disable-strip --configure-cache --jobs $THREADS --without-pdf --draft

# -n to skip existing files, but copy new ones to shared folder
echo "Copy deploy files to shared folder from the VM to the host"
cp -n ~/Work/riscv-none-gcc/deploy/*.* $SHARED_FOLDER_DESTINATION

# copy finished builds automaticaly to ftp after we are done and because ncftpput doesn't support skipping existing 
# files and copy everything every time is tedious I use the --DD which will delete the files locally when uploaded.
# I still have copy in the shared folder but this way I will not upload the same file multiple times.
# BTW you migh need to install this tool: 
# sudo apt-get install ncftp
# Maybe try the WPUT or http://lftp.yar.ru/
ncftpput -u $FTP_UPLOAD_USER -p $FTP_UPLOAD_PASSWORD -R -DD $FTP_UPLOAD_HOST  $FTP_UPLOAD_DIR ~/Work/riscv-none-gcc/deploy/

exit 0