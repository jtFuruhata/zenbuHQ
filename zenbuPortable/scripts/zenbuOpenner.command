#
# 【 zenbuPortable 】 zenbuOpenner.command
#   Ver1.10.190325a
# Concepted by TANAHASHI, Jiro (aka jtFuruhata)
# Copyright (C) 2019 jtLab, Hokkaido Information University
#
# Open zenbuConsole
#
. `dirname $0`/zenbuEnv.sh $@
. `dirname $0`/zenbuSummoner.command
cd "$HOME"
if [ $# -ne 0 ]; then
    cd "ws/$1"
fi
bash --rcfile "$S_ROOT/zenbuPrompt.sh"
$S_ROOT/zenbuSummoner.command -k
