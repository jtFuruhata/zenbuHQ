#
# 【 zenbuPortable 】 mac/config.sh
#   Ver1.40.190419a
# Concepted by TANAHASHI, Jiro (aka jtFuruhata)
# Copyright (C) 2019 jtLab, Hokkaido Information University
#

# Mac use defalut $TMPDIR value 
export zenbuModeParentSHLVL=4
export zenbuPathPathAdd=""


## common functions
clip-key () {
    pbcopy < $SSH_HOME/$SSH_ID.pub
}

open-new-bash () {
    osascript <<EOC
    	tell application "Terminal"
    	do script "$@"
    	end tell
EOC
}

export -f clip-key
export -f open-new-bash
