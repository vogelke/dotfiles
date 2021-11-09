# Z-shell functions.
#
# $Revision: 2.5+1 $ $Date: 2020-10-10 02:08:01-04 $
# $Source: /doc/sitelog/hairball-home/basic-files/vogelke/zsh/dot-zsh/RCS/functions.zsh,v $
# $Host: hairball.my.domain $
# $UUID: f3bdc06f-528d-34aa-8cfd-16dd2fa4fbc4 $
#
# cd up N levels.  usage: .. [n]
unset -f .. 2> /dev/null
.. () {
    local arg=${1:-1};
    local dir=""
    while [ $arg -gt 0 ]; do
        dir="../$dir"
        arg=$(($arg - 1));
    done
    cd $dir #>&/dev/null
}

# go to the directory containing a file or another directory
unset -f D 2> /dev/null
D () {
    case "$#" in
        1) if test -e "$1"; then
               cd $(dirname $(realpath "$1"))
           else
               echo "can't find $1"
           fi ;;

        *) echo 'need a file or directory' ;;
    esac
}

# use this when connected via SSH;
# running daemon/daemonize can screw up exit
unset -f bye 2> /dev/null
bye () {
    case "X$SSH_CLIENT" in
        X) builtin exit ;;
        *) kill -15 $$ $PPID ;;
    esac
}

# if current directory is a link, cd to actual directory
unset -f cwd 2> /dev/null
cwd () {
    _x=$(/bin/pwd)
    chdir "$_x"
    unset _x
}

unset -f here 2> /dev/null
here () {
    current=$PWD
    echo "current='$current'" >! $HOME/.current
}

# Directory stuff.
unset -f up 2> /dev/null
up () {
    cd ../$*
}

unset -f upp 2> /dev/null
upp () {
    cd ../../$*
}

# Better setup for which: shows aliases, functions.
unset -f which 2> /dev/null
unalias which  2> /dev/null
which () {
    (alias; declare -f) | /usr/bin/which $@
}

# gd: go to popular directories.
# replacement for cd to handle frequently-used directories; lets
# you enter a single letter to get to one.  Return=go nowhere.

unset -f g 2> /dev/null
g () {
    local dirs=".cdlist"
    local prompt="dir: "
    local olddir=$(pwd)
    cd
    test -f $dirs || { cd $olddir && unset olddir && return }
    clear
    cat $dirs

    local ans=$(grabchars -d- -c '[0-9a-zA-Z]' -q"$prompt")
    case "$ans" in
       q|-) cd $olddir; return ;;
       *) ;;
    esac

    set X $(grep "^${ans} " $dirs)

    case "$#" in
       3) chdir $3 || return ;;
       *) echo "$ans: no such entry"; return ;;
    esac

    if test -f $dirs
    then
        g
    else
        echo; echo; pwd; echo;
        ls --color=always -blptF --time-style='+%d-%b-%Y %T' | head
    fi
}

# redo: run something again.

unset -f redo 2> /dev/null
redo () {
    local cmds=/tmp/redo.cmds.$$
    local disp=/tmp/redo.disp.$$
    local prompt="Rerun: "

    case "$#" in
        (0) echo "need a string or command number"; return ;;
        (*) fc -l -1000 | grep "$1" -- > $cmds 2> /dev/null ;;
    esac

    if test -s "$cmds"; then
        local n=$(wc -l < $cmds)
        (paste ~/libexec/alphabet $cmds | expand -4 | head -$n; echo) > $disp
    else
        echo "no match"
        rm $cmds
        return
    fi

    cat $disp
    local ans=$(grabchars -d- -c '[0-9a-z]' -q"$prompt") 
    case "$ans" in
        (-) return ;;
        (*) ;;
    esac

    set X $(grep "^${ans} " $disp)
    case "$#" in
        (1) echo no such entry; return ;;
        (*) echo "rerunning $3"; fc -e - $3 ;;
    esac

    rm $cmds $disp
}

# Switch between default setup and Plan-9 stuff.
unset -f p9 2> /dev/null
p9 () {
    case "$PLAN9" in
        "") echo "Setting Plan-9 env"
            export PLAN9=1
            for x in .p9path .p9manpath; do
                test -f "$HOME/$x" &&
                eval setenv $(head -1 "$HOME/$x")
            done
            ;;

        *)  echo "Leaving Plan-9 env"
            unset PLAN9
            for x in .path .manpath; do
                test -f "$HOME/$x" &&
                eval setenv $(head -1 "$HOME/$x")
            done
            ;;
    esac

    echo "PATH=$PATH"
    echo "MANPATH=$MANPATH"
}
