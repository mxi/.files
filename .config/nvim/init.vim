filetype on
filetype plugin on
packloadall

" General {{{
set nu rnu
set splitright splitbelow
set modeline

set autoindent
set tabstop=8
set softtabstop=8
set shiftwidth=8
set noexpandtab
set nowrap

set scrolloff=4
set cursorline

set listchars=tab:→\ ,eol:↲
" }}}
" Theme {{{
set termguicolors
set background=dark
let s:hour = strftime("%H")

if 6 <= s:hour && s:hour <= 19
	set background=light
endif

colorscheme mvk
" }}}
" Bindings {{{
let mapleader=' '
let maplocalleader='\'

noremap <Up>      <Nop>
noremap <Left>    <Nop>
noremap <Down>    <Nop>
noremap <Right>   <Nop>

" line up/down
nnoremap - :m -2<CR>
nnoremap _ :m +1<CR>

" quick [e]dit various files
nnoremap <Leader>ev :vs $MYVIMRC<CR>
nnoremap <Leader>ep :vs $HOME/.config/zsh/.zprofile<CR>
nnoremap <Leader>ez :vs $HOME/.config/zsh/.zshrc<CR>

" quick window/buffer changes
nnoremap <Leader>[ :bp<CR>
nnoremap <Leader>] :bn<CR>
nnoremap <Leader>. :cnext<CR>
nnoremap <Leader>, :cprev<CR>

nnoremap <Leader>wh <C-W>h
nnoremap <Leader>wj <C-W>j
nnoremap <Leader>wk <C-W>k
nnoremap <Leader>wl <C-W>l

nnoremap <Leader>wH <C-W>H
nnoremap <Leader>wJ <C-W>J
nnoremap <Leader>wK <C-W>K
nnoremap <Leader>wL <C-W>L

" misc
nnoremap <Leader>H :set hls!<CR>
nnoremap <Leader>W :wa<CR>
nnoremap <Leader>U viwU<esc>
nnoremap <Leader>u viwu<esc>
nnoremap <Leader>R :source $HOME/.config/nvim/init.vim<CR>
nnoremap <Leader>N :Ntree<CR>

nnoremap <Leader>s :w<CR>
" }}}
" Autocmd {{{
function s:setup_markdown()
endfunction

function s:setup_tex()
	set tabstop=4
	set softtabstop=4
	set shiftwidth=4
	set wrap
	nnoremap <buffer> <leader><enter> :w<CR>:!pdflatex "%"<CR>
endfunction

function s:setup_c()
	set cino=(0,l1,:0
	set tabstop=4
	set softtabstop=4
	set shiftwidth=4
	set noexpandtab
	set nowrap
	set path=
		\".",
		\"/usr/include/",
		\"/usr/include/opencv4",
		\"/usr/local/include"
	let c_no_bracket_error = 1
	let c_no_curly_error = 1
	inoremap <buffer> {} {<enter>}<esc>O
	nnoremap <buffer> <Leader>m :make<CR><Enter>:cnext<CR>:cprev<CR>
	nnoremap <buffer> <Leader>M :!make<CR>
	" make more intelligent functions for
	" these:
	" inoremap <buffer> "  ""<esc>i
	" inoremap <buffer> '  ''<esc>i
endfunction

function s:setup_asm()
	set nowrap
endfunction

augroup setup
	autocmd!
	autocmd FileType markdown   :call s:setup_markdown()
	autocmd FileType tex        :call s:setup_tex()
	autocmd FileType c          :call s:setup_c()
	autocmd FileType cpp        :call s:setup_c()
	autocmd FileType glsl*      :call s:setup_c()
	" asm family
	autocmd FileType asm        :call s:setup_asm()
augroup END

augroup general
	autocmd!
augroup END
" }}}
" Netrw {{{
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 0
" }}}

" vim: sw=8 ts=8 sts=8 noet fdm=marker
