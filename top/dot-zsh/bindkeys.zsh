# ZSH keybindings
#
# $Revision: 2.3 $ $Date: 2020-10-10 02:09:59-04 $
# $Source: /doc/sitelog/hairball-home/basic-files/vogelke/zsh/dot-zsh/RCS/bindkeys.zsh,v $
# $Host: hairball.my.domain $
# $UUID: 1f125751-729e-5b46-81f9-fde03b084020 $
#
# Run under emacs commandline mode
bindkey -e

# Do history expansion on space
bindkey ' ' magic-space

# Alt-O inserts "sudo " at the start of line
insert_sudo () { zle beginning-of-line; zle -U "sudo " }
zle -N insert-sudo insert_sudo
bindkey "^[o" insert-sudo
