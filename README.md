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

<pre>
+--<a href="top/dot-bashlog">dot-bashlog</a>
|   +--<a href="top/dot-bashlog/2019">2019</a>
|   |   +--<a href="top/dot-bashlog/2019/0125">0125</a>
+--<a href="top/dot-log">dot-log</a>
|   +--<a href="top/dot-log/2021">2021</a>
|   |   +--<a href="top/dot-log/2021/0101">0101</a>
|   |   +--<a href="top/dot-log/2021/0102">0102</a>
|   |   +--<a href="top/dot-log/2021/1106">1106</a>
|   |   +--<a href="top/dot-log/2021/1107">1107</a>
|   +--<a href="top/dot-log/today">today</a>        linked to current YYYY/MMDD
</pre>

----
### Crypto: signify

```
+--dot-signify
|   +--sign.pub
|   +--sign.sec
```

----
### Environment variables

```
+--dot-env
|   +--BLOCKSIZE
|   +--DOCROOT
|   +--DOMAIN
|   +--EDITOR
|   +--PAGER
|   +--PATH
|   +--SHELL
|   +--TERM
|   +--TERMINFO
+--dot-envrc
+--dot-envrc.csh
+--dot-envrc.sh
+--dot-javapath
+--dot-manpath
+--dot-path
+--dot-current
+--dot-dircolors
+--dot-dircolors.sh
```

----
### GNU info

```
+--dot-infokey
```

----
### Humor

```
+--dot-quotes
```

----
### Mail: Mutt

```
+--dot-muttrc
+--dot-muttrc.maildir
+--dot-mutt
|   +--auto_views
|   +--bindings
|   +--colours
|   +--colours-modified-dark
|   +--colours-order
|   +--colours-production
|   +--colours-randy
|   +--colours-reverse-bw
|   +--colours-stackoverflow
|   +--colours-test
|   +--colours-ucla
|   +--colours-xterm-prod
|   +--fcc-hooks
|   +--folder-hooks
|   +--headers
|   +--macros
|   +--mailboxes
|   +--message-hooks
|   +--muttrc-original
|   +--non-standard
|   +--save-hooks
|   +--SETUP
|   +--signature
|   +--solarized
|   |   +--3b23c55-dark-16
|   |   +--3b23c55-dark-256
|   |   +--3b23c55-light-16
|   |   +--3b23c55-light-256
|   |   +--3b23c55-template
|   |   +--mutt-compile-colors.sh
|   |   +--README.md
```

----
### Mail: procmail

```
+--dot-procmailrc
```

----
### Mail: qmail

```
+--dot-qmail
+--dot-qmail-bcc
+--dot-qmail-blog
+--dot-qmail-default
+--dot-qmail-header
+--dot-qmail-maildir
+--dot-qmail-xnote
```

----
### Mail: Tagged-message delivery agent

```
+--dot-tmda
|   +--config
|   +--crypt_key
```

----
### Pagers: less and most

```
+--dot-less
+--dot-lessenv
+--dot-lesskey
+--dot-mostrc
```

----
### Perl

```
+--dot-perlcriticrc
+--dot-perltidyrc
```

----
### PDF viewer

```
+--dot-xpdfrc
```

----
### Recording your terminal session

```
+--dot-hardcopy
```

----
### Screen and Tmux

```
+--dot-screenrc
+--dot-tmux.conf
```

----
### Shell: Basic setup

```
+--dot-profile
+--dot-shrc
```

----
### Shell: Bash

```
+--dot-bashalias
+--dot-bashrc
+--dot-bash_dircolors
+--dot-bash_login
+--dot-bash_logout
+--dot-bash_profile
```

----
### Shell: Korn shell

```
+--dot-kshrc
```

----
### Shell: TCSH

```
+--dot-cshrc
+--dot-tcshrc
+--dot-login
+--dot-logout
```

----
### Shell: Zsh

```
+--dot-zcompdump
+--dot-zlogin
+--dot-zshrc
+--dot-zsh
|   +--aliases.zsh
|   +--bindkeys.zsh
|   +--cache
|   |   +--compdump
|   |   +--perl_modules
|   |   +--python_modules
|   |   +--RPMs
|   +--colors.zsh
|   +--completion.zsh
|   +--exports.zsh
|   +--functions.zsh
|   +--hg-completion
|   +--history.zsh
|   +--hooks.zsh
|   +--init.zsh
|   +--prompt.zsh
|   +--setopt.zsh
```

