set nocompatible              " required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'taglist.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'scrooloose/nerdtree'
Plugin 'davidhalter/jedi-vim'
"Plugin 'gabrielelana/vim-markdown'
Plugin 'junegunn/goyo.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'Rykka/riv.vim'
Plugin 'majutsushi/tagbar'
Plugin 'airblade/vim-gitgutter'
Plugin 'vim-pandoc/vim-pandoc'
Plugin 'vim-pandoc/vim-pandoc-syntax'

" Add all your plugins here (note older versions of Vundle used Bundle instead of Plugin)
Plugin 'vim-scripts/indentpython.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

"NAVIGATION
"nnoremap j h
"nnoremap k j 
"nnoremap l k
"nnoremap ; l

"set colors
"set t_Co=256

"airline
let g:airline_powerline_fonts = 1
set laststatus=2
let g:airline_theme='base16'

"tagbar
nmap <C-t> :TagbarToggle<CR>
"syntastic
"let g:syntastic_check_on_open = 1
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0
"
"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"GENERAL

"blogging
"nmap <C-D> i<C-R>=strftime("%Y-%m-%d %H:%M:%S")<CR><Esc>
"imap <C-D> <C-R>=strftime("%Y-%m-%d %H:%M:%S")<CR>
"nmap <C-D><C-D> i<C-R>=strftime("%Y-%m-%d %a %I:%M %p")<CR><Esc>
"imap <C-D><C-D> <C-R>=strftime("%Y-%m-%d %a %I:%M %p")<CR>


"enable folding
set foldmethod=indent
set foldlevel=99
nnoremap <space> za " fold with spacebar
highlight Folded ctermbg=black

"syntax highlighting
syntax enable

" show line numbers
set number


if has('mouse')
    set mouse=a
endif

" indent when moving to the next line while writing code
"set autoindent

" expand tabs into spaces
set expandtab

" when using the >> or << commands, shift lines by 4 spaces
set shiftwidth=4

" show a visual line under the cursor's current line
set cursorline

" show the matching part of the pair for [] {} and ()
set showmatch

" enable all Python syntax highlighting features
let python_highlight_all = 1

set encoding=utf-8

"map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>
"let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_autoclose_preview_window_after_completion = 1
"autocmd FileType python setlocal completeopt-=preview

let g:jedi#max_doc_height = 10

"PEP8
au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
"    \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix

au BufNewFile,BufRead *.js, *.html, *.css
    \ set tabstop=2 |
    \ set softtabstop=2 |
    \ set shiftwidth=2 |

"NERDTree
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"Spelling
set spelllang=en
set spellfile=$HOME/.vim/spell/en.utf-8.add

