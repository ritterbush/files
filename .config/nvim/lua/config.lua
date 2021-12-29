--config

-- Default mapleader key is '\'
--let mapleader = ","
vim.g.mapleader = ','

--:help nvim-defaults
--nocompatible is set by default
--set nocompatible        " Set compatibility to Vim only. Recommended or else it might make Vim or plugins behave unexpectedly. Description of 'compatible' from manual: This option has the effect of making Vim either more Vi-compatible, or make Vim behave in a more useful way.
--syntax highlighting is enabled by default
--syntax enable           " enable syntax processing

vim.opt.tabstop = 4       -- number of visual spaces per TAB
--set softtabstop=4   " number of spaces in tab when editing
vim.opt.softtabstop = 4   -- number of spaces in tab when editing
--set shiftwidth=4   " number of indents after a brackettab for compatible langauge file
vim.opt.shiftwidth = 4    -- number of spaces to use for autoindent
--set expandtab       " tabs are spaces
vim.opt.expandtab = true  -- tabs are spaces
--autoindent is set by default
--vim.opt.autoindent = true
vim.opt.copyindent = true -- copy indent from the previous line
--set number              " show absolute line numbers; using with retivenumber sets a hybrid mode; toggle with nu!
vim.opt.number = true
--set relativenumber      " show relative line numbers; using with number sets a hybrid mode; toggle with rnu!
--vim.opt.relativenumber = true
--set ignorecase          " caseinsenitive searches; hotkeys \C to set \c to disable
vim.opt.ignorecase = true
--set smartcase           " requires ignorecase, case sensitive if searchterm has uppercase letter
vim.opt.smartcase = true
--set showcmd             " show command in bottom bar
--enabled by default: vim.opt.showcmd = true
--set wildmenu            " visual autocomplete for command menu
--enabled by default: vim.opt.wildmenu = true
--"set cursorline          " highlight current line
--set lazyredraw          " redraw only when we need to.
--incsearch enabled by default
--set incsearch           " search as characters are entered
--hlsearch enabled by default
--set hlsearch            " highlight matches
--vim.opt.hlsearch = true

--"C+X C+O to use intelliJ-style autocompletion. Use C+N and C+P to navigate the list menu.
--set omnifunc=syntaxcomplete#Complete

vim.opt.list = true -- See whitespace chars
vim.opt.scrolloff = 4 -- Scroll page when this amount of lines is left
--Default vim.opt.wrap = true --Line wrap

--https://stackoverflow.com/questions/68685327/how-can-i-override-configurations-from-the-built-in-ftplugins
--https://www.notonlycode.org/neovim-lua-config/
--https://stackoverflow.com/questions/6076592/vim-set-formatoptions-being-lost
vim.cmd([[
filetype plugin indent on
autocmd BufNewFile,BufRead * setlocal formatoptions-=ro
]])

--[[
Lots of issues trying to get a Lua version of the above working.

The main issue is that the ftplugin (Filetype plugin) configs 
of /usr/share/nvim/runtime/ftplugin/lua.vim (use 
:verbose set formatoptions , with the above command commented out,
to see the path to the last place a config was sourced from--when
using an Appimage the path will be from the /tmp/ folder)
will overwrite or be loaded after this config here. The way
around this was to use the vim command 'filetype plugin indent on'
right before changing the formatoptions. If I can find a lua
version of this command, I may be able to ditch the vim cmd
above.

However, as of 0.6, a lot of what I've read indicates that
autocmds are not available for lua yet.

Here's a messy compilation of summaries with all my attempts
to get it working.

--Added to remove how comments annoyingly continue
--on the next line (it happened just now, which is
--one of the few times it is useful, but once I add
--in my cmd, I will need to backspace twice, and
--comments are rarely longer than one line!
--autocmd BufNewFile,BufRead * setlocal formatoptions-=cro
--vim.opt.formatoptions = vim.opt.formatoptions + 'M' --works because ftplugin config does not remove 'M'

--Examples of using :gsub lua function to remove a char from a string
--vim.o.shortmess = vim.o.shortmess:gsub('c', '') --works
--vim.opt.formatoptions = vim.opt.formatoptions:gsub('c', '') --doesn't work, because ftplugin config re-adds 'c'
--vim.o.formatoptions = 'ql' --doesn't work for same reason as above. Same with below.
--vim.o.formatoptions = 'qnj1' -- q  - comment formatting; n - numbered lists; j - remove comment when joining lines; 1 - don't break after one-letter word

-- Text behaviour
-- o.formatoptions = o.formatoptions
--                    + 't'    -- auto-wrap text using textwidth
--                    + 'c'    -- auto-wrap comments using textwidth
--                    + 'r'    -- auto insert comment leader on pressing enter
--                    - 'o'    -- don't insert comment leader on pressing o
--                    + 'q'    -- format comments with gq
--                    - 'a'    -- don't autoformat the paragraphs (use some formatter instead)
--                    + 'n'    -- autoformat numbered list
--                    - '2'    -- I am a programmer and not a writer
--                    + 'j'    -- Join comments smartly

-- Same issues as mentioned above:
--vim.opt.formatoptions = vim.opt.formatoptions .. 'jcql'
--vim.opt.formatoptions='jcql'
--vim.o.formatoptions:=jcql
--vim.o.formatoptions:remove { "r", "o" }
--vim.o.formatoptions = vim.o.formatoptions:gsub('r', '')
--vim.o.formatoptions = vim.o.formatoptions:gsub('o', '')


-- Some attempts at a lua version of: filetype plugin indent on
-- These don't work in 0.6 unless stated otherwise
--vim.opt.filetype = on --works 0.6
--vim.opt.filetype-plugin = on
--vim.opt.plugin =  on
--vim.opt.indent = on
--vim.opt.formatoptions:remove { "r", "o" } --works 0.6
--vim.opt_global.formatoptions:remove { "r", "o" } --works -0.6
--vim.bo.formatoptions:remove { "r", "o" }
--vim.wo.formatoptions:remove { "r", "o" }
--vim.go.formatoptions:remove { "r", "o" }
--autocmd BufNewFile,BufRead * setlocal formatoptions-=cro


]]--




