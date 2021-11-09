# ZSH aliases
#
# $Revision: 2.5+1 $ $Date: 2020-10-10 02:09:59-04 $
# $Source: /doc/sitelog/hairball-home/basic-files/vogelke/zsh/dot-zsh/RCS/aliases.zsh,v $
# $Host: hairball.my.domain $
# $UUID: e48296ef-9f9d-5109-b1fe-1951495cefbf $

alias 1='%1'
alias 2='%2'
alias 3='%3'
alias 4='%4'
alias 5='%5'
alias 6='%6'
alias 7='%7'
alias 8='%8'
alias 9='%9'

alias today='cd ~/today && cwd'
alias friday='cd ~/friday && cwd'
alias monday='cd ~/monday && cwd'
alias saturday='cd ~/saturday && cwd'
alias sunday='cd ~/sunday && cwd'
alias thursday='cd ~/thursday && cwd'
alias tuesday='cd ~/tuesday && cwd'
alias wednesday='cd ~/wednesday && cwd'
alias yesterday='cd ~/yesterday && cwd'
alias tomorrow='cd ~/tomorrow && cwd'

alias a='agenda'
alias back='cd "$current"'
alias cl='clear'
alias cp='nocorrect cp'       # no spelling correction on cp
alias d='/bin/ls -ld *(-/)'
alias fix='source ~/.termrc.xterm'
alias history='fc -l 1'
alias j='jobs -dl'
alias mkdir='nocorrect mkdir' # no spelling correction on mkdir
alias mv='nocorrect mv'       # no spelling correction on mv
# alias ns='( cd $HOME/work; netscape )'
alias restart='op restart'
alias rh='rehash'
# run in subshell or you mess up Netscape...
# alias se='( OLDDISP=$DISPLAY; unset DISPLAY; emacs; DISPLAY=$OLDDISP )'
alias so='.'
alias sunterm='source ~/.termrc.sun'
alias unsetenv=unset
alias x='ls -laF | fgrep "*"'
# alias yell='echo done | write $LOGNAME'
alias z='suspend'

# number conversions - brian d foy
alias d2h="perl -e 'printf qq|%X\n|, int( shift )'"
alias h2d="perl -e 'printf qq|%d\n|, hex( shift )'"

# replace run-help alias with home-grown version
unalias run-help
alias run-help=zman

# -------------------------------------------------------------------------
# GLOBAL ALIASES (anywhere on command line)
# **WARNING** these break with directories or files named L, T, or N

# alias -g L="|less" # Write L after a command to page through the output.
# alias -g T='| tail -20'
# alias -g N="> /dev/null 2>&1"

# -------------------------------------------------------------------------
# THINGS WE DON'T WANT
# the builtin pwd prints the symbolic link instead of the real directory
disable pwd

# I use scripts called "r", "which", and "mx".
# To make .zcompdump have them use _files instead of their default:
#   me% compdef _files r
#   me% compdef _files mx
#   me% compdump

disable r
test -x "/bin/gwhich" || disable which
