#
# 【 zenbuPortable 】 zenbuOpenner.command
#   Ver1.20.190327a
# Concepted by TANAHASHI, Jiro (aka jtFuruhata)
# Copyright (C) 2019 jtLab, Hokkaido Information University
#
# Open zenbuConsole
#
. `dirname $0`/zenbuEnv.sh $@

bash --rcfile "$S_ROOT/zenbuPrompt.sh"

if [ $zenbuModeParent == "me" ]; then
    $S_ROOT/zenbuSummoner.command -k
fi
