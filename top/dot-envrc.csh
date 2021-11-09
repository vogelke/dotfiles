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

setenv LANG   C
setenv LC_ALL C

# Default for configuration file.
setenv XDG_CONFIG_HOME $HOME/.config

# Go programming environment
setenv GOPATH $HOME/go

# Nice default font for xterm.  See "xt" script.
setenv FONT 'xft:Cascadia:pixelsize=20:bold'

# Zettelkasten files live here.
setenv ZETTELPATH "$HOME/.zettelkasten"

# Searchpath is handled in .path file.  info path:
setenv INFOPATH '/usr/local/share/info:/usr/share/info'

# Generating GNU configure scripts.
setenv ACLOCAL_PATH /usr/local/share/aclocal-1.15:/usr/local/share/aclocal:/usr/share/aclocal-1.11:/usr/share/aclocal

# Webpage document root
setenv DOCROOT "/doc/html/htdocs"

# Good page-width for HTML directory listings.
setenv PAGEWIDTH 90

# Local time for RCS date information
# Use separate options; -zM shows up as an error in the zone time.
# Allow -M to make checkout file modtime same as checked-in file.
setenv RCSINIT "-zLT -M"

# Wiki source and destination
setenv WIKISRC "$HOME/wikisrc"
setenv WIKIDST "$DOCROOT/wiki"

# For Message-ID generation
setenv IDHOST "aflcmc.wloc"

# Mozilla/Firefox history
#MOZILLA_HISTORY "$HOME/.mozilla/firefox/y1aht4ad.default/places.sqlite"
setenv MOZILLA_HISTORY "$HOME/.mozilla/firefox/y5s39rxd.default/places.sqlite"

# When using an xterm or console.
# tip found in Zsh mailing list.
setenv BAUD 0

# Where local package config stuff goes.
setenv PKG_CONFIG_PATH /usr/local/lib/pkgconfig

# Formatting with local macro packages
setenv GROFF_TMAC_PATH /usr/local/share/tmac

# Perl module testing
setenv PERL5LIB "$HOME/lib/perl5"

# Python
#PYTHONHOME /usr/local

# Mail delivery using qmail.
setenv QMAILHOST yourhost.com
setenv QMAILUSER you
setenv QMAILNAME "Your Name"
setenv RSYNC_RSH /usr/local/bin/ssh
setenv QMAILINJECT f
setenv REPLYTO you@yourhost.com

# Default file browser and editors.
# Other than a safe basic setting, "less" is handled elsewhere.
#PAGER "most"
#PAGER "vless"  # if less is broken
setenv PAGER "less"
setenv LESS "-XCden -j.3 -z-2"
setenv EDITOR "vim"
setenv CEDITOR "vi"

# Tab size for mfmt
setenv TABWIDTH "4"

# Default fmt width
setenv FMTWIDTH 78

# MOST: %s and %d formatting descriptors represent
# the file name and line number, respectively.
setenv MOST_SWITCHES "-v"
setenv MOST_EDITOR 'vim +%d %s'
setenv MOST_HELP '/usr/local/etc/most.hlp'

# df output
setenv BLOCKSIZE "1m"
#BLOCK_SIZE 1048576    # messes up GNU version of ls.
setenv DIFMT "mbuv2iUFP"

# Site log.
setenv SLSITE "amd118"

# Lynx browser.
setenv LYNX_CFG $HOME/.lynxcfg

# Mailbox.
setenv MAIL "/var/mail/vogelke"

# Printer.
setenv PRINTER 118b

# X-windows
setenv DOMAIN "`domainname`"
setenv HOST "`uname -n`"
setenv DISPLAY ":0.0"

# Used in "shell" mode under Emacs.
setenv ESHELL "/bin/sh"
setenv TMPDIR "/tmp"
# Your shell should really set this for you.
#SHELL "/bin/zsh"     

# Used by HTML tidy.
setenv HTML_TIDY "$HOME/.tidyrc"

# Used by maint and hm program
setenv MAINTOPTS "-f"
setenv MAINTPAGER "yes"
setenv HMOPT "bdgpsu"

# Used by top to display over the whole screen.
setenv TOP "all"

# Used by "look" to pick your dictionary.
setenv LOOKDICT "/usr/local/share/dict/single.txt"

# Used by "new"
setenv NEWEDITOR "vi"
setenv FULLNAME "$QMAILNAME"
setenv COMPANY "Indigenous Technologies Inc."
setenv ORGANIZATION "AFLCMC/WLOC"

# Need this to make waissearch work.
setenv USER "$LOGNAME"

# Frequently-used directories.
setenv b "$DOCROOT/blog/posts"
setenv h "$DOCROOT"
setenv l "/usr/local/lib"

# Postgres
# PGDATA /other/pgsql/data
# PGLIB /usr/local/lib
setenv PGDATABASE files

# GNATS
setenv GNATS_ROOT /src/gnu/gnats/gnats-db
setenv PREDITOR remark

# For use by splitmail
setenv SENDMAIL /var/qmail/bin/sendmail
setenv SPLITSIZE 50000

# library path: don't need if you run crle
## LD_LIBRARY_PATH "/usr/X11R6/lib:/usr/lib:/usr/local/lib:/usr/sfw/lib:/opt/sfw/lib"

# DocBook
setenv DB /usr/share/sgml/docbook/docbook-xsl-1.64.1
setenv XML_CATALOG_FILES /usr/share/sgml/docbook/xml-dtd-4.1.2/catalog
setenv SGML_CATALOG_FILES /usr/share/sgml/docbook/xml-dtd-4.1.2/catalog
