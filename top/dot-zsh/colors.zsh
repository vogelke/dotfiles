# A colorful shell is a happy shell, but the color-codes are dopey.
# Let's give them some readable names.
#
# $Revision: 2.4 $ $Date: 2020-10-10 02:09:59-04 $
# $Source: /doc/sitelog/hairball-home/basic-files/vogelke/zsh/dot-zsh/RCS/colors.zsh,v $
# $Host: hairball.my.domain $
# $UUID: 7c10a9d1-877d-522b-a2f0-da8cd7593683 $
#
autoload colors; colors

# The variables are wrapped in \%\{\%\}. This should be the case for
# every variable that does not contain space.
for COLOR in RED GREEN YELLOW BLUE MAGENTA CYAN BLACK WHITE; do
  eval PR_$COLOR='%{$fg_no_bold[${(L)COLOR}]%}'
  eval PR_BOLD_$COLOR='%{$fg_bold[${(L)COLOR}]%}'
done

eval RESET='$reset_color'
export PR_RED       PR_GREEN      PR_YELLOW     PR_BLUE
export PR_BLACK     PR_BOLD_RED   PR_BOLD_GREEN PR_BOLD_YELLOW
export PR_BOLD_BLUE PR_BOLD_WHITE PR_BOLD_BLACK PR_WHITE

# Clear color setup.
unset LSCOLORS
export CLICOLOR=1

# Main change, you can see directories on a dark background
export LSCOLORS=gxfxcxdxbxegedabagacad
#export LSCOLORS=exfxcxdxbxegedabagacad

# Tue, 04 Jun 2019 22:55:53 -0400
# Much better result when you use basic dircolors -- /dev doesn't look
# like you're on acid.
test -f $HOME/.dircolors.sh && . $HOME/.dircolors.sh
