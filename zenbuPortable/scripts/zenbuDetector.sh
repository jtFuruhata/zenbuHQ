#
# 【 zenbuPortable 】 zenbuDetector.sh
#   Ver1.40.190419a
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
        echo "***************"
        echo "*** WARNING ***"
        echo "***************"
        echo "Visual Studio Code supports up from Yosemite(10.10)."
    fi
    export zenbuOSType="mac"
    export zenbuOSArch="amd64"
    export zenbuPathOS="$zenbuOSType"
    export zenbuOSVersionID="`macOSname_getOSVer`"
    export zenbuOSVersion="`macOSname_getProductVer`"
    export zenbuOSName="`macOSname_getName` ($zenbuOSVersion)"
elif [ `uname` == "Linux" ]; then
    dpkg --version > /dev/null 2>&1
    if [ $? -gt 0 ]; then
        echo "Sorry, zenbuPortable supports only Debian GNU/Linux variants."
    fi
    export zenbuOSType="linux"
    export zenbuOSArch="`dpkg --print-architecture`"
    export zenbuPathOS="$zenbuOSType/$zenbuOSArch"
    export zenbuOSName=`cat /etc/os-release \
        | grep ^PRETTY_NAME \
        | awk -F\" '{print $2}'`
    export zenbuOSVersionID=`cat /etc/os-release \
        | grep ^VERSION_ID \
        | awk -F\" '{print $2}'`
    if [ ! -z "`echo $zenbuOSName | grep ^Ubuntu`" ]; then
        ver=( `echo "$zenbuOSName" \
            | tr -s '.' ' '`)
        if [ $((${ver[1]}*100+${ver[2]})) -lt 1404 ]; then
            echo "***************"
            echo "*** WARNING ***"
            echo "***************"
            echo "Visual Studio Code supports up from Ubuntu 14.04."
        fi
        export zenbuOSVersion="${ver[1]}.${ver[2]}.${ver[3]}"
    else
        ver=( `cat /etc/debian_version \
            | awk -F"\ " '{print $2}' \
            | tr -s '.' ' '`)
        if [ ${ver[0]} -lt 7 ]; then
            echo "***************"
            echo "*** WARNING ***"
            echo "***************"
            echo "Visual Studio Code supports up from Debian 7."
        fi
        export zenbuOSVersion="${ver[0]}.${ver[1]}"
    fi
else
    if [ $OSTYPE != "msys" ]; then
        echo "Sorry, zenbuPortable supports only with MSYS2."
        exit 1;
    fi
    . "`dirname $0`/win/winntOSname.sh"
    if [ `winntOSname_getBuildNo` -lt 7600 ]; then
        echo "***************"
        echo "*** WARNING ***"
        echo "***************"
        echo "Visual Studio Code supports up from Windows 7."
    fi
    export zenbuOSType="win"
    export zenbuOSArch=${PROCESSOR_ARCHITECTURE,,}
    if [ $zenbuOSArch == "x86" ]; then
        if [ -z $PROCESSOR_ARCHITEW6432 ]; then
            export zenbuOSArch="i686"
        else
            export zenbuOSArch=${PROCESSOR_ARCHITEW6432,,}
        fi
    fi
    # IA64 and ARM64 run with WOW64 (good luck) 
    if [ $zenbuOSArch == "amd64" ]; then
        export zenbuPathOS="win/amd64"
    else
        export zenbuPathOS="win/32"
    fi
    export zenbuOSVersionID="`winntOSname_getNTVer`"
    export zenbuOSVersion="`winntOSname_getWinVer`"
    export zenbuOSName="`winntOSname_getName`"
fi
