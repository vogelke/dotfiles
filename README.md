## Table of contents

<!--ts-->
   * [Quick start](#quick-start)
   * [Ack](#ack)
   * [Building from source](#building-from-source)
   * [Changing directories quickly](#changing-directories-quickly)
   * [Command history](#command-history)
   * [Crypto: signify](#crypto-signify)
   * [Environment variables](#environment-variables)
   * [GNU info](#gnu-info)
   * [Humor](#humor)
   * [Mail: Mutt](#mail-mutt)
   * [Mail: procmail](#mail-procmail)
   * [Mail: qmail](#mail-qmail)
   * [Mail: Tagged-message delivery agent](#mail-tagged-message-delivery-agent)
   * [Pagers: less and most](#pagers-less-and-most)
   * [Perl](#perl)
   * [PDF viewer](#pdf-viewer)
   * [Recording your terminal session](#recording-your-terminal-session)
   * [Screen and Tmux](#screen-and-tmux)
   * [Shell: Basic setup](#shell-basic-setup)
   * [Shell: Bash](#shell-bash)
   * [Shell: Korn shell](#shell-korn-shell)
   * [Shell: TCSH](#shell-tcsh)
   * [Shell: Zsh](#shell-zsh)
   * [SSH](#ssh)
   * [Template Toolkit](#template-toolkit)
   * [Terminal setup](#terminal-setup)
   * [VCS: Git](#vcs-git)
   * [VCS: Mercurial](#vcs-mercurial)
   * [VIM](#vim)
   * [Web: Creating pages](#web-creating-pages)
   * [Web: Curl](#web-curl)
   * [Web: Firefox](#web-firefox)
   * [Web: Lynx](#web-lynx)
   * [Web: Tidying up pages](#web-tidying-up-pages)
   * [Web: Wget](#web-wget)
   * [Web: W3M](#web-w3m)
   * [X-Windows: setup](#x-windows-setup)
   * [X-Windows: Fluxbox](#x-windows-fluxbox)
   * [X-Windows: FVWM](#x-windows-fvwm)
<!--te-->

### Quick start

So, here are my dotfiles.  I've included some brief descriptions where
appropriate -- most of them have at least a few comments.

----
### Ack

Ack is about the neatest thing since sliced bread for grubbing around
in code.  It's fast, portable, ignores VCS directories, and gives good
search results.  Have a look [here](https://beyondgrep.com/why-ack/) for more.

My setup uses basic colors for matching, has decent defaults for directories
(Bazaar, Mercurial) and files to ignore (backups, VI/VIM swap, etc),
and shows how to use defined filetypes.

<pre>
<a href="top/dot-ackrc">+--dot-ackrc</a>
</pre>

----
### Building from source

The RPM-macros file holds my settings for building from a source RPM.
A much more thorough one can be found
[here](http://cholla.mmto.org/computers/linux/rpm/dotrpmmacros.html).

<pre>
<a href="top/dot-rpmmacros">+--dot-rpmmacros</a>
</pre>

----
### Changing directories quickly

I like to minimize keystrokes and typing in general, so when I saw a Stack
Overflow posting about moving between directories with one keystroke,
I jumped all over it.  Unfortunately that posting has disappeared, but
I have functions that will do the trick under Bash and ZSH.

You'll need a program called *grabchars* for this to work.  Grabchars lets
you handle single-character feedback in a portable fashion via command
line or shell-script.  For example, running

```
grabchars -c 0123456789 -n2 -t10
```

interactively reads two numbers with a ten-second timeout, no need to press
return after the numbers.  It's available on Linux boxes, but if you're
running a BSD box and you need to build from source, $DEITY help you.
It's written using sgtty, but the BSDs use termios and moving between them
is a complete goatrope.

<pre>
<a href="top/dot-cdlist">+--dot-cdlist</a>
</pre>

My *.cdlist* file holds 33 directories I use frequently, prefixed with a
number or letter.  I have a shell function **g** which displays that list,
uses grabchars to get your choice, and takes you immediately to that
directory.  Here's the Bash version:

```
g () {
    cat $HOME/.cdlist
    local prompt="dir: "
    local ans=$(grabchars -d0 -L -c '[0-9a-zA-Z]' -q"$prompt")
    set X $(grep "^$ans" $HOME/.cdlist)
    case "$#" in
        (3) builtin cd $3 && pwd ;;
        (*) echo no such entry ;;
    esac
}
```

Here's the ZSH version, which will look for another *.cdlist* file in
the target directory and run recursively if found:

```
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
```

----
### Command history

I like keeping my command-line history in a way that doesn't depend on a
particular shell.  I also want to keep history indefinitely *without* ending
up with a single 80-Mb file, especially since ZSH used to have a bad habit
of corrupting the history by randomly adding control characters to entries.

Here's a ZSH function to log commands, return codes and the current
directory.  It uses a hook function called **precmd**, which is executed
before each prompt:

```
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
```

The function uses a script called **cmdlog** to append the shell PID, last
return code, directory, and command string to the file $HOME/.log/today,
which is hard-linked to $HOME/.log/YYYY/MMDD.  There's not much to it:

```
#!/bin/sh
#< cmdlog: store commands in current logfile.
exec /bin/echo $(/bin/date "+%T") ${1+"$@"} >> $HOME/.log/today
exit 1
```

You can use something like `/usr/bin/logger -p local5.info ${1+"$@"}`
instead if you'd rather.  It's originally based on:

```
http://blogs.sun.com/chrisg/entry/logging_commands_in_korn_shell
Logging commands in korn shell
Chris Gerhard
Thu, 2 Mar 2006 09:47:29 -0500
```

I use a similar setup for bash, which you'll find in the bash rc files.

<pre>
+--<a href="top/dot-log">dot-log</a>
|   +--<a href="top/dot-log/2021">2021</a>
|   |   +--<a href="top/dot-log/2021/1106">1106</a>
|   |   +--<a href="top/dot-log/2021/1107">1107</a>
|   +--<a href="top/dot-log/today">today</a>        linked to current YYYY/MMDD
</pre>

In ZSH, I occasionally dump a paragraph of text or something equally
useless into the command line without intending to, so this function helps
me clean that up:

```
unset -f histedit 2> /dev/null
histedit () {
    _x="$HOME/.zsh/.histedit"
    fc -ln 1 > $_x && vi $_x && fc -R $_x && rm $_x
}
```

----
### Crypto: signify

This is an OpenBSD program available on FreeBSD through the ports system,
and on Linux via [Github](https://github.com/aperezdc/signify).  The Linux
version is supposed to be portable, but I haven't used it.

<pre>
+--<a href="top/dot-signify">dot-signify</a>
|   +--<a href="top/dot-signify/sign.pub">sign.pub</a>
|   +--<a href="top/dot-signify/sign.sec">sign.sec</a>
</pre>

**signify** creates and checks cryptographic signatures, which are used to
verify the integrity of a message.  You can verify entire directory trees,
zip archives, or individual files.  From the manpage:

```
Create a new key pair:
   $ signify -G -p newkey.pub -s newkey.sec

Sign a file, specifying a signature name:
   $ signify -S -s key.sec -m message.txt -x msg.sig

Verify a signature, using the default signature name:
   $ signify -V -p key.pub -m generalsorders.txt
```

----
### Environment variables

<pre>
+--<a href="top/dot-env">dot-env</a>
|   +--<a href="top/dot-env/BLOCKSIZE">BLOCKSIZE</a>
|   +--<a href="top/dot-env/DOCROOT">DOCROOT</a>
|   +--<a href="top/dot-env/DOMAIN">DOMAIN</a>
|   +--<a href="top/dot-env/EDITOR">EDITOR</a>
|   +--<a href="top/dot-env/PAGER">PAGER</a>
|   +--<a href="top/dot-env/PATH">PATH</a>
|   +--<a href="top/dot-env/SHELL">SHELL</a>
|   +--<a href="top/dot-env/TERM">TERM</a>
|   +--<a href="top/dot-env/TERMINFO">TERMINFO</a>
+--<a href="top/dot-envrc">dot-envrc</a>
+--<a href="top/dot-envrc.csh">dot-envrc.csh</a>
+--<a href="top/dot-envrc.sh">dot-envrc.sh</a>
+--<a href="top/dot-javapath">dot-javapath</a>
+--<a href="top/dot-manpath">dot-manpath</a>
+--<a href="top/dot-path">dot-path</a>
+--<a href="top/dot-current">dot-current</a>
+--<a href="top/dot-dircolors">dot-dircolors</a>
+--<a href="top/dot-dircolors.sh">dot-dircolors.sh</a>
</pre>

----
### GNU info

Makes "info" a bit more usable by *not* having the viewer automatically
jump between chapters.

<pre>
+--<a href="top/dot-infokey">dot-infokey</a>
</pre>

----
### Humor

Stupid quotes I've been collecting since the early '90s.

<pre>
+--<a href="top/dot-quotes">dot-quotes</a>
</pre>

----
### Mail: Mutt

If you get a ton of mail and you want a quick, efficient client to handle
it, you can't do much better than Mutt.

<pre>
+--<a href="top/dot-muttrc">dot-muttrc</a>
+--<a href="top/dot-muttrc.maildir">dot-muttrc.maildir</a>
+--<a href="top/dot-mutt">dot-mutt</a>
|  +--<a href="top/dot-mutt/SETUP">SETUP</a>
|  +--<a href="top/dot-mutt/auto_views">auto_views</a>
|  +--<a href="top/dot-mutt/bindings">bindings</a>
|  +--<a href="top/dot-mutt/fcc-hooks">fcc-hooks</a>
|  +--<a href="top/dot-mutt/folder-hooks">folder-hooks</a>
|  +--<a href="top/dot-mutt/headers">headers</a>
|  +--<a href="top/dot-mutt/macros">macros</a>
|  +--<a href="top/dot-mutt/mailboxes">mailboxes</a>
|  +--<a href="top/dot-mutt/message-hooks">message-hooks</a>
|  +--<a href="top/dot-mutt/muttrc-original">muttrc-original</a>
|  +--<a href="top/dot-mutt/non-standard">non-standard</a>
|  +--<a href="top/dot-mutt/save-hooks">save-hooks</a>
|  +--<a href="top/dot-mutt/signature">signature</a>
</pre>

One of the things I like best is the ability to use external programs in
your settings.  In my .muttrc file:

<pre>
# Generate a signature with a quote.
set signature="makesig|"        # file which contains my signature

# Convert date to local timezone.
set display_filter="~/libexec/display-local-date"
</pre>

**makesig** prints a generic signature and then adds a random quote.
Here's **display-local-date**:

<pre>
#!/bin/sh
#<display-local-date: display date in my timezone.

export PATH=/usr/local/bin:/bin:/usr/bin
tmp=/tmp/dsp.$$.$RANDOM    # mktemp is overkill here.

cat - > $tmp                     # save the message,
DATE=$(formail -xDate: < $tmp)   # extract and convert the date,
DATE=$(date -R -d "$DATE")
echo "Date: $DATE"               # and output the modified message
formail -fI Date < $tmp
rm -f $tmp
exit 0
</pre>

These are a few color-schemes I've tried.  I settled on "xterm-prod"
because my eyesight sucks and this one was the least distracting.

<pre>
|  +--<a href="top/dot-mutt/colours">colours</a>
|  +--<a href="top/dot-mutt/colours-modified-dark">colours-modified-dark</a>
|  +--<a href="top/dot-mutt/colours-order">colours-order</a>
|  +--<a href="top/dot-mutt/colours-production">colours-production</a>
|  +--<a href="top/dot-mutt/colours-randy">colours-randy</a>
|  +--<a href="top/dot-mutt/colours-reverse-bw">colours-reverse-bw</a>
|  +--<a href="top/dot-mutt/colours-stackoverflow">colours-stackoverflow</a>
|  +--<a href="top/dot-mutt/colours-test">colours-test</a>
|  +--<a href="top/dot-mutt/colours-ucla">colours-ucla</a>
|  +--<a href="top/dot-mutt/colours-xterm-prod">colours-xterm-prod</a>
</pre>

**Solarized** is a 16-color palette (8 monotones, 8 accent colors) designed
for use with terminal and GUI applications.  It has a few nice properties:

- Reduces brightness contrast but, unlike many low contrast colorschemes,
retains contrasting hues for syntax highlighting readability.

- Switching from dark to light mode retains the same perceived contrast
in brightness between each value.  Each mode is equally readable.

<pre>
|  +--<a href="top/dot-mutt/solarized">solarized</a>
|  |  +--<a href="top/dot-mutt/solarized/README.md">README.md</a>
|  |  +--<a href="top/dot-mutt/solarized/3b23c55-dark-16">3b23c55-dark-16</a>
|  |  +--<a href="top/dot-mutt/solarized/3b23c55-dark-256">3b23c55-dark-256</a>
|  |  +--<a href="top/dot-mutt/solarized/3b23c55-light-16">3b23c55-light-16</a>
|  |  +--<a href="top/dot-mutt/solarized/3b23c55-light-256">3b23c55-light-256</a>
|  |  +--<a href="top/dot-mutt/solarized/3b23c55-template">3b23c55-template</a>
|  |  +--<a href="top/dot-mutt/solarized/mutt-compile-colors.sh">mutt-compile-colors.sh</a>
</pre>

----
### Mail: procmail

<pre>
+--<a href="top/dot-procmailrc">dot-procmailrc</a>
</pre>

----
### Mail: qmail

<pre>
+--<a href="top/dot-qmail">dot-qmail</a>
+--<a href="top/dot-qmail-bcc">dot-qmail-bcc</a>
+--<a href="top/dot-qmail-blog">dot-qmail-blog</a>
+--<a href="top/dot-qmail-default">dot-qmail-default</a>
+--<a href="top/dot-qmail-header">dot-qmail-header</a>
+--<a href="top/dot-qmail-maildir">dot-qmail-maildir</a>
+--<a href="top/dot-qmail-xnote">dot-qmail-xnote</a>
</pre>

----
### Mail: Tagged-message delivery agent

<pre>
+--<a href="top/dot-tmda">dot-tmda</a>
|   +--<a href="top/dot-tmda/config">config</a>
|   +--<a href="top/dot-tmda/crypt_key">crypt_key</a>
</pre>

----
### Pagers: less and most

<pre>
+--<a href="top/dot-less">dot-less</a>
+--<a href="top/dot-lessenv">dot-lessenv</a>
+--<a href="top/dot-lesskey">dot-lesskey</a>
+--<a href="top/dot-mostrc">dot-mostrc</a>
</pre>

----
### Perl

<pre>
+--<a href="top/dot-perlcriticrc">dot-perlcriticrc</a>
+--<a href="top/dot-perltidyrc">dot-perltidyrc</a>
</pre>

----
### PDF viewer

<pre>
+--<a href="top/dot-xpdfrc">dot-xpdfrc</a>
</pre>

----
### Recording your terminal session

<pre>
+--<a href="top/dot-hardcopy">dot-hardcopy</a>
</pre>

----
### Screen and Tmux

<pre>
+--<a href="top/dot-screenrc">dot-screenrc</a>
+--<a href="top/dot-tmux.conf">dot-tmux.conf</a>
</pre>

----
### Shell: Basic setup

<pre>
+--<a href="top/dot-profile">dot-profile</a>
+--<a href="top/dot-shrc">dot-shrc</a>
</pre>

----
### Shell: Bash

<pre>
+--<a href="top/dot-bashalias">dot-bashalias</a>
+--<a href="top/dot-bashrc">dot-bashrc</a>
+--<a href="top/dot-bash_dircolors">dot-bash_dircolors</a>
+--<a href="top/dot-bash_login">dot-bash_login</a>
+--<a href="top/dot-bash_logout">dot-bash_logout</a>
+--<a href="top/dot-bash_profile">dot-bash_profile</a>
</pre>

----
### Shell: Korn shell

<pre>
+--<a href="top/dot-kshrc">dot-kshrc</a>
</pre>

----
### Shell: TCSH

<pre>
+--<a href="top/dot-cshrc">dot-cshrc</a>
+--<a href="top/dot-tcshrc">dot-tcshrc</a>
+--<a href="top/dot-login">dot-login</a>
+--<a href="top/dot-logout">dot-logout</a>
</pre>

----
### Shell: Zsh

<pre>
+--<a href="top/dot-zshrc">dot-zshrc</a>
+--<a href="top/dot-zlogin">dot-zlogin</a>
+--<a href="top/dot-zcompdump">dot-zcompdump</a>

+--<a href="top/dot-zsh">dot-zsh</a>
|  +--<a href="top/dot-zsh/aliases.zsh">aliases.zsh</a>
|  +--<a href="top/dot-zsh/bindkeys.zsh">bindkeys.zsh</a>
|  +--<a href="top/dot-zsh/cache">cache</a>
|  |  +--<a href="top/dot-zsh/cache/RPMs">RPMs</a>
|  |  +--<a href="top/dot-zsh/cache/compdump">compdump</a>
|  |  +--<a href="top/dot-zsh/cache/perl_modules">perl_modules</a>
|  |  +--<a href="top/dot-zsh/cache/python_modules">python_modules</a>
|  +--<a href="top/dot-zsh/colors.zsh">colors.zsh</a>
|  +--<a href="top/dot-zsh/completion.zsh">completion.zsh</a>
|  +--<a href="top/dot-zsh/exports.zsh">exports.zsh</a>
|  +--<a href="top/dot-zsh/functions.zsh">functions.zsh</a>
|  +--<a href="top/dot-zsh/hg-completion">hg-completion</a>
|  +--<a href="top/dot-zsh/history.zsh">history.zsh</a>
|  +--<a href="top/dot-zsh/hooks.zsh">hooks.zsh</a>
|  +--<a href="top/dot-zsh/init.zsh">init.zsh</a>
|  +--<a href="top/dot-zsh/prompt.zsh">prompt.zsh</a>
|  +--<a href="top/dot-zsh/setopt.zsh">setopt.zsh</a>
</pre>

----
### SSH

I've included the parts of my server and client configuration files that you
can use to make a host STIG-compliant (MAC-2 Sensitive).  tl;dr -- you need
more for Top-Seekie-No-Peekie stuff, but it's fine for most other things.

The **newkey** script will create new keys for connecting to a given host.
I like having a unique keypair for every host I use.

<pre>
+--<a href="top/dot-ssh">dot-ssh</a>
|   +--<a href="top/dot-ssh/newkey">newkey</a>
|   +--<a href="top/dot-ssh/ssh_config">ssh_config</a>
|   +--<a href="top/dot-ssh/sshd_config">sshd_config</a>
</pre>

----
### Template Toolkit

<pre>
+--<a href="top/dot-tpagerc">dot-tpagerc</a>
+--<a href="top/dot-ttreerc">dot-ttreerc</a>
+--<a href="top/dot-config">dot-config</a>
|   +--<a href="top/dot-config/ttree">ttree</a>
|   |   +--<a href="top/dot-config/ttree/sunpage">sunpage</a>
</pre>

----
### Terminal setup

<pre>
+--<a href="top/dot-termrc.gnome-term">dot-termrc.gnome-term</a>
+--<a href="top/dot-termrc.xterm">dot-termrc.xterm</a>
</pre>

----
### VCS: Git

<pre>
+--<a href="top/dot-gitattributes">dot-gitattributes</a>
+--<a href="top/dot-gitconfig">dot-gitconfig</a>
+--<a href="top/dot-gitignore">dot-gitignore</a>
</pre>

----
### VCS: Mercurial

<pre>
+--<a href="top/dot-hg">dot-hg</a>
|   +--<a href="top/dot-hg/multiline">multiline</a>
|   +--<a href="top/dot-hg/style">style</a>
+--<a href="top/dot-hgignore">dot-hgignore</a>
+--<a href="top/dot-hgrc">dot-hgrc</a>
</pre>

----
### VIM

<pre>
+--<a href="top/dot-vimrc">dot-vimrc</a>
+--<a href="top/dot-vimrc-green">dot-vimrc-green</a>
+--<a href="top/dot-vimrc-mutt">dot-vimrc-mutt</a>
+--<a href="top/dot-vimrc-prod">dot-vimrc-prod</a>
+--<a href="top/dot-vimrc-share">dot-vimrc-share</a>
+--<a href="top/dot-vimrc-simple">dot-vimrc-simple</a>

+--<a href="top/dot-vim">dot-vim</a>
|  +--<a href="top/dot-vim/colors">colors</a>
|  |  +--<a href="top/dot-vim/colors/bernhard.vim">bernhard.vim</a>
|  |  +--<a href="top/dot-vim/colors/molokai.vim">molokai.vim</a>
|  |  +--<a href="top/dot-vim/colors/muratori.vim">muratori.vim</a>
|  |  +--<a href="top/dot-vim/colors/murphy.vim">murphy.vim</a>
|  |  +--<a href="top/dot-vim/colors/nofrils-acme.vim">nofrils-acme.vim</a>
|  |  +--<a href="top/dot-vim/colors/nofrils-blue.vim">nofrils-blue.vim</a>
|  |  +--<a href="top/dot-vim/colors/nofrils-dark.vim">nofrils-dark.vim</a>
|  |  +--<a href="top/dot-vim/colors/nofrils-green.vim">nofrils-green.vim</a>
|  |  +--<a href="top/dot-vim/colors/nofrils-light.vim">nofrils-light.vim</a>
|  |  +--<a href="top/dot-vim/colors/nofrils-sepia.vim">nofrils-sepia.vim</a>
|  |  +--<a href="top/dot-vim/colors/shirotelin.vim">shirotelin.vim</a>
|  |  +--<a href="top/dot-vim/colors/vadelma.vim">vadelma.vim</a>
|  |  +--<a href="top/dot-vim/colors/wikipedia.vim">wikipedia.vim</a>
|  +--<a href="top/dot-vim/colorsample.vim">colorsample.vim</a>
|  +--<a href="top/dot-vim/dynamic">dynamic</a>
|  |  +--<a href="top/dot-vim/dynamic/css">css</a>
|  |  +--<a href="top/dot-vim/dynamic/htm">htm</a>
|  |  +--<a href="top/dot-vim/dynamic/md">md</a>
|  |  +--<a href="top/dot-vim/dynamic/pl">pl</a>
|  |  +--<a href="top/dot-vim/dynamic/sh">sh</a>
|  |  +--<a href="top/dot-vim/dynamic/txt">txt</a>
|  +--<a href="top/dot-vim/filetype.vim">filetype.vim</a>
|  +--<a href="top/dot-vim/ftplugin">ftplugin</a>
|  |  +--<a href="top/dot-vim/ftplugin/c.vim">c.vim</a>
|  |  +--<a href="top/dot-vim/ftplugin/perl.vim">perl.vim</a>
|  |  +--<a href="top/dot-vim/ftplugin/txt.vim">txt.vim</a>
|  +--<a href="top/dot-vim/plugin">plugin</a>
|  |  +--<a href="top/dot-vim/plugin/justify.vim">justify.vim</a>
|  |  +--<a href="top/dot-vim/plugin/obviousmode.vim">obviousmode.vim</a>
|  |  +--<a href="top/dot-vim/plugin/setcolors.vim">setcolors.vim</a>
|  |  +--<a href="top/dot-vim/plugin/templates.vim">templates.vim</a>
|  +--<a href="top/dot-vim/syntax">syntax</a>
|  |  +--<a href="top/dot-vim/syntax/crontab.vim">crontab.vim</a>
|  |  +--<a href="top/dot-vim/syntax/perl.vim">perl.vim</a>
|  |  +--<a href="top/dot-vim/syntax/sh.vim">sh.vim</a>
|  |  +--<a href="top/dot-vim/syntax/syncolor.vim">syncolor.vim</a>
|  |  +--<a href="top/dot-vim/syntax/syntax.vim">syntax.vim</a>
|  |  +--<a href="top/dot-vim/syntax/txt2tags.vim">txt2tags.vim</a>
|  +--<a href="top/dot-vim/undodir">undodir</a>
|  +--<a href="top/dot-vim/view">view</a>
|  +--<a href="top/dot-vim/xterm256-colors.vim">xterm256-colors.vim</a>
</pre>

----
### Web: Creating pages

<pre>
+--<a href="top/dot-txt2html.dict">dot-txt2html.dict</a>
+--<a href="top/dot-txt2htmlrc">dot-txt2htmlrc</a>
+--<a href="top/dot-txt2tagsrc">dot-txt2tagsrc</a>
</pre>

----
### Web: Curl

<pre>
+--<a href="top/dot-curlrc">dot-curlrc</a>
</pre>

----
### Web: Firefox

<pre>
+--<a href="top/dot-mozilla">dot-mozilla</a>
|   +--<a href="top/dot-mozilla/userChrome.css">userChrome.css</a>
</pre>

----
### Web: Lynx

<pre>
+--<a href="top/dot-lynx.lss">dot-lynx.lss</a>
+--<a href="top/dot-lynxcfg">dot-lynxcfg</a>
</pre>

----
### Web: Tidying up pages

<pre>
+--<a href="top/dot-tidyrc">dot-tidyrc</a>
+--<a href="top/dot-tidyxmlrc">dot-tidyxmlrc</a>
</pre>

----
### Web: Wget

<pre>
+--<a href="top/dot-wgetrc">dot-wgetrc</a>
</pre>

----
### Web: W3M

<pre>
+--<a href="top/dot-w3m">dot-w3m</a>
|   +--<a href="top/dot-w3m/config">config</a>
</pre>

----
### X-Windows: setup

I don't boot into X; I'd much rather start a regular console session and
then run *xinit* when I'm ready.

I've tried several terminal emulators, but when it comes to memory size,
responsiveness, and functionality, I always end up going back to **xterm**.
My .Xdefaults file has lots of stuff taken from the xterm maintainer's site.

<pre>
+--<a href="top/dot-Xdefaults">dot-Xdefaults</a>
+--<a href="top/dot-Xdefaults.urxvt">dot-Xdefaults.urxvt</a>
+--<a href="top/dot-Xdefaults.xalarm">dot-Xdefaults.xalarm</a>

+--<a href="top/dot-xinitrc">dot-xinitrc</a>         --linked to xinitrc-fluxbox
+--<a href="top/dot-xinitrc-fluxbox">dot-xinitrc-fluxbox</a>
+--<a href="top/dot-xinitrc-fvwm2">dot-xinitrc-fvwm2</a>
+--<a href="top/dot-xinitrc-kde">dot-xinitrc-kde</a>
+--<a href="top/dot-xinitrc-metacity">dot-xinitrc-metacity</a>

+--<a href="top/dot-xmodmap">dot-xmodmap</a>
+--<a href="top/dot-xmodmap.swapcaps">dot-xmodmap.swapcaps</a>
</pre>

If you have the Xft libraries installed, you can exercise fine control over
fonts.  Here's how I start one of two Xterm sessions at login:

```
/usr/local/bin/xterm -geometry 80x40-0+0 -j -b 10 -sb -si \
    -sk -ls -cr blue -sl 4000 -bd black -bg #ffffff -u8   \
    -fa xft:Cascadia:pixelsize=20:bold -title Remote
```

----
### X-Windows: Fluxbox

This is the easiest window-manager I've ever used.  I was able to build
from source in about 20 minutes, and it took maybe another 30 to get it
set up exactly the way I wanted:

* Desktop 1 with two XTerm sessions
* Desktop 2 with Firefox taking up the whole screen
* Two more desktops in reserve for things like PDF viewing, etc.
* F1-F4 move immediately to Desktop 1-4, respectively
* F5 locks the screen
* F10 takes a screenshot
* F11 toggles fullscreen on or off in XTerms
* F12 flips between XTerms; focus-follows-mouse works
* PageUp/Down scrolls XTerms and Firefox sensibly
* Arrow keys work sensibly in VIM and my shell

<pre>
<a href="top/dot-xinitrc-fluxbox">dot-xinitrc-fluxbox</a>

+--<a href="top/dot-fluxbox">dot-fluxbox</a>
|  +--<a href="top/dot-fluxbox/apps">apps</a>
|  +--<a href="top/dot-fluxbox/init">init</a>
|  +--<a href="top/dot-fluxbox/keys">keys</a>
|  +--<a href="top/dot-fluxbox/lastwallpaper">lastwallpaper</a>
|  +--<a href="top/dot-fluxbox/log">log</a>
|  +--<a href="top/dot-fluxbox/menu">menu</a>
|  +--<a href="top/dot-fluxbox/overlay">overlay</a>
|  +--<a href="top/dot-fluxbox/startup">startup</a>
|  +--<a href="top/dot-fluxbox/styles">styles</a>
|  |  +--<a href="top/dot-fluxbox/styles/LemonSpace">LemonSpace</a>
|  |  +--<a href="top/dot-fluxbox/styles/Meta">Meta</a>
|  +--<a href="top/dot-fluxbox/windowmenu">windowmenu</a>
</pre>

----
### X-Windows: FVWM

If you're REALLY old-school, knock yourself out.

<pre>
<a href="top/dot-xinitrc-fvwm2">dot-xinitrc-fvwm2</a>

+--<a href="top/dot-fvwm">dot-fvwm</a>
|   +--<a href="top/dot-fvwm/config">config</a>
|   +--<a href="top/dot-fvwm/fvwm_icons">fvwm_icons</a>
|   |   +--<a href="top/dot-fvwm/fvwm_icons/arrdown2.xpm">arrdown2.xpm</a>
|   |   +--<a href="top/dot-fvwm/fvwm_icons/arrows2.xpm">arrows2.xpm</a>
|   |   +--<a href="top/dot-fvwm/fvwm_icons/arrup2.xpm">arrup2.xpm</a>
|   |   +--<a href="top/dot-fvwm/fvwm_icons/xterm.xpm">xterm.xpm</a>
|   |   +--<a href="top/dot-fvwm/fvwm_icons/xv.xpm">xv.xpm</a>
|   |   +--<a href="top/dot-fvwm/fvwm_icons/xv2.xpm">xv2.xpm</a>
|   |   +--<a href="top/dot-fvwm/fvwm_icons/xview.xpm">xview.xpm</a>
|   +--<a href="top/dot-fvwm/SETUP">SETUP</a>
</pre>

That's all, folks.
