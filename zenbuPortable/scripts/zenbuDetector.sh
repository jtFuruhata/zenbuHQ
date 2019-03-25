#
# 【 zenbuPortable 】 zenbuDetector.sh
#   Ver0.50.190319a
# Concepted by TANAHASHI, Jiro (aka jtFuruhata)
# Copyright (C) 2019 jtLab, Hokkaido Information University
#
# ToDo: make linuxOSname.sh
#
# Detect Platform & Architecture
# Basically, zenbuPortable depends on the requirements of VSCode.
if [ `uname` == "Darwin" ]; then
    . "`dirname $0`/mac/macOSname.sh"
    if [ `macOSname_getDarwinVer` -lt 10 ]; then
        echo "Sorry, zenbuPortable supports up from Yosemite(10.10)."
        exit 1;
    fi
    export P_NAME="mac"
    export P_ARCH="amd64"
    export AP_NAME="$P_NAME"
    export VERSION_ID="`macOSname_getOSVer`"
    export VERSION_FULL="`macOSname_getProductVer`"
    export PRETTY_NAME="`macOSname_getName` ($VERSION_FULL)"
elif [ `uname` == "Linux" ]; then
    dpkg --version > /dev/null 2>&1
    if [ $? -gt 0 ]; then
        echo "Sorry, zenbuPortable supports only Debian GNU/Linux variants."
        exit 1;
    fi
    export P_NAME="linux"
    export P_ARCH="`dpkg --print-architecture`"
    export AP_NAME="$P_NAME/$P_ARCH"
    export PRETTY_NAME=`cat /etc/os-release \
        | grep ^PRETTY_NAME \
        | awk -F\" '{print $2}'`
    export VERSION_ID=`cat /etc/os-release \
        | grep ^VERSION_ID \
        | awk -F\" '{print $2}'`
    if [ ! -z "`echo $PRETTY_NAME | grep ^Ubuntu`" ]; then
        ver=( `echo "$PRETTY_NAME" \
            | tr -s '.' ' '`)
        if [ $((${ver[1]}*100+${ver[2]})) -lt 1404 ]; then
            echo "Sorry, zenbuPortable supports up from Ubuntu 14.04."
            exit 1;
        fi
        export VERSION_FULL="${ver[1]}.${ver[2]}.${ver[3]}"
    else
        ver=( `cat /etc/debian_version \
            | awk -F"\ " '{print $2}' \
            | tr -s '.' ' '`)
        if [ ${ver[0]} -lt 7 ]; then
            echo "Sorry, zenbuPortable supports up from Debian 7."
            exit 1;
        fi
        export VERSION_FULL="${ver[0]}.${ver[1]}"
    fi
else
    pacman --version > /dev/null 2>&1
    if [ $? -gt 0 ]; then
        echo "Sorry, zenbuPortable supports only with MSYS2."
        exit 1;
    fi
    . "`dirname $0`/win/winntOSname.sh"
    if [ `winntOSname_getBuildNo` -lt 7600 ]; then
        echo "Sorry, zenbuPortable supports up from Windows 7."
        exit 1;
    fi
    export P_NAME="win"
    if [ `uname -m` == "x86_64" ]; then
        export P_ARCH="amd64"
    else
        export P_ARCH="i386"
    fi
    export AP_NAME="$P_NAME"
    export VERSION_ID="`winntOSname_getNTVer`"
    export VERSION_FULL="`winntOSname_getWinVer`"
    export PRETTY_NAME="`winntOSname_getName`"
fi
