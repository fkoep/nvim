set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

Plugin 'nerdtree'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-fugitive'
Plugin 'supertab'
" Plugin 'syntastic'
" Plugin 'dbakker/vim-projectroot'
" Plugin 'dhruvasagar/vim-table-mode'

Plugin 'mattn/emmet-vim'
Plugin 'rust-lang/rust.vim'
Plugin 'racer-rust/vim-racer'
Plugin 'cespare/vim-toml'
Plugin 'Sass'

Plugin 'flazz/vim-colorschemes'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" +++ VIM +++
set hidden "allow hidden buffers (buffers with unsaved changes not being displayed)
set autoread "autoreload files
set mouse=a "enable mouse

" colors
syntax on
set termguicolors
colorscheme ChocolateLiquor
" colorscheme ChocolatePapaya

set tabstop=4 softtabstop=0 expandtab shiftwidth=4 smarttab
set textwidth=82

set number "enable line numbers
set relativenumber "use relative line numbers"
set ruler "show current column/line number at the bottom
set nohlsearch "don't highlight search results
set nostartofline "don't change current column when jumping lines
set showcmd "show input of incomplete command

set autochdir  

imap jj <Esc> 
inoremap <c-space> <c-x><c-o>

" disable arrow keys for training
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>

if has('nvim')
	tnoremap <Esc> <C-\><C-n>
	tnoremap <C-w>h <C-\><C-n><C-w>h
	tnoremap <C-w>j <C-\><C-n><C-w>j
	tnoremap <C-w>k <C-\><C-n><C-w>k
	tnoremap <C-w>l <C-\><C-n><C-w>l
"	tnoremap <C-w><Left> <C-\><C-n><C-w>h
"	tnoremap <C-w><Down> <C-\><C-n><C-w>j
"	tnoremap <C-w><Up> <C-\><C-n><C-w>k
"	tnoremap <C-w><Right> <C-\><C-n><C-w>l
endif

" +++ projectroot +++
let g:rootmarkers = ['.git', '.hg', '.svn', 'Cargo.toml', 'shard.yml', 'Makefile', 'premake5.lua', 'premake4.lua']

function! <SID>AutoProjectRootCD()
try
  if &ft != 'help'
    ProjectRootCD
  endif
catch
  " Silently ignore invalid buffers
endtry
endfunction

" autocmd BufEnter * call <SID>AutoProjectRootCD()
au FileType go let $GOPATH = projectroot#get()

" +++ racer +++
let g:racer_cmd = "~/.cargo/bin/racer"
let g:racer_experimental_completer = 1
au FileType rust nmap gd <Plug>(rust-def)
au FileType rust nmap gs <Plug>(rust-def-split)
au FileType rust nmap gv <Plug>(rust-def-vertical)
au FileType rust nmap <leader>gd <Plug>(rust-doc)

" +++ supertab +++
let g:SuperTabDefaultCompletionType = "<C-X><C-O>"

" +++ NERDTree +++
map <F8> :NERDTreeToggle<CR>

" +++ syntastic +++
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_loc_list_height = 5

autocmd BufHidden * lclose "TODO what is this? something about location list

" FIXME remove https://github.com/rust-lang/rust.vim/issues/130
let g:syntastic_rust_rustc_exe = 'cargo check'
let g:syntastic_rust_rustc_fname = ''
let g:syntastic_rust_rustc_args = '--'
let g:syntastic_rust_checkers = ['rustc']

let g:syntastic_cpp_compiler = 'gcc++'
let g:syntastic_cpp_compiler_options = ' -std=c++17 '

" +++ statusline +++
let g:syntastic_stl_format = "E%e W%w"
set statusline=
set statusline+=\ %n\ %*            "buffer number
set statusline+=%{&ff}%*            "file format
set statusline+=%y%*                "file type
set statusline+=\ %<%F%*            "full path
set statusline+=%h%m%r%w            "flags
set statusline+=%=                  "align right
" set statusline+=%{SyntasticStatuslineFlag()}%*
set statusline+=%5l%*               "current line
set statusline+=/%L%*               "total lines
set statusline+=%4v\ %*             "virtual column number
set statusline+=0x%04B\ %*          "character under cursor

" +++ make +++
autocmd FileType make setlocal tabstop=8 noexpandtab shiftwidth=8

" +++ sass +++
autocmd FileType scss setlocal shiftwidth=2
autocmd FileType sass setlocal shiftwidth=2
