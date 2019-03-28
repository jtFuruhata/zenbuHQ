#
# 【 zenbuPortable 】 zenbuPrompt.sh
#   Ver1.30.190328a
# Concepted by TANAHASHI, Jiro (aka jtFuruhata)
# Copyright (C) 2019 jtLab, Hokkaido Information University
#
# This scripts will call from bash which after prepare with zenbuEnv.sh
# to run a new bash shell as child process.
#
# Simply, this is rcfile.
#
if [ $zenbuModeRun == "default" ]; then
    PS1="Portable$zenbuPS1"
else
    PS1="$zenbuModeRun$zenbuPS1"
fi
