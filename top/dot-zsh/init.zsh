# Miscellaneous stuff that needs to work first.
#
# $Revision: 2.6 $ $Date: 2020-10-10 02:09:59-04 $
# $Source: /doc/sitelog/hairball-home/basic-files/vogelke/zsh/dot-zsh/RCS/init.zsh,v $
# $Host: hairball.my.domain $
# $UUID: 7af567f7-5a42-580d-af67-930d1fa142ac $

# Lines configured by zsh-newuser-install
setopt appendhistory autocd extendedglob notify
unsetopt beep
bindkey -e
# End of lines configured by zsh-newuser-install

# This is used all over the place.
unset -f setenv 2> /dev/null
setenv () {
    export $1="$2"
}

# Make sure my terminal is set up, get rid of broken paste.

if test -f "$HOME/.termrc.gnome-term"; then
    source "$HOME/.termrc.gnome-term"
else
    test -d /usr/local/share/terminfo &&
      export TERMINFO=/usr/local/share/terminfo
fi
unset zle_bracketed_paste

# Path settings.
test -f ~/.path     && eval setenv $(head -1 ~/.path)
test -f ~/.javapath && eval setenv $(head -1 ~/.javapath)
test -f ~/.manpath  && eval setenv $(head -1 ~/.manpath)
test -f ~/.proxy    && eval setenv $(head -1 ~/.proxy)
test -f ~/.envrc.sh && source ~/.envrc.sh
test -f ~/.lessenv  && source ~/.lessenv

# GO language.
test -f /etc/profile.d/goenv.sh && source /etc/profile.d/goenv.sh

# Previous working directory.
test -f ~/.current && . ~/.current

# Search path for the cd command.
cdpath=( . .. ~ )

# Default file permission.
umask 022

# Exception for root/postgres users.
test -f $HOME/.Xauthority && chmod 644 $HOME/.Xauthority

# Isolate exports/setopt based on the host operating system.
case "$(uname)" in
    Linux) IS_LINUX=1 ;;
    SunOS) IS_SUN=1 ;;
esac
test -f $HOME/.printer && eval setenv $(cat $HOME/.printer)
