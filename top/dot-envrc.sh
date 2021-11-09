# $Revision: 1.31+2 $ $Date: 2021-10-31 19:30:28-04 $
# $Source: /home/vogelke/RCS/.envrc,v $
# $Host: furbag.bezoar.org $
# $UUID: 3a0775fa-a277-3c89-a92c-45624bf78723 $
#
# Set up shell environment variables.
# Use "buildenv" to translate this into appropriate form for sh or csh.

# Locale stuff: preferred is LANG 'C' and LC_ALL 'C'
# Default=en_US.UTF-8, which makes ls sort files case-insensitive.
# Setting LC_ALL can make grep faster.
# Sun, 31 Oct 2021 19:00:43 -0400
#   Changed to en_US for mkdocs, but changed it back because it
#   messed up too many other things.

LANG=C; export LANG
LC_ALL=C; export LC_ALL

# Default for configuration file.
XDG_CONFIG_HOME=$HOME/.config; export XDG_CONFIG_HOME

# Go programming environment
GOPATH=$HOME/go; export GOPATH

# Nice default font for xterm.  See "xt" script.
FONT='xft:Cascadia:pixelsize=20:bold'; export FONT

# Zettelkasten files live here.
ZETTELPATH="$HOME/.zettelkasten"; export ZETTELPATH

# Searchpath is handled in .path file.  info path:
INFOPATH='/usr/local/share/info:/usr/share/info'; export INFOPATH

# Generating GNU configure scripts.
ACLOCAL_PATH=/usr/local/share/aclocal-1.15:/usr/local/share/aclocal:/usr/share/aclocal-1.11:/usr/share/aclocal; export ACLOCAL_PATH

# Webpage document root
DOCROOT="/doc/html/htdocs"; export DOCROOT

# Good page-width for HTML directory listings.
PAGEWIDTH=90; export PAGEWIDTH

# Local time for RCS date information
# Use separate options; -zM shows up as an error in the zone time.
# Allow -M to make checkout file modtime same as checked-in file.
RCSINIT="-zLT -M"; export RCSINIT

# Wiki source and destination
WIKISRC="$HOME/wikisrc"; export WIKISRC
WIKIDST="$DOCROOT/wiki"; export WIKIDST

# For Message-ID generation
IDHOST="aflcmc.wloc"; export IDHOST

# Mozilla/Firefox history
#MOZILLA_HISTORY "$HOME/.mozilla/firefox/y1aht4ad.default/places.sqlite"
MOZILLA_HISTORY="$HOME/.mozilla/firefox/y5s39rxd.default/places.sqlite"; export MOZILLA_HISTORY

# When using an xterm or console.
# tip found in Zsh mailing list.
BAUD=0; export BAUD

# Where local package config stuff goes.
PKG_CONFIG_PATH=/usr/local/lib/pkgconfig; export PKG_CONFIG_PATH

# Formatting with local macro packages
GROFF_TMAC_PATH=/usr/local/share/tmac; export GROFF_TMAC_PATH

# Perl module testing
PERL5LIB="$HOME/lib/perl5"; export PERL5LIB

# Python
#PYTHONHOME /usr/local

# Mail delivery using qmail.
QMAILHOST=yourhost.com; export QMAILHOST
QMAILUSER=you; export QMAILUSER
QMAILNAME="Your Name"; export QMAILNAME
RSYNC_RSH=/usr/local/bin/ssh; export RSYNC_RSH
QMAILINJECT=f; export QMAILINJECT
REPLYTO=you@yourhost.com; export REPLYTO

# Default file browser and editors.
# Other than a safe basic setting, "less" is handled elsewhere.
#PAGER "most"
#PAGER "vless"  # if less is broken
PAGER="less"; export PAGER
LESS="-XCden -j.3 -z-2"; export LESS
EDITOR="vim"; export EDITOR
CEDITOR="vi"; export CEDITOR

# Tab size for mfmt
TABWIDTH="4"; export TABWIDTH

# Default fmt width
FMTWIDTH=78; export FMTWIDTH

# MOST: %s and %d formatting descriptors represent
# the file name and line number, respectively.
MOST_SWITCHES="-v"; export MOST_SWITCHES
MOST_EDITOR='vim +%d %s'; export MOST_EDITOR
MOST_HELP='/usr/local/etc/most.hlp'; export MOST_HELP

# df output
BLOCKSIZE="1m"; export BLOCKSIZE
#BLOCK_SIZE 1048576    # messes up GNU version of ls.
DIFMT="mbuv2iUFP"; export DIFMT

# Site log.
SLSITE="amd118"; export SLSITE

# Lynx browser.
LYNX_CFG=$HOME/.lynxcfg; export LYNX_CFG

# Mailbox.
MAIL="/var/mail/vogelke"; export MAIL

# Printer.
PRINTER=118b; export PRINTER

# X-windows
DOMAIN="`domainname`"; export DOMAIN
HOST="`uname -n`"; export HOST
DISPLAY=":0.0"; export DISPLAY

# Used in "shell" mode under Emacs.
ESHELL="/bin/sh"; export ESHELL
TMPDIR="/tmp"; export TMPDIR
# Your shell should really set this for you.
#SHELL "/bin/zsh"     

# Used by HTML tidy.
HTML_TIDY="$HOME/.tidyrc"; export HTML_TIDY

# Used by maint and hm program
MAINTOPTS="-f"; export MAINTOPTS
MAINTPAGER="yes"; export MAINTPAGER
HMOPT="bdgpsu"; export HMOPT

# Used by top to display over the whole screen.
TOP="all"; export TOP

# Used by "look" to pick your dictionary.
LOOKDICT="/usr/local/share/dict/single.txt"; export LOOKDICT

# Used by "new"
NEWEDITOR="vi"; export NEWEDITOR
FULLNAME="$QMAILNAME"; export FULLNAME
COMPANY="Indigenous Technologies Inc."; export COMPANY
ORGANIZATION="AFLCMC/WLOC"; export ORGANIZATION

# Need this to make waissearch work.
USER="$LOGNAME"; export USER

# Frequently-used directories.
b="$DOCROOT/blog/posts"; export b
h="$DOCROOT"; export h
l="/usr/local/lib"; export l

# Postgres
# PGDATA /other/pgsql/data
# PGLIB /usr/local/lib
PGDATABASE=files; export PGDATABASE

# GNATS
GNATS_ROOT=/src/gnu/gnats/gnats-db; export GNATS_ROOT
PREDITOR=remark; export PREDITOR

# For use by splitmail
SENDMAIL=/var/qmail/bin/sendmail; export SENDMAIL
SPLITSIZE=50000; export SPLITSIZE

# library path: don't need if you run crle
## LD_LIBRARY_PATH "/usr/X11R6/lib:/usr/lib:/usr/local/lib:/usr/sfw/lib:/opt/sfw/lib"

# DocBook
DB=/usr/share/sgml/docbook/docbook-xsl-1.64.1; export DB
XML_CATALOG_FILES=/usr/share/sgml/docbook/xml-dtd-4.1.2/catalog; export XML_CATALOG_FILES
SGML_CATALOG_FILES=/usr/share/sgml/docbook/xml-dtd-4.1.2/catalog; export SGML_CATALOG_FILES
