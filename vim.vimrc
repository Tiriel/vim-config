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
Plugin 'bling/vim-bufferline'
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
Plugin 'ajmwagar/vim-deus'
Plugin 'nightsense/carbonized'
Plugin 'morhetz/gruvbox'
Plugin 'aradunovic/perun.vim'
Plugin 'joshdick/onedark.vim'

" --- Syntax Plugins ---
Plugin 'stephpy/vim-yaml'
Plugin 'StanAngeloff/php.vim'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'cakebaker/scss-syntax.vim'

" --- Code Assist Plugins ---
Plugin 'shawncplus/phpcomplete.vim'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'sniphpets/sniphpets'
Plugin 'sniphpets/sniphpets-common'
Plugin 'sniphpets/sniphpets-symfony'
Plugin 'sniphpets/sniphpets-doctrine'
Plugin 'sniphpets/sniphpets-phpunit'
Plugin 'sniphpets/sniphpets-silex'
Plugin 'phpactor/phpactor'
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
set termguicolors
set background=dark

set mouse=a

hi clear SignColumn

colorscheme minimalist

set laststatus=2

" --- php.vim ---
let g:php_var_selector_is_identifier = 1

" --- Molokai color settings ---
let g:molokai_original = 1
let g:rehash256 = 1

" --- Deus color settings ---
let g:deus_termcolors=256
" let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
" let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

" --- Airline status bar ---
let g:airline_detect_paste=1
let g:airline_theme='minimalist'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_tabs = 1
let g:airline#extensions#tabline#tab_nr_type = 2
let g:airline#extensions#tabline#alt_sep = 1
let g:airline#extensions#hunks#non_zero_only = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:gitgutter_async=0

" --- Neocomplete ---
let g:neocomplete#enable_at_startup = 1

" --- NERDTree ---
let g:nerdtree_tabs_open_on_console_startup = 1
let g:NERDTreeChDirMode = 2

" --- EasyTags ---
let g:easytags_events = ['BufReadPost', 'BufWritePost']
let g:easytags_async = 1
let g:easytags_dynamic_files = 2
let g:easytags_resolve_links = 1
let g:easytags_suppress_ctags_warnings = 1

" --- UtilSnips ---
let g:UltiSnipsExpandTrigger="<Tab>"
let g:UltiSnipsJumpForwardTrigger="<C-z>"
let g:UltiSnipsJumpBackwardTrigger="<C-a>"

" --- Maps & remaps ---
"remap the leader to something easier to type
let mapleader = "ù"

" Airline Tabline
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9
nmap <leader>( <Plug>AirlineSelectPrevTab
nmap <leader>) <Plug>AirlineSelectNextTab

" vim-fugitive
nmap <silent> <leader>gs :Gstatus<CR>
nmap <silent> <leader>gpl :Gpull 
nmap <silent> <leader>gps :Gpush 
nmap <silent> <leader>gf :Gfetch 
nmap <silent> <leader>gl :Glog<CR>
nmap <silent> <leader>gb :Gblame<CR>
nmap <silent> <leader>gc :Gcommit -m ""
nmap <silent> <leader>gr :Git rebase 

" ArgWrap*
nnoremap <silent> <leader>a :ArgWrap<CR>

" EasyAlign
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" NERDTree
nmap <silent> <leader>t :NERDTreeTabsToggle<CR>
nmap <silent> <leader>b :TagbarToggle<CR>
nmap <silent> <leader>r :NERDTreeCWD<CR>

" TagbarToggle
nmap <F12> :TagbarToggle<CR>

" FZF
noremap <C-F> :FZF<CR>
noremap <leader>q :Bdelete<CR>
" remap splits navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" CamelCaseMotion
map <silent> <C-w> <Plug>CamelCaseMotion_w
map <silent> <C-b> <Plug>CamelCaseMotion_b
map <silent> <C-e> <Plug>CamelCaseMotion_e
map <silent> <C-g>e <Plug>CamelCaseMotion_ge

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

autocmd BufEnter * sign define dummy
autocmd BufEnter * execute 'sign place 9999 line=1 name=dummy buffer=' . bufnr('')


