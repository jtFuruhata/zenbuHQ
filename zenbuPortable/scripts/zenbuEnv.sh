#
# 【 zenbuPortable 】 zenbuEnv.sh
#   Ver1.10.190325a
# Concepted by TANAHASHI, Jiro (aka jtFuruhata)
# Copyright (C) 2019 jtLab, Hokkaido Information University
#
echo
echo "zenbuEnv is preparing environment variables."

export zenbuPS1="Portable:\W \$ "

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
cd "$OLDPWD"

# Splash
echo
echo "          【 zenbuPortable 】"
echo "           - Port Them All - "
echo
echo "on $AP_NAME, $PRETTY_NAME"
echo "at $HOME"
echo

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
export T_ROOT="$TMPDIR/zenbuPortable"
export PATH="${ADD_PATH}${G_ROOT}/bin:${PATH_ORG}"
