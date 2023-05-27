" General {{{
filetype on
filetype plugin on
packloadall

" HACK: not sure why lua plugins aren't loaded automatically,
"       I'll have to look into this.
" source /usr/share/nvim/runtime/plugin/man.lua

set nu rnu
set splitright splitbelow
set modeline
set nofoldenable
set foldmethod=marker
set ignorecase
set smartcase
set autoindent
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set nowrap
set cursorline
set scrolloff=4
set listchars=tab:→\ ,eol:↲
set nrformats=bin,hex,alpha
set diffopt="vertical"

set termguicolors
set background=dark
colorscheme decoldest

let shell = 'zsh'
let man_hardwrap = 1
let ft_man_open_mode = 'vert'

let netrw_banner = 0
let netrw_liststyle = 3
let netrw_browse_split = 0

if exists("g:neovide")
  set guifont=JetBrains\ Mono\ NL:h11
  let g:neovide_cursor_animation_length = 0.05
endif
" }}} 

" Math {{{
let M_E  = 2.718281828459045
let M_PI = 3.141592653589793

function! Mod(a, b)
  let tmp = a:a % a:b
  return tmp < 0 ? a:b + tmp : tmp
endfunction

function! Rad(degrees)
  return a:degrees * g:M_PI / 180.0
endfunction

function! Deg(radians)
  return a:radians * 180.0 / g:M_PI
endfunction

function! Log2(param)
  return log(a:param) / log(2)
endfunction

function! KiB(n) 
  return       a:n  * 1024 
endfunction

function! MiB(n) 
  return g:KiB(a:n) * 1024 
endfunction

function! GiB(n) 
  return g:MiB(a:n) * 1024 
endfunction

function! TiB(n) 
  return g:GiB(a:n) * 1024 
endfunction
" }}} Math

" Functions {{{
function! SyntaxStack()
  if !exists("*synstack") | return | endif
  echo map(synstack(line("."), col(".")), "synIDattr(v:val, 'name')")
endfunction

function! EchoLine(msg)
  echon printf("\<cr>%*s", v:echospace, "")
  echon printf("\<cr>%s", a:msg)
endfunction

function! PairOf(symbol)
  if !exists("SymbolPairTable")
    " forward table
    let g:SymbolPairTable = {
    \ '(': ['(', ')'],
    \ '[': ['[', ']'],
    \ '{': ['{', '}'],
    \ '<': ['<', '>'],
    \ }
    " make it backward
    for [k, v] in items(g:SymbolPairTable)
      let g:SymbolPairTable[v[1]] = v
    endfor
  endif
  if exists(printf("g:SymbolPairTable['%s']", a:symbol))
    return g:SymbolPairTable[a:symbol]
  endif
  return [a:symbol, a:symbol]
endfunction

function! SelectionOf(mode)
  let [rs, re] = a:mode == "char" ? ["'[", "']"] : ["'<", "'>"]
  let [sl, sc] = getcharpos(rs)[1:2]
  let [el, ec] = getcharpos(re)[1:2]
  return [sl, sc, el, ec]
endfunction

" tiny version of surround.vim
function! Surround(mode)
  call EchoLine("surround with: ") | let x = getcharstr()
  if x == "\<esc>" || x == "\<c-c>"
    call EchoLine(":(") | return
  endif
  let [x, y] = PairOf(x)
  let [sl, sc, el, ec] = SelectionOf(a:mode)
  if a:mode == "V"           " line-wise
    call append(el, y)
    call append(sl-1, x)
  elseif a:mode == "\<c-v>"  " block-wise
    let [_, cl, cc, _, _] = getcurpos()
    echo cl cc
    " for l in range(sl, el)

    " endfor
    " silent execute sl..','..el..'s/$\|\%>'..ec..'c/\=y/ | norm! ``'
    " silent execute sl..','..el..'s/$\|\%'..sc..'c/\=x/ | norm! ``'
  else                       " character-wise
    silent! execute el..'s/$\|\%>'..ec..'c/\=y/ | norm! ``'
    silent! execute sl..'s/$\|\%'..sc..'c/\=x/ | norm! ``'
  endif
  " call EchoLine(":)")
endfunction

" inverse of OpSurround
function! Trim(mode)
  let x = getcharstr()
  if x =~ "\<esc>" || x =~ "\<c-c>"
    return
  endif
  let [ x, y ] = PairOf(x)
  let [ sl, se, el, ec] = SelectionOf(a:mode)
  if a:mode == "block" || a:mode == "\<c-v>"
    silent! execute sl..','..el..'s/\('..x..'\)\(.*\%.c[^\('..y..'\)]*\)\('..y..'\)/\2/ | norm! ``'
  else
  endif
