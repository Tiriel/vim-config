" Has to be first
set nocompatible

" --- Bundles ---
filetype off

set runtimepath^=~/.vim/bundle/bbye
set rtp+=~/.fzf
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()

" --- PluginManager ---
Plugin 'VundleVim/Vundle.vim'

" --- UI Plugins ---
Plugin 'vim-airline/vim-airline'
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'Shougo/neocomplete.vim'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-easytags'
Plugin 'majutsushi/tagbar'
Plugin 'airblade/vim-gitgutter'
Plugin 'bkad/CamelCaseMotion'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-eunuch'
Plugin 'moll/vim-bbye'

" --- ColorSchemes ---
Plugin 'vim-airline/vim-airline-themes'
Plugin 'altercation/vim-colors-solarized'
Plugin 'ErichDonGubler/vim-sublime-monokai'
Plugin 'dikiaap/minimalist'
Plugin 'tomasr/molokai'

" --- Syntax Plugins ---
Plugin 'stephpy/vim-yaml'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'cakebaker/scss-syntax.vim'

" --- Code Assist Plugins ---
Plugin 'shawncplus/phpcomplete.vim'
Plugin 'arnaud-lb/vim-php-namespace'
Plugin 'tpope/vim-surround'
Plugin 'beyondwords/vim-twig'
Plugin 'Raimondi/delimitMate'
Plugin 'HTML-AutoCloseTag'
Plugin '2072/PHP-Indenting-for-VIm'

" --- Code Quality Plugins ---
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'stephpy/vim-php-cs-fixer'
Plugin 'FooSoft/vim-argwrap'
Plugin 'junegunn/vim-easy-align'
Plugin 'w0rp/ale'
Plugin 'maksimr/vim-jsbeautify'

" --- Support Plugins ---
Plugin 'ekalinin/Dockerfile.vim'
Plugin 'phpactor/phpactor'

call vundle#end()

filetype plugin indent on
set tabstop=4 shiftwidth=4 expandtab

" --- General settings ---
" save undo history to a file
set undofile
set undodir=~/.vim/undo

" remove trailing spaces
autocmd FileType less,sass,yml,css,html,php,twig,xml,yaml,sh autocmd BufWritePre <buffer> :call setline(1, map(getline(1,'$'), 'substitute(v:val,"\\s\\+$","","")'))
autocmd BufRead,BufNewFile /etc/nginx/* setf nginx
autocmd BufNewFile,BufReadPost *.md set filetype=markdown
autocmd BufNewFile,BufReadPost .php_cs set filetype=php

set backspace=indent,eol,start
set ruler
set number
set showcmd
set incsearch
set hlsearch

syntax enable

set t_Co=256

set mouse=a

set background=dark

hi clear SignColumn

colorscheme minimalist

set laststatus=2

" --- Molokai color settings ---
let g:molokai_original = 1
let g:rehash256 = 1

" --- Airline status bar ---
let g:airline_detect_paste=1
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='molokai'
let g:airline#extensions#hunks#non_zero_only = 1

" --- Neocomplete ---
let g:neocomplete#enable_at_startup = 1

" --- NERDTree ---
let g:nerdtree_tabs_open_on_console_startup = 1

" --- EasyTags ---
let g:easytags_events = ['BufReadPost', 'BufWritePost']
let g:easytags_async = 1
let g:easytags_dynamic_files = 2
let g:easytags_resolve_links = 1
let g:easytags_suppress_ctags_warnings = 1

" --- Maps & remaps ---
"remap the leader to something easier to type
let mapleader = "¤"

nmap <silent> <leader>t :NERDTreeTabsToggle<CR>
nmap <silent> <leader>b :TagbarToggle<CR>

noremap <C-F> :FZF<CR>
noremap <C-w> :Bdelete<CR>
" remap splits navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Include use statement
nmap <Leader>u :call phpactor#UseAdd()<CR>
" Invoke the context menu
nmap <Leader>mm :call phpactor#ContextMenu()<CR>
" Goto definition of class or class member under the cursor
nmap <Leader>o :call phpactor#GotoDefinition()<CR>
" Transform the classes in the current file
nmap <Leader>tt :call phpactor#Transform()<CR>
" Generate a new class (replacing the current file)
nmap <Leader>cc :call phpactor#ClassNew()<CR>
" Extract method from selection
vmap <silent><Leader>em :<C-U>call phpactor#ExtractMethod()<CR>

" --- Functions and augroups ---
let delimitMate_expand_cr = 1
augroup mydelimitMate
		au!
		au FileType markdown let b:delimitMate_nesting_quotes = ["`"]
		au FileType tex let b:delimitMate_quotes = ""
		au FileType tex let b:delimitMate_matchpairs = "(:),[:],{:},`:'"
		au FileType tex let b:delimitMate_nesting_quotes = ['"', "'"]
augroup END

autocmd BufWritePost *.php silent! call PhpCsFixerFixFile()


