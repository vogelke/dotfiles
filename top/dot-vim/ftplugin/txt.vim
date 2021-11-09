" Vim filetype plugin file
" Language:		Plain text
" Maintainer:	Lubomir Host 'rajo' <rajo AT platon.sk>
" License:		GNU GPL
" Version:		$Platon: vimconfig/vim/ftplugin/txt.vim,v 1.6+2 2005/06/16 13:30:21 rajo Exp $


" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

" Don't use modelines in e-mail messages, avoid trojan horses
setlocal nomodeline

" many people recommend keeping e-mail messages <80 chars wide
setlocal textwidth=76

" Set 'formatoptions' to break text lines and keep the comment leader ">".
setlocal formatoptions=crqt12
setlocal autoindent

" Replace <Tab> with 4 spaces: to set N-char indentation used when you
" hit the tab key in vim (what Emacs calls c-basic-offset):
set shiftwidth=4

" To cause the TAB file-character to be displayed as N characters
" in vim (what Emacs calls tab-width):
set tabstop=4

" To cause TAB characters to not be used in the file for compression,
" and for only spaces to be used (what Emacs calls indent-tabs-mode):
set expandtab


setlocal tabstop=4
setlocal shiftwidth=4
setlocal expandtab

" let b:input_method = "iso8859-2"
let b:input_method = &encoding

" Modeline {{{
" vim:set ts=4:
" vim600: fdm=marker fdl=0 fdc=3
" }}}
