#
# 【 zenbuPortable 】 zenbuPrompt.sh
#   Ver1.00.190322a
# Concepted by TANAHASHI, Jiro (aka jtFuruhata)
# Copyright (C) 2019 jtLab, Hokkaido Information University
#
# This scripts will call from bash which after prepare with zenbuEnv.sh
# to run a new bash shell as child process.
#
PS1="$zenbuPS1"

if [ $P_NAME == "win" ]; then
    . "$SP_ROOT/portableGitPortal.sh"
fi