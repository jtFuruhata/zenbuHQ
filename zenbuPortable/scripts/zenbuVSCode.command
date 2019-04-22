#!/usr/bin/env bash
#
# 【 zenbuPortable 】 zenbuVSCode.command
#   Ver1.40.190419a
# Concepted by TANAHASHI, Jiro (aka jtFuruhata)
# Copyright (C) 2019 jtLab, Hokkaido Information University
#

. `dirname $0`/zenbuEnv.sh $@

echo "zenbuVSCode is preparing to start VSCode."

#
# select Code data
CodeWS="$zenbuPathCodeWS/.vscode/$zenbuModeRun.code-workspace"
zenbuModeCodeUserData="default"
zenbuModeCodeExtensions="default"
cwsopt1=`cwsopt 1`
cwsopt2=`cwsopt 2`
if [ ! -z $cwsopt1 ]; then zenbuModeCodeUserData=$cwsopt1; fi
if [ ! -z $cwsopt2 ]; then zenbuModeCodeExtensions=$cwsopt2; fi
export zenbuModeCodeUserData
export zenbuModeCodeExtensions

CodeTmpDir="${Tzenbu}$zenbuModeRun/.vscode"
CodeUserData="$Vzenbu/$zenbuModeCodeUserData/user-data"
CodeExtensions="$Vzenbu/$zenbuModeCodeExtensions/extensions"

if [ ! -e $CodeUserData ]; then
    mkdir -p "$CodeUserData"
    echo "created: $CodeUserData"
fi
if [ ! -e $CodeExtensions ]; then
    mkdir -p "$CodeExtensions"
    echo "created: $CodeExtensions"
fi

if [ $zenbuOSType != "win" ]; then
    echo "Preparing to use $CodeTmpDir. Plese wait..."
    rm -rf "$CodeTmpDir"
    mkdir -p "$CodeTmpDir"
    find $CodeUserData/* -maxdepth 0 \
        -exec ln -s "{}" "$CodeTmpDir" \; >/dev/null 2>&1
    UserData="$CodeTmpDir"
else
    UserData="$CodeUserData"
fi

export zenbuModeCodeUserData
export zenbuModeCodeExtensions
export zenbuPathCodeUserData="UserData"
export zenbuPathCodeExtensions="CodeExtensions"

echo 
echo "Visual Studio Code is running..."
echo

if [ $zenbuOSType == "win" ]; then
    invoker="$Pzenbu/VSCode/Code.exe"
elif [ $zenbuOSType == "mac" ]; then
    invoker="$Pzenbu/Visual Studio Code.app/Contents/Resources/app/bin/code"
elif [ $zenbuOSType == "linux" ]; then
    invoker="echo UNDER_CONSTRUCTION"
fi

"$invoker" "$CodeWS" --user-data-dir "$UserData" --extensions-dir "$CodeExtensions"

if [ $zenbuOSType != "win" ]; then
    echo     "Hit enter key **AFTER QUIT VSCode**"
    read -p "    to write back user-data from TMPDIR if necessory: "

    echo Clean up now. Please wait...

    find $CodeTmpDir/* -maxdepth 0 \
        -type d -exec mv -f "{}" "$CodeUserData/" \; -exec echo "move dir: {} " \; \
        -or \
        -type f -exec mv -f "{}" "$CodeUserData/" \; -exec echo "move file: {} " \;
    rm -rf "$CodeTmpDir"

    if [ $zenbuOSType == "mac" ]; then
        xattr -cr "$HOME" > /dev/null 2>&1
        echo 
        echo "Please hit Command+W key, thanks."
        echo
    fi 
fi