endfunction

function! Dec2Hex(...)
  let result = []
  for item in a:000
    call add(result, printf("%x", item))
  endfor
  return join(result, ",")
endfunction

function! FileRemoveOneExtension(path)
  if len(a:path) && a:path[0] == '/'
    let path_prefix = '/'
  else
    let path_prefix = ''
  endif
  let file_elements = split(a:path, '/')
  call filter(file_elements, 'len(v:val)')
  let file_dotparts = split(l:file_elements[-1], '\.')
  if len(l:file_dotparts) == 1
    let l:file_elements[-1] = l:file_dotparts[0]
  else
    let l:file_elements[-1] = join(l:file_dotparts[0:-2], '.')
  endif
  return l:path_prefix .. join(l:file_elements[0:-1], '/')
endfunction
" }}} Functions

" Commands {{{
command! -nargs=1 VimCalc let answer = eval(<q-args>) |
                        \ let result = printf("%g", answer) |
                        \ call setreg("", result) |
                        \ echo result 
" }}} Commands

" Bindings {{{
let mapleader=' '
let maplocalleader='\'

" disable keys that get in the way
noremap <up>      <nop>
noremap <left>    <nop>
noremap <down>    <nop>
noremap <right>   <nop>
nnoremap H        <nop>
nnoremap M        <nop>
nnoremap L        <nop>
" write mechanics
nnoremap <leader>W :wa<cr>
nnoremap <leader>Q :wa<cr>:qa<cr>
nnoremap <leader>s :update<cr>
" line up/down
nnoremap - :move -2<cr>
nnoremap _ :move +1<cr>
" quick edit common files
nnoremap <leader>ev :vs $MYVIMRC<cr>
nnoremap <leader>ea :vs $XDG_CONFIG_HOME/alacritty/alacritty.yml<cr>
nnoremap <leader>ep :vs $XDG_CONFIG_HOME/zsh/.zprofile<cr>
nnoremap <leader>ez :vs $XDG_CONFIG_HOME/zsh/.zshrc<cr>
" text manipulation
nnoremap <leader>P m`viw<esc>g`<~g``
nnoremap <leader>U m`viwU<esc>g``
nnoremap <leader>u m`viwu<esc>g``
vnoremap <leader>== :'<,'>!column -t -s = -o =<cr>
" hijack `s` for additional operators/commands/etc.
noremap s <nop>
nnoremap ss :set opfunc=Surround<cr>g@
vnoremap ss :<c-u>call Surround(visualmode())<cr>
nnoremap st :set opfunc=Trim<cr>g@
vnoremap st :<c-u>call Trim(visualmode())<cr>
" buffer movement 
nnoremap <leader>[ :bp<cr>
nnoremap <leader>] :bn<cr>
nnoremap <leader>. :cnext<cr>
nnoremap <leader>, :cprev<cr>
" tab movement
for n in range(1, 9)
  execute printf("nnoremap <a-%d> :norm %dgt<cr>", n, n)
