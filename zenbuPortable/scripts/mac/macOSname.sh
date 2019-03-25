#
# 【 zenbuPortable 】 macOSname.sh
#   Ver1.00.190319a
# Concepted by TANAHASHI, Jiro (aka jtFuruhata)
# Copyright (C) 2019 jtLab, Hokkaido Information University
#
# Usage:
# macOSname_getDarwinVer () ... 14
# macOSname_getOSVer () ... 10.14
# macOSname_getProductVer () ... 10.14.3
# macOSname_getName () ... macOS Mojave

macOSname=(
    "Mac OS X Cheetah"
    "Mac OS X Puma"
    "Mac OS X Jaguar"
    "Mac OS X Panther"
    "Mac OS X Tiger"
    "Mac OS X Leopard"
    "Mac OS X Snow Leopard"
    "Mac OS X Lion"
    "OS X Mountain Lion"
    "OS X Marvericks"
    "OS X Yosemite"
    "OS X El Capitan"
    "macOS Sierra"
    "macOS High Sierra"
    "macOS Mojave"
)

macOSname_ver=( `sw_vers -productVersion | tr -s '.' ' '`)

macOSname_getDarwinVer () {
    echo "${macOSname_ver[1]}"
}

macOSname_getOSVer () {
    echo "${macOSname_ver[0]}.${macOSname_ver[1]}"
}

macOSname_getProductVer () {
    echo "${macOSname_ver[0]}.${macOSname_ver[1]}.${macOSname_ver[2]}"
}

macOSname_getName () {
    echo "${macOSname[`macOSname_getDarwinVer`]}"
}
