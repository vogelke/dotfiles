# ZSH options
#
# $Revision: 2.3 $ $Date: 2020-10-10 02:09:59-04 $
# $Source: /doc/sitelog/hairball-home/basic-files/vogelke/zsh/dot-zsh/RCS/setopt.zsh,v $
# $Host: hairball.my.domain $
# $UUID: 8d46f314-7321-50cd-98ff-4d6d56e36061 $

setopt appendhistory      # append to history file
setopt autocd             # go to directory if first word on command line
                          # is a directory
setopt autoresume         # single-word commands may resume suspended job
setopt cdablevars         # allows cd'ing to a parameter
setopt correct            # try to correct the spelling of commands
setopt csh_junkie_loops   # allow short form of loops: list; end
setopt extendedglob       # allow # and ^ to be used for filename generation
setopt extended_history   # format: <start-time>:<elapsed-sec>:<command>
setopt globdots           # don't require leading . in filename to be matched
setopt histignoredups     # don't store duplicate lines in command history
setopt histnostore        # don't store history commands in history
setopt ignoreeof          # don't logout using Control-D
setopt longlistjobs       # list jobs in long format by default
setopt markdirs           # append trailing / to dirnames
setopt menucomplete       # cycle through completions when ambiguous
#setopt menucompletebeep  # beep on ambiguous completion
setopt numeric_globsort   # sort numeric filenames numerically
setopt noclobber          # don't overwrite existing files
setopt notify             # tell me when a job finishes
setopt rcquotes           # '' = single quote in single-quoted strings

unsetopt bgnice           # don't run background jobs at lower priority
