#
# 【 zenbuPortable 】 zenbuVSCode.command
#   Ver1.20.190327a
# Concepted by TANAHASHI, Jiro (aka jtFuruhata)
# Copyright (C) 2019 jtLab, Hokkaido Information University
#

. `dirname $0`/zenbuEnv.sh $@

echo "zenbuVSCode is preparing to start VSCode."

#
# select Code data
export CodeWS="$HOME/$zenbuPathCodeWS/.vscode/$zenbuModeConsole.code-workspace"
zenbuModeCodeUserData="default"
zenbuModeCodeExtensions="default"
options=(`cat $CodeWS | grep ^#zenbuVSCode`)
if [ -z ${options[1]} ]; then zenbuModeCodeUserData=${options[1]}; fi
if [ -z ${options[2]} ]; then zenbuModeCodeExtensions=${options[2]}; fi
export zenbuModeCodeUserData
export zenbuModeCodeExtensions

export CodeTmpDir="${TMPDIR}$zenbuModeConsole/.vscode"
export CodeUserData="$zenbuPathCodeData/$zenbuModeCodeUserData/user-data"
export CodeExtensions="$zenbuPathCodeData/$zenbuModeCodeExtensions/extensions"

echo "VSCode data directory has located with $CodeDataDir"
echo 

if [ ! -e $CodeDataDir ]; then
    mkdir "$CodeDataDir"
    echo "created: $CodeDataDir"
fi
if [ ! -e $CodeUserData ]; then
    mkdir "$CodeUserData"
    echo "created: $CodeUserData"
fi
if [ ! -e $CodeExtensions ]; then
    mkdir "$CodeExtensions"
    echo "created: $CodeExtensions"
fi

if [ $P_NAME != "win" ]; then
    echo "Preparing to use $CodeTmpDir. Plese wait..."
    rm -rf "$CodeTmpDir"
    mkdir -p "$CodeTmpDir"
    find $CodeUserData/* -maxdepth 0 \
        -exec ln -s "{}" "$CodeTmpDir" \; >/dev/null 2>&1
    UserData="$CodeTmpDir"
else
    UserData="$CodeUserData"
fi

echo 
echo "Visual Studio Code is running..."
echo

if [ $P_NAME == "win" ]; then
    invoker="$AP_ROOT/VSCode/Code.exe"
elif [ $P_NAME == "mac" ]; then
    invoker="$AP_ROOT/Visual Studio Code.app/Contents/Resources/app/bin/code"
elif [ $P_NAME == "linux" ]; then
    invoker="echo UNDER_CONSTRUCTION"
fi

"$invoker" "$CodeWS" --user-data-dir "$UserData" --extensions-dir "$CodeExtensions"

if [ $P_NAME != "win" ]; then
    echo     "Hit enter key **AFTER QUIT VSCode**"
    read -p "    to write back user-data from TMPDIR if necessory: "

    echo Clean up now. Please wait...

    find $CodeTmpDir/* -maxdepth 0 \
        -type d -exec mv -f "{}" "$CodeUserData/" \; -exec echo "move dir: {} " \; \
        -or \
        -type f -exec mv -f "{}" "$CodeUserData/" \; -exec echo "move file: {} " \;
    rm -rf "$CodeTmpDir"

    if [ $P_NAME == "mac" ]; then
        xattr -cr "$HOME" > /dev/null 2>&1
        echo 
        echo "Please hit Command+W key, thanks."
        echo
    fi 
fi
