" Has to be first
set nocompatible

" --- Vundle ---
filetype off

set runtimepath^=~/.vim/bundle/bbye
set rtp+=~/.fzf
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()


Plugin 'VundleVim/Vundle.vim'

Plugin 'altercation/vim-colors-solarized'
Plugin 'tomasr/molokai'
Plugin 'ErichDonGubler/vim-sublime-monokai'
Plugin 'dikiaap/minimalist'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-easytags'
Plugin 'majutsushi/tagbar'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-fugitive'

Plugin 'Raimondi/delimitMate'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'shawncplus/phpcomplete.vim'

" --- More ---
Plugin 'StanAngeloff/php.vim'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'godlygeek/tabular'
Plugin 'HTML-AutoCloseTag'
Plugin 'edkolev/tmuxline.vim'
Plugin 'ekalinin/Dockerfile.vim'
Plugin 'cakebaker/scss-syntax.vim'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'maksimr/vim-jsbeautify'
Plugin '2072/PHP-Indenting-for-VIm'
Plugin 'stephpy/vim-php-cs-fixer'
Plugin 'phpactor/phpactor'

call vundle#end()

filetype plugin indent on
set tabstop=4 shiftwidth=4 expandtab

" --- General settings ---
set backspace=indent,eol,start
set ruler
set number
set showcmd
set incsearch
set hlsearch

set t_Co=256
syntax enable

set mouse=a

hi clear SignColumn

" --- Plugin specific Settings ---

set background=dark

colorscheme minimalist

set laststatus=2

let g:molokai_original = 1
let g:rehash256 = 1

let g:airline_detect_paste=1
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='molokai'

let g:neocomplete#enable_at_startup = 1

let g:php_syntax_extensions_enabled = 1

nmap <silent> <leader>t :NERDTreeTabsToggle<CR>
let g:nerdtree_tabs_open_on_console_startup = 1

let g:easytags_events = ['BufReadPost', 'BufWritePost']
let g:easytags_async = 1
let g:easytags_dynamic_files = 2
let g:easytags_resolve_links = 1
let g:easytags_suppress_ctags_warnings = 1

nmap <silent> <leader>b :TagbarToggle<CR>
noremap <C-F> :FZF<CR>
noremap <C-w> :Bdelete<CR>

let g:airline#extensions#hunks#non_zero_only = 1

let delimitMate_expand_cr = 1
augroup mydelimitMate
		au!
		au FileType markdown let b:delimitMate_nesting_quotes = ["`"]
		au FileType tex let b:delimitMate_quotes = ""
		au FileType tex let b:delimitMate_matchpairs = "(:),[:],{:},`:'"
		au FileType tex let b:delimitMate_nesting_quotes = ['"', "'"]
augroup END

autocmd BufWritePost *.php silent! call PhpCsFixerFixFile()

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