endfor
nnoremap <leader>t :tab split<cr>
nnoremap <leader><leader> :norm gt<cr>
" window movement
nnoremap <a-h> :wincmd h<cr>
nnoremap <a-j> :wincmd j<cr>
nnoremap <a-k> :wincmd k<cr>
nnoremap <a-l> :wincmd l<cr>
nnoremap <a-H> :wincmd H<cr>
nnoremap <a-J> :wincmd J<cr>
nnoremap <a-K> :wincmd K<cr>
nnoremap <a-L> :wincmd L<cr>
nnoremap <a-s-o> :resize -4<cr>
nnoremap <a-o> :vert resize -8<cr>
nnoremap <a-s-p> :resize +4<cr>
nnoremap <a-p> :vert resize +8<cr>
" terminal movement
tnoremap <a-h> <c-\><c-n><c-w>h
tnoremap <a-j> <c-\><c-n><c-w>j
tnoremap <a-k> <c-\><c-n><c-w>k
tnoremap <a-l> <c-\><c-n><c-w>l
tnoremap <a-x> <c-\><c-n>
nnoremap <leader>T :execute printf("vs term://%s", shell)<cr>i
" make ctags display confirm dialogue by default
nnoremap <c-]> g<c-]>
nnoremap g<c-]> <c-]>
" show syntax info under cursor
nnoremap <leader>`s :call SyntaxStack()<cr>
" toggle highlighting
nnoremap <leader>H :set hls!<cr>
" source init.vim
nnoremap <leader>R :source $HOME/.config/nvim/init.vim<cr>:edit<cr>
" enter calculator command.
nnoremap <leader>c :VimCalc<Space>
" }}}

" Autocmd (Setup) {{{
augroup Setup | autocmd!

function! s:SetupTsv()
  setlocal filetype=conf
  setlocal shiftwidth=32
  setlocal softtabstop=32
  setlocal tabstop=32
  setlocal noexpandtab
endfunction
autocmd BufRead,BufNewFile *.tsv call s:SetupTsv()

function! s:SetupReadme()
  setlocal cc=80
endfunction
autocmd BufRead,BufNewFile README* call s:SetupReadme()

function! s:SetupPlanfile()
  setlocal cc=72
  nnoremap <buffer> <leader>r /REMIND<cr>:set nohls<cr>j
  nnoremap <buffer> <leader>m :read !date +"\%Y-\%m-\%d (\%A, \%B \%d, \%Y)"<cr>
                             \<ESC>o<ESC>72i=<ESC>0
endfunction
autocmd BufRead,BufNewFile planfile call s:SetupPlanfile()

function! s:SetupTex()
  setlocal tabstop=2
  setlocal softtabstop=2
  setlocal shiftwidth=2
  setlocal expandtab
  setlocal linebreak
  if &filetype != "bib"
    setlocal spell
  endif
  setlocal wrap
  " swap modes for moving vertically along a wrapped line lines.
  nnoremap <buffer> k gk
  nnoremap <buffer> j gj
  nnoremap <buffer> 0 g0
  nnoremap <buffer> $ g$
  nnoremap <buffer> gk k
  nnoremap <buffer> gj j
  nnoremap <buffer> g0 0
  nnoremap <buffer> g$ $
  " build commands are different for plaintex and latex
  if &filetype == "plaintex"
    nnoremap <buffer> <leader>m :w<cr>:!pdftex "%"<cr>
  else
    nnoremap <buffer> <leader>m :w<cr>
                               \:!pdflatex '%'<cr>
    nnoremap <buffer> <leader>M :w<cr>
                               \:!pdflatex '%'<cr>
                               \:!biber '%:r'<cr>
                               \:!pdflatex '%'<cr>
  endif
endfunction
autocmd FileType *tex,*bib call s:SetupTex()

function! s:SetupAsm()
  setlocal nowrap
endfunction
autocmd FileType asm call s:SetupAsm()

function! s:SetupC()
  setlocal cc=80
  setlocal cino=(0,l1,:0
  setlocal tabstop=4
  setlocal softtabstop=4
  setlocal shiftwidth=4
  setlocal expandtab
  setlocal nowrap
  if &ft != "d"
    let &path = &path .. ".,"
    let &path = &path .. "/usr/include/,"
    let &path = &path .. "/usr/local/include,"
    let &path = &path .. "/usr/include/opencv4,"
    let &path = &path .. "/usr/include/cairo,"
    let &path = &path .. "/usr/include/lzo,"
    let &path = &path .. "/usr/include/libpng16,"
    let &path = &path .. "/usr/include/freetype2,"
    let &path = &path .. "/usr/include/harfbuzz,"
    let &path = &path .. "/usr/include/glib-2.0,"
    let &path = &path .. "/usr/include/sysprof-4,"
    let &path = &path .. "/usr/include/pixman-1,"
    let &path = &path .. "/usr/lib/glib-2.0/include,"
  endif
  let c_no_bracket_error = 1
  let c_no_curly_error = 1
  " stupid hack to make no_*_error above work in .c sources
  setlocal filetype=cpp
  setlocal syntax=c
  " expand brace block
  inoremap <buffer> {} {<enter>}<esc>O
  " quickly run make
  nnoremap <buffer> <leader>m :make<cr><Enter>:cnext<cr>:cprev<cr>
  " 'lookup' word under cursor using vimgrep in all .c, .h files.
  nnoremap <buffer> <leader>k viwy
    \ :execute('vimgrep /'..getreg('"')..'/ '..
    \ '**/*.h '..
    \ '**/*.c ')<cr>
endfunction
autocmd FileType c,d,cpp call s:SetupC()

function! s:SetupRust()
  " expand brace block
  inoremap <buffer> {} {<enter>}<esc>O
endfunction
autocmd FileType rust call s:SetupRust()

function! s:SetupPython()
  set cc=80
  iabbrev <buffer> shebang #!/usr/bin/env python3
endfunction
autocmd FileType python call s:SetupPython()

function! s:SetupXonsh()
  set filetype=python
endfunction
autocmd BufRead,BufNewFile *.xsh call s:SetupXonsh()

function! s:SetupTerminal()
  setlocal nospell
endfunction
autocmd TermOpen * call s:SetupTerminal() 

augroup end
" }}}

" vi: sw=2 ts=2 sts=2 et fdm=marker nospell
