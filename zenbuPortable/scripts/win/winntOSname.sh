#
# 【 zenbuPortable 】 winntOSname.sh
#   Ver1.46.210722a
# Concepted by TANAHASHI, Jiro (aka jtFuruhata)
# Copyright (C) 2019-2021 jtLab, Hokkaido Information University
#
# Usage:
# winntOSname_getWinVer () ... 10.0.17134.648
# winntOSname_getBuildNo () ... 17134
# winntOSname_getNTVer () ... 10.0 1803
# winntOSname_getName () ... Windows 10 April 2018 Update (Version 1803)

#     build#  Name
winntOSname=(
      ["528"]="Windows NT 3.1"
      ["807"]="Windows NT 3.5"
     ["1057"]="Windows NT 3.51"
     ["1381"]="Windows NT 4.0"
     ["2195"]="Windows 2000"
     ["2600"]="Windows XP"
     ["3790"]="Windows XP 64-bit Edition"
     ["6000"]="Windows Vista"
     ["6001"]="Windows Vista SP1"
     ["6002"]="Windows Vista SP2"
     ["7600"]="Windows 7"
     ["7601"]="Windows 7 SP1"
     ["9200"]="Windows 8"
     ["9600"]="Windows 8.1"
    ["10240"]="Windows 10 RTM"
    ["10580"]="Windows 10 November Update (Version 1511)"
    ["14393"]="Windows 10 Anniversary Update (Version 1607)"
    ["15063"]="Windows 10 Creators Update (Version 1703)"
    ["16299"]="Windows 10 Fall Creators Update (Version 1709)"
    ["17134"]="Windows 10 April 2018 Update (Version 1803)"
    ["17763"]="Windows 10 October 2018 Update (Version 1809)"
    ["18362"]="Windows 10 May 2019 Update (Version 1903)"
    ["18363"]="Windows 10 November 2019 Update (Version 1909)"
    ["19041"]="Windows 10 20H1 (Version 2004)"
    ["19042"]="Windows 10 (Version 20H2)"
    ["19043"]="Windows 10 (Version 21H1)"
)

#     build#  NT Version
winntVersion=(
      ["528"]="3.1"
      ["807"]="3.5"
     ["1057"]="3.51"
     ["1381"]="4.0"
     ["2195"]="5.00"
     ["2600"]="5.1"
     ["3790"]="5.2"
     ["6000"]="6.0"
     ["6001"]="6.0"
     ["6002"]="6.0"
     ["7600"]="6.1"
     ["7601"]="6.1"
     ["9200"]="6.2"
     ["9600"]="6.3"
    ["10240"]="10.0 1507"
    ["10580"]="10.0 1511"
    ["14393"]="10.0 1607"
    ["15063"]="10.0 1703"
    ["16299"]="10.0 1709"
    ["17134"]="10.0 1803"
    ["17763"]="10.0 1809"
    ["18362"]="10.0 1903"
    ["18363"]="10.0 1909"
    ["19041"]="10.0 2004"
    ["19042"]="10.0 20H2"
    ["19043"]="10.0 21H1"
)

declare -i winntOSname_buildNo=0

winntOSname_getWinVer () {
    echo "`cmd.exe /C ver \
        | tr -s '[]' ':' \
        | awk -F':' '{print $2}' \
        | awk -F' ' '{print $2}'`"
}

winntOSname_ntver=(
    `winntOSname_getWinVer | tr -s '.' ' '`
)

winntOSname_getBuildNo () {
    if [ $winntOSname_buildNo = 0 ]; then
        winntOSname_buildNo=${winntOSname_ntver[2]}
    fi
    echo $winntOSname_buildNo
}

winntOSname_getNTVer () {
    echo "${winntVersion[`winntOSname_getBuildNo`]}"
}

winntOSname_getName () {
    echo "${winntOSname[`winntOSname_getBuildNo`]}"
}
