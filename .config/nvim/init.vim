filetype on
filetype plugin on

packloadall


" +--- general settings ---------------------------------------+
set nu rnu
set splitright splitbelow

set autoindent
set tabstop=4
set softtabstop=4
set shiftwidth=4
set noexpandtab

set scrolloff=4

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
colorscheme gruvbox


" +--- autocmd ------------------------------------------------+
function SetupForMarkdownLike()
	
endfunction

function SetupForCLike()
	set nowrap
	set path=.,/usr/include/,/usr/local/include
	inoremap <buffer> {} {<enter>}<esc>O
	nnoremap <buffer> <Leader>m :make<CR>
	nnoremap <buffer> <Leader>M :!make<CR>
	" make more intelligent functions for
	" these:
	" inoremap <buffer> "  ""<esc>i
	" inoremap <buffer> '  ''<esc>i
endfunction

augroup setup
	autocmd!
	autocmd FileType markdown :call SetupForMarkdownLike()
	autocmd FileType c,cpp :call SetupForCLike()
	autocmd FileType glsl* :call SetupForCLike()
	" add more c-family languages as needed
augroup END

augroup general
	autocmd!
	autocmd BufWinEnter * :set cc=72
augroup END


" +--- file browser -------------------------------------------+
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 0
