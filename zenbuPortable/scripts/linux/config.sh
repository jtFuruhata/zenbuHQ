#
# 【 zenbuPortable 】 linux/config.sh
#   Ver1.40.190419a
# Concepted by TANAHASHI, Jiro (aka jtFuruhata)
# Copyright (C) 2019 jtLab, Hokkaido Information University
#
# ToDo: only for Ubuntu now.
#

export TMPDIR="/tmp/"
export zenbuModeParentSHLVL=3
export zenbuPathPathAdd=""


## common functions
clip-key () {
    xsel -bi < $SSH_HOME/$SSH_ID.pub
}

open-new-bash () {
    gnome-terminal -- "$@"
}

export -f clip-key
export -f open-new-bash
