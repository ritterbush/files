-- Default mapleader key is '\'
vim.g.mapleader = ','

-- Have Vim jump to the last position when
-- reopening a file
-- see :help last-position-jump
vim.cmd([[autocmd BufRead * autocmd FileType <buffer> ++once
\ if &ft !~# 'commit\|rebase' && line("'\"") > 1 && line("'\"") <= line("$") | exe 'normal! g`"' | endif]])

-- See :help nvim-defaults
-- Many of these are already defaults but defaults may always change
vim.g.compatible = false
vim.opt.backspace = "indent,eol,start"
-- This also works:
--vim.opt.backspace = { "indent", "eol", "start" }
vim.opt.syntax = "enable" -- enable (vs on) should keep current color setting

vim.opt.clipboard = "unnamedplus"               -- allows neovim to access the system clipboard
vim.opt.cmdheight = 2                           -- more space in the neovim command line for displaying messages
vim.opt.completeopt = { "menuone", "noselect" } -- mostly just for cmp               
vim.opt.conceallevel = 0                        -- so that `` is visible in markdown files
vim.opt.fileencoding = "utf-8"                  -- the encoding written to a file       
vim.opt.pumheight = 10                          -- pop up menu height                
vim.opt.showmode = false                        -- we don't need to see things like -- INSERT -- anymore
vim.opt.splitbelow = true                       -- force all horizontal splits to go below current window
vim.opt.splitright = true                       -- force all vertical splits to go to the right of current window
vim.opt.termguicolors = true                    -- set term gui colors (most terminals support this)
vim.opt.timeoutlen = 400                        -- time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.undofile = true                         -- enable persistent undo            
vim.opt.updatetime = 300                        -- faster completion (4000ms default)
vim.opt.writebackup = false                     -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
vim.opt.cursorline = true                       -- highlight the current line        
vim.opt.signcolumn = "yes"                      -- always show the sign column, otherwise it would shift the text each time
vim.opt.wrap = false                            -- display lines as one long line       
vim.opt.scrolloff = 8                           -- is one of my fav                  
vim.opt.sidescrolloff = 8                                                            
vim.opt.guifont = "monospace:h17"               -- the font used in graphical neovim applications
vim.opt.backup = false                          -- creates a backup file             
vim.opt.swapfile = false                        -- creates a swapfile                

vim.opt.tabstop = 4       -- number of visual spaces per TAB
vim.opt.softtabstop = 4   -- number of spaces in tab when editing
vim.opt.shiftwidth = 4    -- number of spaces to use for autoindent
vim.opt.expandtab = true  -- tabs are spaces
vim.opt.autoindent = true -- indent carries on to the next line
vim.opt.copyindent = true -- copies the tab/space chars indent from the previous line
vim.opt.showtabline = 4                         -- always show tabs                  
vim.opt.smartindent = true                      -- make indenting smarter again         

vim.opt.number = true --show absolute line numbers; using with retivenumber sets a hybrid mode; toggle with nu!
--vim.opt.relativenumber = true -- show relative line numbers; using with number sets a hybrid mode; toggle with rnu!
vim.opt.ruler = true -- show the cursor position
vim.opt.incsearch = true -- search as characters are entered
vim.opt.hlsearch = true -- highlight matches
vim.opt.ignorecase = true -- caseinsenitive searches; hotkeys \C to set \c to disable
vim.opt.smartcase = true -- requires ignorecase, case sensitive if searchterm has uppercase letter
vim.opt.showcmd = true -- show command in bottom bar
vim.opt.showmatch = true -- Show matching brackets
vim.opt.list = true -- See whitespace chars
--vim.opt.autowrite = true -- Automatically save before commands like :next and :make
--vim.opt.hidden = true -- Hide buffers when they are abandoned
vim.opt.mouse = "a"     -- Enable mouse usage (all modes)

vim.opt.history = 10000     -- keep the max of 10000 lines of command line history
vim.opt.wildmenu = true -- visual autocomplete for command menu
vim.opt.lazyredraw = true -- redraw only when we need to

-- Color column settings
vim.opt.colorcolumn = {"80"}
vim.cmd([[highlight! link SignColumn colorcolumn]])

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

