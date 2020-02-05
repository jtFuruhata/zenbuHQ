#
# 【 zenbuPortable 】 zenbuEnv.sh
#   Ver1.41.200205a
# Concepted by TANAHASHI, Jiro (aka jtFuruhata)
# Copyright (C) 2019-2020 jtLab, Hokkaido Information University
#

export zenbuPS1=":\W \$ "

# Backup $HOME and $PATH
if [ -z "$zenbuPathHomeOrigin" ]; then
    export zenbuPathHomeOrigin="$HOME"
fi
if [ -z "$zenbuPathPathOrigin" ]; then
    export zenbuPathPathOrigin="$PATH"
fi

# set Portable HOME
cd "`dirname $0`/.."
export HOME="$PWD"
export Wzenbu="$HOME/ws"

#
# preparing console mode
zenbuModeRunPrev=$zenbuModeRun
if [ $# -eq 0 ]; then
echo "no args passing"
    if [ -z $zenbuModeRunPrev ]; then
echo "mode parent"
        export zenbuModeRun="default"
        export zenbuPathCWD="$Wzenbu"
        export zenbuPathCodeWS="$Wzenbu"
    fi
else
    export zenbuModeRun="$1"
    export zenbuPathCWD="$Wzenbu/$zenbuModeRun"
    export zenbuPathCodeWS="$Wzenbu/$zenbuModeRun"
    if [ ! -d "$zenbuPathCWD" ]; then
        if [ $zenbuModeRun == "HQ" ]; then
            export zenbuPathCWD="$HOME"
        else
            export zenbuPathCWD="$Wzenbu"
        fi
        export zenbuPathCodeWS="$Wzenbu"
    fi
fi

echo
echo "zenbuEnv is preparing environment variables as Run Mode: $zenbuModeRun"

#
# set env if new parent or change console mode
if [ $SHLVL -le 3 -o \
    " $zenbuModeRun" != " $zenbuModeRunPrev" ]; then

    # Detect Platform & Architecture
    # Basically, zenbuPortable depends on the requirements of VSCode.
    if [ $SHLVL -le 3 ]; then
        echo "zenbuDetector is recognizing this platform."
        zenbuModeParentSHLVL=$SHLVL
        . "`dirname $0`/zenbuDetector.sh" ""
    fi

    # Splash
    echo
    echo "          【 zenbuPortable 】"
    echo "           - Port Them All - "
    echo 
    echo "on $zenbuPathOS, $zenbuOSName"
    echo "at $HOME"
    echo
    if [ "$SHLVL" == "$zenbuModeParentSHLVL" ]; then
        echo " I am a Parent Console."
        echo " Please DON'T KILL ME while my children are alive."
        echo
    fi

    export Azenbu="$HOME/apps"
    export Szenbu="$HOME/scripts"
    export Vzenbu="$HOME/.vscode"

    export Pzenbu="$Azenbu/$zenbuPathOS"
    export SYSzenbu=""
    export zenbuPathCore="$Szenbu/zenbuCore"
    export zenbuPathLib="$zenbuPathCore/zenbuLib.sh"
    export zenbuPathGit="$Pzenbu/git"
    export zenbuPathNode="$Pzenbu/node.js"
    export zenbuPathPathAdd=""

    # set platform specific environment variables
    # into $zenbuPathGit, $TMPDIR, and ":" terminated $zenbuPathPathAdd
    depend_sh="$Szenbu/$zenbuOSType/config.sh"
    if [ -f "$depend_sh" ]; then
        . "$depend_sh"
    fi
    if [ $# -ne 0 ]; then
        depend_sh="$Szenbu/$1/config.sh"
        if [ -f "$depend_sh" ]; then
            . "$depend_sh"
        fi
    fi

    # restore .template file if necessory
    # (.template files are indicated "!" in top of line at MANIFEST)
    #
    # ToDo: make zenbuManifest
    cat "$Szenbu/MANIFEST" | grep ^! \
    | while read template; do
        srcItem="${HOME}${template:1}"
        distItem="${srcItem%.*}"
        if [ ! -e "$distItem" ]; then
            cp "$srcItem" "$distItem"
        fi
    done

    export Tzenbu="${TMPDIR}zenbuPortable"
    if [ -z "$zenbuPathPath" ]; then
        export zenbuPathPath="${zenbuPathPathAdd}${zenbuPathGit}/bin:${zenbuPathNode}:${zenbuPathPathOrigin}"
        export PATH="$zenbuPathPath"
    fi

    if [ "$SHLVL" == "$zenbuModeParentSHLVL" ]; then
        . $Szenbu/zenbuSummoner.command ""
    fi

    cd "$zenbuPathCWD"

    #
    ## zenbuLib functions
    zc () {         # Open new zenbuConsole instance
        invoker="open-new-bash $Szenbu/zenbuOpenner.command"
        if [ $# = 0 ]; then
            $invoker
        else
            $invoker "$@"
        fi
    }; export -f zc
    zv () {         # Open new zenbuVSCode instance
        invoker="open-new-bash $Szenbu/zenbuVSCode.command"
        if [ $# = 0 ]; then
            $invoker
        else
            $invoker "$@"
        fi
    }; export -f zv
    zs () {         # Call zenbuSummoner
        invoker="$Szenbu/zenbuSummoner.command"
        if [ $# = 0 ]; then
            $invoker
        elif [ -z `echo $1 | grep ^-` ]; then
            . $invoker "$@"
        else
            $invoker "$@"
        fi
    }; export -f zs
    cwsopt () {     # get zenbuVSCode .code-workspace options
        if [ -z "$2" ]; then
            cws="$zenbuPathCodeWS/.vscode/$zenbuModeRun.code-workspace"
        else
            cws="$2"
        fi
        options=(`cat "$cws" | grep ^#zenbuVSCode`)
        echo ${options[$1]}
    }; export -f cwsopt
    zenbuenv () {   # show all zenbuEnvs
        export | grep "^declare -x zenbu" | awk -F'declare -x zenbu' '{print $2}' 
    }; export -f zenbuenv
    zenbulib () {   # show all zenbuLibs
        export -f | grep "^declare -fx" | awk -F'declare -fx ' '{print $2}' 
    }; export -f zenbulib
    zl () {
        . "$zenbuPathLib"
        zenbuLib "$@"
    }; export -f zl
fi