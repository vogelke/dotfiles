# $Revision: 2.6 $ $Date: 2020-10-10 02:09:59-04 $
# $Source: /doc/sitelog/hairball-home/basic-files/vogelke/zsh/dot-zsh/RCS/history.zsh,v $
# $Host: hairball.my.domain $
# $UUID: 704ea02a-ad11-5e34-8878-1b63343038fb $
#
# ZSH command history

export HISTSIZE=2000
export SAVEHIST=2000
export HISTFILE=~/.zsh/.histfile

# Show history without command numbers, look for optional pattern.
unset -f h 2> /dev/null
h () {
    case "$#" in
        0)  fc -ln 1 | less ;;
        *)  fc -ln 1 | grep ${1+"$@"} ;;
    esac
}

# Edit history if I crap it up somehow.  Happens.
unset -f histedit 2> /dev/null
histedit () {
    _x="$HOME/.zsh/.histedit"
    fc -ln 1 > $_x && vi $_x && fc -R $_x && rm $_x
}

# Save a good copy of history.
unset -f savehist 2> /dev/null
savehist () {
    fc -ln 1 >! $HOME/.zsh/.histfile
}