----
### SSH

```
+--dot-ssh
|   +--newkey
```

----
### Template Toolkit

```
+--dot-tpagerc
+--dot-ttreerc
+--dot-config
|   +--ttree
|   |   +--sunpage
```

----
### Terminal setup

```
+--dot-termrc.gnome-term
+--dot-termrc.xterm
```

----
### VCS: Git

```
+--dot-gitattributes
+--dot-gitconfig
+--dot-gitignore
```

----
### VCS: Mercurial

```
+--dot-hg
|   +--multiline
|   +--style
+--dot-hgignore
+--dot-hgrc
```

----
### VIM

```
+--dot-vim
|   +--colors
|   |   +--bernhard.vim
|   |   +--molokai.vim
|   |   +--muratori.vim
|   |   +--murphy.vim
|   |   +--nofrils-acme.vim
|   |   +--nofrils-blue.vim
|   |   +--nofrils-dark.vim
|   |   +--nofrils-green.vim
|   |   +--nofrils-light.vim
|   |   +--nofrils-sepia.vim
|   |   +--shirotelin.vim
|   |   +--vadelma.vim
|   |   +--wikipedia.vim
|   +--colorsample.vim
|   +--dynamic
|   |   +--css
|   |   +--htm
|   |   +--md
|   |   +--pl
|   |   +--sh
|   |   +--txt
|   +--filetype.vim
|   +--ftplugin
|   |   +--c.vim
|   |   +--perl.vim
|   |   +--txt.vim
|   +--newvim
|   +--plugin
|   |   +--justify.vim
|   |   +--obviousmode.vim
|   |   +--setcolors.vim
|   |   +--templates.vim
|   +--syntax
|   |   +--crontab.vim
|   |   +--perl.vim
|   |   +--sh.vim
|   |   +--syncolor.vim
|   |   +--syntax.vim
|   |   +--txt2tags.vim
|   +--undodir
|   +--view
|   +--xterm256-colors.vim
+--dot-vimrc
+--dot-vimrc-green
+--dot-vimrc-mutt
+--dot-vimrc-prod
+--dot-vimrc-share
+--dot-vimrc-simple
```

----
### Web: Creating pages

```
+--dot-txt2html.dict
+--dot-txt2htmlrc
+--dot-txt2tagsrc
```

----
### Web: Curl

```
+--dot-curlrc
```

----
### Web: Firefox

```
+--dot-mozilla
|   +--userChrome.css
```

----
### Web: Lynx

```
+--dot-lynx.lss
+--dot-lynxcfg
```

----
### Web: Tidying up pages

```
+--dot-tidyrc
+--dot-tidyxmlrc
```

----
### Web: Wget

```
+--dot-wgetrc
```

----
### Web: W3M

```
+--dot-w3m
|   +--config
```

----
### X-Windows: setup

```
+--dot-Xdefaults
+--dot-Xdefaults.test
+--dot-Xdefaults.urxvt
+--dot-Xdefaults.xalarm
+--dot-xinitrc
+--dot-xinitrc-fluxbox
+--dot-xinitrc-fvwm2
+--dot-xinitrc-kde
+--dot-xinitrc-metacity
+--dot-xmodmap
+--dot-xmodmap.swapcaps
```

----
### X-Windows: Fluxbox

```
+--dot-fluxbox
|   +--apps
|   +--init
|   +--keys
|   +--lastwallpaper
|   +--log
|   +--menu
|   +--overlay
|   +--startup
|   +--styles
|   |   +--LemonSpace
|   |   +--Meta
|   +--windowmenu
```

----
### X-Windows: FVWM

```
+--dot-fvwm
|   +--config
|   +--fvwm_icons
|   |   +--arrdown2.xpm
|   |   +--arrows2.xpm
|   |   +--arrup2.xpm
|   |   ...
|   |   +--xterm.xpm
|   |   +--xv.xpm
|   |   +--xv2.xpm
|   |   +--xview.xpm
|   +--SETUP
```

That's all, folks.
