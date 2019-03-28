#
# 【 zenbuPortable 】 zenbuOpenner.command
#   Ver1.30.190328a
# Concepted by TANAHASHI, Jiro (aka jtFuruhata)
# Copyright (C) 2019 jtLab, Hokkaido Information University
#
# Open zenbuConsole
#
. `dirname $0`/zenbuEnv.sh $@

trap 'if [ $zenbuModeParent == "me" ]; then 
    $Szenbu/zenbuSummoner.command -k; 
    rm -rf $Tzenbu;
    fi; echo "bye."; exit;' 0 1 2 3 15

bash --rcfile "$Szenbu/zenbuPrompt.sh"
