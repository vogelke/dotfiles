# $Revision: 2.4+2 $ $Date: 2020-10-10 02:09:59-04 $
# $Source: /doc/sitelog/hairball-home/basic-files/vogelke/zsh/dot-zsh/RCS/hooks.zsh,v $
# $Host: hairball.my.domain $
# $UUID: 72ffa680-518c-5938-995f-d31b69a16c4f $
#
# Controls the use of the precmd, preexec and postcmd features;
# mostly used to log commands and set title bar when using X-windows.

case "$TERM" in
    xterm*|rxvt*)
        # Only need to do this when changing directories.
        function chpwd {
            local dir="${PWD}"
            local title="${LOGNAME}@${HOST}:$dir"
            print -n -D -P "\033]2;${title}\007"
            /bin/pwd >> ~/.cdlist.new

            # Check for a file called ".env" in the new directory, and
            # source it if found.  Saves a lot of time if you often switch
            # between projects.  "-G" makes sure the file is owned by your
            # effective group id.
            local _efile='./.env'
            test -f "$_efile" && test -G "$_efile" &&
                echo "sourcing $_efile" && source "$_efile"
        }
        ;;

    # Fix the keyboard if it's the console.
    at386) loadkeys /usr/share/lib/keytables/type_6/layout_36 ;;

    *)  ;;
esac

# Log commands, return codes and the current working directory.
# Based on:
#
#   http://blogs.sun.com/chrisg/entry/logging_commands_in_korn_shell
#   Logging commands in korn shell
#   Chris Gerhard
#   Thu, 2 Mar 2006 09:47:29 -0500
#
# Don't try to put local on the x= line.  If you do,
# any command arguments (i.e., "ls -la") will throw an error:
#   precmd:local:2: not an identifier: -la
unset -f precmd 2> /dev/null
function precmd {
    typeset -i stat=$?
    local _x
    _x=$(fc -ln -1)
    local _d="$(/bin/pwd)"
    $HOME/libexec/cmdlog $$ $stat: $_d: \($_x\)
}

# X-win "security".
case "$WINDOWID" in
    "") ;;
    *)  xhost + 192.168.48.1 192.168.48.2 ;;
esac

# Do this last, in case history is mangled.
fc -R $HISTFILE
