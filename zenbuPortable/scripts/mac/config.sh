#
# 【 zenbuPortable 】 mac/set-depend.sh
#   Ver1.20.190327a
# Concepted by TANAHASHI, Jiro (aka jtFuruhata)
# Copyright (C) 2019 jtLab, Hokkaido Information University
#

# Mac use defalut $TMPDIR value 
export zenbuPathPathAdd=""


## common functions
clip-key () {
    pbcopy < $SSH_HOME/$SSH_ID.pub
}

open-new-bash () {
    open -a "Terminal" "$@"
}

export -f clip-key
export -f open-new-bash
