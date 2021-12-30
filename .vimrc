" Default mapleader key is '\'
let mapleader = ","

" modelines have historically been a source of security/resource
" vulnerabilities -- disable by default, even when 'nocompatible' is set
set nomodeline

" Magic cursor shape shifting (Insert Mode now vertical bar as it always has
" been for me until now?)
"let &t_ti.="\e[1 q"
let &t_SI.="\e[5 q" " t_SI: start insert mode bar cursor shape
let &t_EI.="\e[1 q" " t_EI: end insert mode bar cursor shape
"let &t_te.="\e[0 q"

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
set background=dark

" Have Vim jump to the last position when
" reopening a file
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
filetype plugin indent on
" Stop comments from continuing on a new line 
autocmd BufNewFile,BufRead * setlocal formatoptions-=ro

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
set nocompatible " Use Vim defaults instead of 100% vi compatibility
set backspace=indent,eol,start " more powerful backspacing
syntax enable " enable (vs on) should keep current color settings

set clipboard="unnamedplus"               " allows neovim to access the system clipboard
set cmdheight=2                           " more space in the neovim command line for displaying messages
"set completeopt={ "menuone", "noselect" } " mostly just for cmp
set conceallevel=0                        " so that `` is visible in markdown files
set fileencoding="utf-8"                  " the encoding written to a file
set pumheight=10                          " pop up menu height
set noshowmode                        " we don't need to see things like -- INSERT -- anymore
set splitbelow                       " force all horizontal splits to go below current window
set splitright                       " force all vertical splits to go to the right of current window
set termguicolors                    " set term gui colors (most terminals support this)
set timeoutlen=400                        " time to wait for a mapped sequence to complete (in milliseconds)
set undofile                         " enable persistent undo
set updatetime=300                        " faster completion (4000ms default)
set nowritebackup                     " if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
set cursorline                       " highlight the current line
set signcolumn="yes"                      " always show the sign column, otherwise it would shift the text each time
set nowrap                            " display lines as one long line
set scrolloff=8                           " is one of my fav
set sidescrolloff=8
set guifont="monospace:h17"               " the font used in graphical neovim applications
set nobackup                          " creates a backup file
set noswapfile                        " creates a swapfile

set tabstop=4  "number of visual spaces per TAB
set softtabstop=4 " number of spaces in tab when editing
set shiftwidth=4 " number of indents after a brackettab for compatible langauge file
set expandtab " tabs are spaces
set autoindent " indent carries on to the next line
set copyindent " copies the tab/space chars indent from the previous line
set showtabline=4 " always show tabs
set smartindent " make indenting smarter again

set number "show absolute line numbers; using with retivenumber sets a hybrid mode; toggle with nu!
"set relativenumber " show relative line numbers; using with number sets a hybrid mode; toggle with rnu!
set ruler " show the cursor position
set incsearch " search as characters are entered
set hlsearch " highlight matches
set ignorecase " Do case insensitive matching
set smartcase " Do smart case matching
set showcmd " Show (partial) command in status line
set showmatch " Show matching brackets
set list " See whitespace chars
"set autowrite " Automatically save before commands like :next and :make
"set hidden " Hide buffers when they are abandoned
set mouse=a " Enable mouse usage (all modes)

set history=10000 " keep the max of 10000 lines of command line history
set wildmenu " visual autocomplete for command menu
set lazyredraw " redraw only when we need to

"----- Keymappings -----

" kj is escape; homerow alternative
inoremap kj <esc>

" Turn off highlighted chars after a search
nnoremap <leader><space> :nohlsearch<CR>

""Color column ending using the left column color
set colorcolumn=80
highlight! link SignColumn colorcolumn
""Toggle colorcolumn
nnoremap <leader>c :execute "set colorcolumn=" . (&colorcolumn == "" ? "80" : "")<CR>

"Remappings to make vim behave like an IDE

"Go to string via search, then, using the null buffer to keep anything yanked/x'ed/etc delete using cmd following 'c'.
inoremap ;; <Esc>/<++><Enter>"_c4l
inoremap ;cl console.log();<Esc>hi


"The following are remaps specific to filetype

"HTML
autocmd FileType html inoremap ;em <em></em><Space><++><Esc>2F>a
autocmd FileType html inoremap ;b <b></b><Space><++><Esc>2F>a
autocmd FileType html inoremap ;p <p></p><Enter><Enter><++><Esc>2k$F<i

autocmd FileType html vnoremap ;b <ESC><ESC>`<i<b><ESC>`>3la</b><ESC>`<3lv`>3l
"The above doesn't quite work:
"Explanation:
"<ESC><ESC>         Exit selection mode
"`<          go to beginning of selection
"i<b>           insert "<b>" tag
"<ESC>          exit insert mode
"`>           go to end of selection
"3l           go right as many characters as you inserted before the selection
"a</b>          append (insert after) "</b>" tag
"<ESC>          exit insert mode
"`<3l           go to beginning of selection + number of characters you inserted
"v            go to visual mode
"`>3l           select until end of selection + number of characters you inserted

"LaTeX
"This is already ;; : autocmd FileType tex inoremap ;o <Esc>/<++><Enter>"_c4l
autocmd FileType tex inoremap ;q ``''<Esc>hi
autocmd FileType tex inoremap ;em \emph{}<Space><++><Esc>F{a
autocmd FileType tex inoremap ;b \textbf{}<Space><++><Esc>F{a
autocmd FileType tex inoremap ;m $$<Space><++><Esc>F$i
"autocmd FileType tex inoremap ;p <p></p><Enter><Enter><++><Esc>2k$F<i
"autocmd FileType tex vnoremap ;d <ESC><ESC>`<i<b><ESC>`>3la</b><ESC>`<3lv`>3l

