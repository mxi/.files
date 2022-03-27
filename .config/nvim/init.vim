filetype on
filetype plugin on

packloadall


" +--- general settings ---------------------------------------+
set nu rnu
set splitright splitbelow

" generally acceptable tab settings, can be changed later.
set autoindent
set tabstop=8
set softtabstop=8
set shiftwidth=8
set noexpandtab
set nowrap

set scrolloff=4
set cursorline

set listchars=tab:→\ ,eol:↲


" +--- bindings -----------------------------------------------+
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


" +--- theming ------------------------------------------------+
set termguicolors
set background=dark
colorscheme sunbather 

if 8 <= strftime("%H") && strftime("%H") <= 16
	set background=light
endif


" +--- autocmd ------------------------------------------------+
function SetupForMarkdownLike()
endfunction

function SetupForLaTeX()
	set tabstop=4
	set softtabstop=4
	set shiftwidth=4
	set wrap
	nnoremap <buffer> <leader><enter> :w<CR>:!pdflatex "%"<CR>
endfunction

function SetupForCLike()
	set tabstop=4
	set softtabstop=4
	set shiftwidth=4
	set noexpandtab
	set nowrap
	set path=.,/usr/include/,/usr/include/opencv4,/usr/local/include
	let c_no_bracket_error = 1
	let c_no_curly_error = 1
	inoremap <buffer> /* /*<space><space>*/<esc>hhi
	inoremap <buffer> {} {<enter>}<esc>O
	nnoremap <buffer> <Leader>m :make<CR><Enter>:cnext<CR>:cprev<CR>
	nnoremap <buffer> <Leader>M :!make<CR>
	" make more intelligent functions for
	" these:
	" inoremap <buffer> "  ""<esc>i
	" inoremap <buffer> '  ''<esc>i
endfunction

function SetupForAssemblyLike()
	set nowrap
endfunction

augroup setup
	autocmd!
	" markup languages
	autocmd FileType markdown   :call SetupForMarkdownLike()
	autocmd FileType tex        :call SetupForLaTeX()
	" c family
	autocmd FileType c          :call SetupForCLike()
	autocmd FileType cpp        :call SetupForCLike()
	autocmd FileType glsl*      :call SetupForCLike()
	" asm family
	autocmd FileType asm        :call SetupForAssemblyLike()
augroup END

augroup general
	autocmd!
augroup END


" +--- file browser -------------------------------------------+
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 0
