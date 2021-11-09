" Vim global plugin for providing templates for new files
" http://plasmasturm.org/attic/templates.vim/templates.ar.vim
" This file: plugin/templates.vim
"
" Lets you use filetype-dependent templates for new files in Vim.
" Usage is simple: when you start with a fresh buffer, setting a
" filetype on it will load the corresponding template.  To test it,
" open Vim and issue
"   :set ft=html
"
" One new command has been added for convenience: it is called :New
" and takes exactly one argument.  It will open a new empty window
" and set the filetype for it to the argument given.
"
" Templates are kept in .vim/templates.  The template filename
" must be equal to the filetype.  So when you set the filetype
" of an empty buffer to html, .vim/templates/html will be loaded.
" Its that simple.
"
" In the templates, you can use a cursorline to specify a position
" for the cursor after loading the template.  Such a cursorline
" works much like a modeline: the word cursor: must appear, followed
" by one or two numbers and opionally the word del, all separated
" by whitespace.  The first number specifies the line the cursor
" will be placed in.  The second, if present, specifies a column.
" The optional word del directs the script to remove the cursorline
" at load time.  Take a look at the templates supplied in the
" package, it should be fairly self-explanatory.
"
" Maintainer:  Aristotle Pagaltzis <pagaltzis@gmx.de>
" Last Change: 2004-12-28
" License:     This script is free software; you can redistribute it and/or
"              modify it under the terms of either the Artistic License or
"              the GNU General Public License.

if exists( 'g:loaded_template' ) | finish | endif
let g:loaded_template = 1

augroup template
	autocmd!
	autocmd FileType * if line2byte( line( '$' ) + 1 ) == -1 | call s:loadtemplate( &filetype ) | endif
augroup END

function! s:globpathlist( path, ... )
	let i = 1
	let result = a:path
	while i <= a:0
		let result = substitute( escape( globpath( result, a:{i} ), ' ,\' ), "\n", ',', 'g' )
		if strlen( result ) == 0 | return '' | endif
		let i = i + 1
	endwhile
	return result
endfunction

function! s:loadtemplate( filetype )
	let templatefile = matchstr( s:globpathlist( &runtimepath, 'templates', a:filetype ), '\(\\.\|[^,]\)*', 0 )
	if strlen( templatefile ) == 0 | return | endif
	silent execute 1 'read' templatefile
	1 delete _
	if search( 'cursor:', 'W' )
		let cursorline = strpart( getline( '.' ), col( '.' ) - 1 )
		let y = matchstr( cursorline, '^cursor:\s*\zs\d\+\ze' )
		let x = matchstr( cursorline, '^cursor:\s*\d\+\s\+\zs\d\+\ze' )
		let d = matchstr( cursorline, '^cursor:\s*\d\+\s\+\(\d\+\s\+\)\?\zsdel\>\ze' )
		if ! strlen( x ) | let x = 0 | endif
		if ! strlen( y ) | let y = 0 | endif
		if d == 'del' | delete _ | endif
		call cursor( y, x )
	endif
	set nomodified
endfunction
"
command -nargs=1 New new | set ft=<args>
