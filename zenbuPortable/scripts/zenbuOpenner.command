#!/usr/bin/env bash
#
# 【 zenbuPortable 】 zenbuOpenner.command
#   Ver1.40.190419a
# Concepted by TANAHASHI, Jiro (aka jtFuruhata)
# Copyright (C) 2019 jtLab, Hokkaido Information University
#
# Open zenbuConsole
#
. `dirname $0`/zenbuEnv.sh $@

trap 'if [ $SHLVL = $zenbuModeParentSHLVL ]; then 
    $Szenbu/zenbuSummoner.command -k; 
    rm -rf $Tzenbu;
    fi; echo "bye."; exit;' 0 1 2 3 15

bash --rcfile "$Szenbu/zenbuPrompt.sh"
