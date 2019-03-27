#
# 【 zenbuPortable 】 zenbuEnv.sh
#   Ver1.20.190327a
# Concepted by TANAHASHI, Jiro (aka jtFuruhata)
# Copyright (C) 2019 jtLab, Hokkaido Information University
#
#
# ToDo: make zenbuManifest
#
echo
echo "zenbuEnv is preparing environment variables."

export zenbuPS1="Portable:\W \$ "

#
# preparing console mode
zenbuModeConsolePrev=$zenbuModeConsole
if [ $# -eq 0 ]; then
    if [ -z $zenbuModeConsolePrev ]; then
        export zenbuModeConsole="default"
        export zenbuPathCWD="ws"
        export zenbuPathCodeWS="ws"
    fi
else
    export zenbuModeConsole="$1"
    export zenbuPathCWD="ws/$zenbuModeConsole"
    export zenbuPathCodeWS="ws/$zenbuModeConsole"
    if [ $zenbuModeConsole == "HQ" ]; then
        export zenbuPathCWD=".."
        export zenbuPathCodeWS="ws"
    fi
fi

if [ -z $zenbuModeParent ]; then
    export zenbuModeParent="me"
else
    export zenbuModeParent="others"
fi

#
# set env if new parent or change console mode
if [ $zenbuModeParent == "me" -o \
    " $zenbuModeConsole" != " $zenbuModeConsolePrev" ]; then

    # Detect Platform & Architecture
    # Basically, zenbuPortable depends on the requirements of VSCode.
    echo "zenbuDetector is recognizing this platform."
    . "`dirname $0`/zenbuDetector.sh"

    # Backup $HOME and $PATH
    if [ -z "$HOME_ORG" ]; then
        export HOME_ORG="$HOME"
    fi
    if [ -z "$PATH_ORG" ]; then
        export PATH_ORG="$PATH"
    fi

    # set Portable HOME
    cd "`dirname $0`/.."
    export HOME="$PWD"
    cd "$HOME/$zenbuPathCWD"

    # Splash
    echo
    echo "          【 zenbuPortable 】"
    echo "           - Port Them All - "
    echo
    echo "on $AP_NAME, $PRETTY_NAME"
    echo "at $HOME"
    echo

    export zenbuPathCodeData="$HOME/.vscode"
    export A_ROOT="$HOME/apps"
    export S_ROOT="$HOME/scripts"

    export AP_ROOT="$A_ROOT/$AP_NAME"
    export SP_ROOT="$S_ROOT/$P_NAME"
    export SYS_ROOT=""
    export G_ROOT="$AP_ROOT/git"
    export ADD_PATH=""

    # set platform specific environment variables
    # into $G_ROOT, $TMPDIR, and ":" terminated $ADD_PATH
    depend_sh="$SP_ROOT/set-depend.sh"
    if [ -f "$depend_sh" ]; then
        . "$depend_sh"
    fi
    if [ $# -ne 0 ]; then
        depend_sh="$S_ROOT/$1/set-depend.sh"
        if [ -f "$depend_sh" ]; then
            . "$depend_sh"
        fi
    fi

    # restore .template file if necessory
    # (.template files are indicated "!" in top of line at MANIFEST)
    #
    # ToDo: make zenbuManifest
    cat "$S_ROOT/MANIFEST" | grep ^! \
    | while read template; do
        srcItem="${HOME}${template:1}"
        distItem="${srcItem%.*}"
        if [ ! -e "$distItem" ]; then
            cp "$srcItem" "$distItem"
        fi
    done

    ## zenbuCore functions
    zc () {
        invoker="open-new-bash $S_ROOT/zenbuOpenner.command"
        if [ $# = 0 ]; then
            $invoker
        else
            $invoker "$@"
        fi
    }
    zv () {
        invoker="open-new-bash $S_ROOT/zenbuVSCode.command"
        if [ $# = 0 ]; then
            $invoker
        else
            $invoker "$@"
        fi
    }
    zs () {
        invoker="$S_ROOT/zenbuSummoner.command"
        if [ $# = 0 ]; then
            $invoker
        elif [ -z `echo $1 | grep ^-` ]; then
            . $invoker "$@"
        else
            $invoker "$@"
        fi
    }
    zenbuenv () {
        export | grep "^declare -x zenbu" | awk -F'declare -x zenbu' '{print $2}' 
    }
    zenbulib () {
        export -f | grep "^declare -fx" | awk -F'declare -fx ' '{print $2}' 
    }
    export -f zc
    export -f zv
    export -f zs
    export -f zenbuenv
    export -f zenbulib

    export T_ROOT="$TMPDIR/zenbuPortable"
    export PATH="${ADD_PATH}${G_ROOT}/bin:${PATH_ORG}"

    . $S_ROOT/zenbuSummoner.command
fi