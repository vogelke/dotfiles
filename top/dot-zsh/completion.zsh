# $Revision: 2.7 $ $Date: 2020-10-10 02:09:59-04 $
# $Source: /doc/sitelog/hairball-home/basic-files/vogelke/zsh/dot-zsh/RCS/completion.zsh,v $
# $Host: hairball.my.domain $
# $UUID: 5fd72bc0-5b96-30ed-8666-dc890deb2054 $
#
# Set up new style completion system.  To see examples of the
# old style (compctl based) programmable completion, check
# Misc/compctl-examples in the zsh distribution.
#
# NOTE: use "zstyle -d" to wipe out all style settings.

# The following lines were added by compinstall
zstyle :compinstall filename '/home/vogelke/.zsh/completion.zsh'
autoload -Uz compinit
compinit
# End of lines added by compinstall

# -------------------------------------------------------------------------
# https://grml.org/zsh/zsh-lovers.html
#
# Some functions, like _apt and _dpkg, are very slow.  You can use a cache
# in order to proxy the list of results (like the list of available debian
# packages):
ZCACHEDIR="$HOME/.zsh/cache"

# Tue, 30 Jun 2020 00:30:35 -0400
# If you have a problem with completion, i.e. a script named "dist" won't
# do filename completion because it also happens to be the name of an MH
# program, then change $ZCACHEDIR/compdump -- it's probably in there.
zstyle ':completion:*' cache-path $ZCACHEDIR
zstyle ':completion:*' use-cache on
compinit -C -d $ZCACHEDIR/compdump

# Speed up file completion.
## https://coderwall.com/p/9fksra/speed-up-your-zsh-completions
zstyle ':completion:*' accept-exact-dirs true

# Tell ZSH to take the first part of the path to be exact, and to avoid
# partial globs.  Now path completions became nearly immediate.
zstyle ':completion:*' accept-exact '*(N)'

# Fuzzy matching of completions for when you mistype them:
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric

# The number of errors allowed by _approximate increases
# with the length of what you've typed so far:
zstyle -e ':completion:*:approximate:*' \
        max-errors 'reply=($((($#PREFIX+$#SUFFIX)/3))numeric)'

# Ignore completion functions for commands you don't have:
zstyle ':completion:*:functions' ignored-patterns '_*'

# Completing process IDs with menu selection:
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*'   force-list always
zstyle ':completion:*:kill:*:processes' command '/bin/ptree'

## Nice menu for basic proc list
## zstyle ':completion:*:kill:*:processes' command \
##        '/bin/ps -o user,pid,ppid,pgid,vsz,rss,time,args'

# If you use a directory as an argument, remove
# the trailing slash (useful in ln):
zstyle ':completion:*' squeeze-slashes true

# Check local directories first.
zstyle ':completion:*:cd:*' tag-order local-directories path-directories

# formatting and messages
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*' group-name ''

# hostname completion
test -f $HOME/.hosts && hosts=(`cat $HOME/.hosts`)
zstyle '*' hosts $hosts

# Filename suffixes to ignore during completion (except after rm)
zstyle ':completion:*:*:(^rm):*:*files' ignored-patterns \
    '*?.o' '*?.c~' '*?.old' '*?.pro'
# the same for old style completion:
#fignore=(.o .c~ .old .pro)

# ignore completion functions (until the _ignored completer)
zstyle ':completion:*:functions' ignored-patterns '_*'

# -------------------------------------------------------------------------
# SOMETHING HERE MAKES COMPLETION SLOW

## insert all expansions for expand completer
#zstyle ':completion:*:expand:*' tag-order all-expansions

## match uppercase from lowercase
#zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

## offer indexes before parameters in subscripts
#zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# ----------------------------------------------------------------------
# PROBLEM: using compinit completely redoes my .zcompdump file.
# Look for "compdump" earlier in this file for workaround.
#
# Use "-u" to avoid this prompt:
#   Ignore insecure directories and continue [ny]?
## autoload -U compinit
## compinit -u
# End of lines added by compinstall
# ----------------------------------------------------------------------
#
# Sat Jun 14 01:08:43 EDT 2014
# I'm having trouble with cd completion showing other directories
# before local ones.  Found a good page:
# http://zsh.sourceforge.net/Guide/zshguide06.html
#
# Where styles differ from parameters is that they can take different
# values in different contexts.  The first argument to the zstyle
# command gives a context; when you define a style, this argument is
# actually a pattern which will be matched against the current context
# to see if the style applies.  The rule for finding out what applies
# is: exact string matches are preferred before patterns, and longer
# patterns are preferred before shorter patterns. Here's that example:
#
#   zstyle ':completion:*:cd:*' tag-order local-directories \
#     path-directories
#
# From the discussion of contexts above, the pattern will match any
# time an argument to the cd command is being completed.  The style
# being set is called tag-order, and the values are the two tags valid
# for directories in cd.
#
# The tag-order style determines the order in which tags are tried.
# The value given above means that first local-directories will be
# completed; only if none can be completed will path-directories be
# tried.  You can enter the command and try this; if you don't have
# $cdpath set up you can assign `cdpath=(~)', which will allow `cd foo'
# to change to a directory `~/foo' and allow completion of directories
# accordingly.  Go to a directory other than ~; completion for cd will
# only show subdirectories of where you are, not those of ~, unless you
# type a string which is the prefix of a directory under ~ but not your
# current directory.  For example,
#
#   % cdpath=(~)
#   % ls -F ~
#   foo/    bar/
#   % ls -F
#   rod/    stick/
#   # Without that tag-order zstyle command, you would get...
#   % cd ^D
#   bar/    foo/    rod/    stick/
#   % zstyle ':completion:*:cd:*' tag-order local-directories \
#      path-directories
#   # now you just get the local directories, if there are any...
#   % cd ^D
#   rod/    stick/

# ------------------------------------------------------------------------
# Speed up completion?

# If use-cache is set, the completion caching layer is activated for any
# completions which use it (via the _store_cache, _retrieve_cache, and
# _cache_invalid functions).  The directory containing the cache files
# can be changed with the cache-path style.
#
# _store_cache, together with _retrieve_cache and _cache_invalid,
# implements a caching layer which can be used in any completion function.
# Data obtained by costly operations are stored in parameters; this
# function then dumps the values of those parameters to a file.  The data
# can then be retrieved quickly from that file via _retrieve_cache, even
# in different instances of the shell.
#
# * The cache_identifier specifies the file which the data should be dumped
#   to.  The file is stored in a directory specified by the cache-path
#   style which defaults to ~/.zcompcache.  The remaining params arguments
#   are the parameters to dump to the file.
#
# * The return status is zero if storage was successful.  The function
#   will only attempt storage if the use-cache style is set, so you can
#   call this function without worrying about whether the user wanted to
#   use the caching layer.
#
# * The completion function may avoid calling _retrieve_cache when it
#   already has the completion data available as parameters.  However,
#   in that case it should call _cache_invalid to check whether the data
#   in the parameters and in the cache are still valid.
#
# * See the _perl_modules completion function for a simple example of the
#   usage of the caching layer.
