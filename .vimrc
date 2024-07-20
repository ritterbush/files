" Default mapleader key is '\'
let mapleader = ','

" modelines have historically been a source of security/resource vulnerabilities,
" since they allow the editor to run commands if the opened file indicates them
set nomodeline

" Have Vim jump to the last position when reopening a file
" see :help last-position-jump
autocmd BufRead * autocmd FileType <buffer> ++once
\ if &ft !~# 'commit\|rebase' && line("'\"") > 1 && line("'\"") <= line("$") | exe 'normal! g`"' | endif

" Magic cursor shape shifting (Insert Mode now vertical bar as it always has
" been for me until now?)
"let &t_ti.="\e[1 q"
let &t_SI.="\e[5 q" " t_SI: start insert mode bar cursor shape
let &t_EI.="\e[1 q" " t_EI: end insert mode bar cursor shape
"let &t_te.="\e[0 q"

"MAYBEREMOVE
" Disable comments continuing on entering a new line
"filetype plugin indent on
"autocmd BufNewFile,BufRead * setlocal formatoptions-=ro

set background=dark

set nocompatible                      " disable vi compatibility
set clipboard=unnamedplus         " allows neovim to access the system clipboard
set title                             " shows file name and directory path instead of terminal prompt
set backspace=indent,eol,start    " backspace behaves better
set formatoptions=tcqj             " does not work after plugins loaded; use vim cmd above; supposed to disable comments (options r and o) from continuing on a new line (other defaults kept)
syntax enable                 " syntax highlighting; enable (vs. on) keeps color settings

set cmdheight=1                     " controls amount of space in the neovim command line for displaying messages, just below the statusbar (bottom bar)
" see if completeopt below is needed, or which can be changed
" set completeopt=menu,menuone,noselect    " mostly just for cmp; options for insert mode completion
set conceallevel=0                  " 0 conceals no text; 1 conceals keywords with a character in syn-cchar
set fileencoding=utf-8            " the encoding written to a file
set pumheight=10                    " pop up menu height
set noshowmode                          " set to false to not see things like -- INSERT -- anymore
set splitbelow                        " force all horizontal splits to go below current window
set splitright                        " force all vertical splits to go to the right of current window
set termguicolors                     " set term gui colors (most terminals support this)
set timeoutlen=400                  " time to wait for a mapped sequence to complete (in milliseconds)
set undofile                          " enable persistent undo
set updatetime=300                  " faster completion (4000ms default)
set nowritebackup                  " if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
set cursorline                        " highlight the current line
set signcolumn=yes                " always show the sign column, otherwise it would shift the text each time
set wrap                              " don't display lines as one long line
set linebreak                         " with above true; wrap lines by words
set scrolloff=8                     " scrolls when at top or bottom by this amount
set sidescrolloff=8                 " scrolls when at the left or right by this amount
set guifont=monospace:h17         " the font used in graphical neovim applications
set nobackup                          " creates a backup file
set noswapfile                        " creates a swapfile

set list                              " shows tabs and any other whitespace chars set in listchars
set listchars=tab:>\ ,trail:-,nbsp:+ " make same as neovim default
set tabstop=4                       " number of spaces shown per tab (does not change tabs to spaces)
set expandtab                         " tabs are spaces
set softtabstop=4                   " number of spaces in tab when editing
set shiftwidth=4                    " number of spaces to use for autoindent
set autoindent                        " indent carries on to the next line
set copyindent                        " copies the tab/space chars indent from the previous line
set showtabline=4                   " always show tabs
set smartindent                       " make indenting smarter again

set number                            " show absolute line numbers; using with retivenumber sets a hybrid mode; toggle with nu!
" set relativenumber                    " show relative line numbers; using with number sets a hybrid mode; toggle with rnu!
set ruler                             " show the cursor position in the statusline (bottom bar)
set incsearch                         " search as characters are entered
set hlsearch                          " highlight matches
set ignorecase                        " caseinsenitive searches; hotkeys \C to set \c to disable
set smartcase                         " requires ignorecase, case sensitive if searchterm has uppercase letter
set showcmd                           " show command in statusline (bottom bar)
set showmatch                         " show matching brackets
" set autowrite                         " automatically save before commands like :next and :make
" set hidden                            " hide buffers when they are abandoned
set mouse=a                       " enable mouse usage for all modes

set history=10000                   " keep the max of 10000 lines of command line history
set wildmenu                          " visual autocomplete for command menu
set lazyredraw                        " redraw only when we need to

" kj is escape; homerow alternative
inoremap kj <esc>

" Turn off highlighted chars after a search
nnoremap <leader><space> :nohlsearch<CR>"

" Toggle colorcolumn
nnoremap <leader>c :execute "set colorcolumn=" . (&colorcolumn == "" ? "80" : "")<CR>
