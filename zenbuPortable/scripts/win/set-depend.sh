#
# 【 zenbuPortable 】 win/set-depend.sh
#   Ver1.12.190326a
# Concepted by TANAHASHI, Jiro (aka jtFuruhata)
# Copyright (C) 2019 jtLab, Hokkaido Information University
#

export TMPDIR=`cygpath -u "$temp/"`
export G_ROOT="$AP_ROOT/PortableGit"
export SYS_ROOT="$AP_ROOT/msys"
export MSYSTEM="MSYS"

export ADD_PATH="/usr/bin:$G_ROOT/cmd:$G_ROOT/usr/bin:$ADD_PATH"

#
# Portal to PortableGit for Windows
# Why zenbuPortable doesn't use MSYS2's git package?
# -> Visual Studio Code's built-in Git SCM can use Git for Windows only. 
# if you want to use other Windows commands, dive into this portal.
# e.g.
# $ dir         # invoke bash.exe 'dir' command; alias to 'ls'
# $ portal dir  # invoke cmd.exe 'dir' command
#
portal () {
    eval $(echo "cmd /C \"$(echo "$@")\"")
}

# git.exe is able to use not via Portal.
ssh () { portal ssh "$@"; }
ssh-add () { portal ssh-add "$@"; }
ssh-keygen () { portal ssh-keygen "$@"; }
ssh-keyscan () { portal ssh-keyscan "$@"; }
ssh-agent () { portal ssh-agent "$@"; }

# util: all agent recaller for Windows
ssh-recall-all () {
    tasklist | grep ssh-agent.exe \
    | while read line; do
        pid=($line)
        export SSH_AGENT_PID=${pid[1]}
        eval $(echo "$(ssh-agent -k)")
    done
}


# util: copy $SSH_ID pubkey to clipboard for Windows
clip-key () {
    clip < $SSH_HOME/$SSH_ID.pub
}

export -f portal
export -f ssh
export -f ssh-add
export -f ssh-keygen
export -f ssh-keyscan
export -f ssh-agent
export -f ssh-recall-all
export -f clip-key
