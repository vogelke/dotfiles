# $Revision: 2.6 $ $Date: 2020-10-10 02:09:59-04 $
# $Source: /doc/sitelog/hairball-home/basic-files/vogelke/zsh/dot-zsh/RCS/prompt.zsh,v $
# $Host: hairball.my.domain $
# $UUID: 8d805226-8083-5499-b2c0-b8a21e79ad3e $
#
# ZSH prompt - different if we're running saveon.

# Set shell level using a /tmp file.  This way, it clears when I reboot
# but hopefully increments when I start a new shell.
export SHLVL=$(incfile /tmp/.shlvl.$USER)

# Allow for colors
autoload -U promptinit
promptinit

PROMPT="
(%D{%a %f %b %T}) <%?> [%5~] $program
%n at %m.%l ($SHLVL-%!-z)%# "

case "$SAVEON" in
    "") ;;
    *) prompt save ;;
esac
