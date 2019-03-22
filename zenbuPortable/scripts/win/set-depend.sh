export TMPDIR=`cygpath -u "$temp/"`
PortableGit="$AP_ROOT/PortableGit"
export G_ROOT="$PortableGit/bin"
export SYS_ROOT="$AP_ROOT/msys64"
export MSYSTEM="MSYS"

export ADD_PATH="/usr/bin:$PortableGit/cmd:$PortableGit/usr/bin:$ADD_PATH"
