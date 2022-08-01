local set = vim.opt

-- Colorschemes: Select one --
--vim.cmd [[colorscheme dracula]]
--vim.cmd [[colorscheme lushwal]] -- in source code set ColorColumn fg to colors.background, and CursorLine fg to "None"; run :LushwalCompile
--vim.cmd [[colorscheme lushwal | highlight ColorColumn ctermbg=grey guibg=grey]] -- helper to debug ColorColumn

--[[
Settings to let the terminal dictate transparency
see :h hl-normal for options

CursorLine: line of the cursor; Nr is line number of cursor
EndOfBuffer: the bottom of short files
FoldColumn: folds, I think; will add folds soon maybe
LineNR: line numbers
Normal: background
Pmenu: popup windows (TODO:diagnostic msg is still opaque)
SignColumn: column left of numbers
StatusLines: the bottom bar; NC affects the top bar of open splits
TabLines: the top bar
WinSeparator: vsplit bar is just a borderline
WhiteSpace: leading whitespace, any tabs, etc.
--]]

function Colorscheme_transparency()
vim.cmd [[
highlight CursorLine ctermbg=NONE guibg=NONE
highlight CursorLineNr ctermbg=NONE guibg=NONE
highlight EndOfBuffer ctermbg=NONE guibg=NONE
highlight FoldColumn ctermbg=NONE guibg=NONE
highlight LineNr ctermbg=NONE guibg=NONE
highlight Normal ctermbg=NONE guibg=NONE
highlight Pmenu ctermbg=NONE guibg=NONE
highlight SignColumn ctermbg=NONE guibg=NONE
highlight StatusLine ctermbg=NONE guibg=NONE
highlight StatusLineNC ctermbg=NONE guibg=NONE
highlight TabLine ctermbg=NONE guibg=NONE
highlight TabLineSel ctermbg=NONE guibg=NONE
highlight WinSeparator ctermbg=NONE guibg=NONE
highlight WhiteSpace ctermbg=NONE guibg=NONE
]]
end
function Colorscheme_transparency_tlf()
vim.cmd [[
highlight TabLineFill ctermbg=NONE guibg=NONE
]]
end

if vim.g.colors_name == "lushwal" then
Colorscheme_transparency()
Colorscheme_transparency_tlf()
print("Using LushWal")
end

if vim.g.colors_name == "dracula" then
Colorscheme_transparency()
print("Using Dracula")
end

set.title = true -- shows file and dir instead of terminal name

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
set.backspace = "indent,eol,start"
-- This also works:
--set.backspace = { "indent", "eol", "start" }
set.syntax = "enable" -- enable (vs on) should keep current color setting

set.clipboard = "unnamedplus"               -- allows neovim to access the system clipboard
set.cmdheight = 2                           -- more space in the neovim command line for displaying messages
set.completeopt = { "menu", "menuone", "noselect" } -- mostly just for cmp
set.conceallevel = 0                        -- so that `` is visible in markdown files
set.fileencoding = "utf-8"                  -- the encoding written to a file
set.pumheight = 10                          -- pop up menu height
set.showmode = false                        -- we don't need to see things like -- INSERT -- anymore
set.splitbelow = true                       -- force all horizontal splits to go below current window
set.splitright = true                       -- force all vertical splits to go to the right of current window
set.termguicolors = true                    -- set term gui colors (most terminals support this)
set.timeoutlen = 400                        -- time to wait for a mapped sequence to complete (in milliseconds)
set.undofile = true                         -- enable persistent undo
set.updatetime = 300                        -- faster completion (4000ms default)
set.writebackup = false                     -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
set.cursorline = true                       -- highlight the current line
set.signcolumn = "yes"                      -- always show the sign column, otherwise it would shift the text each time
set.wrap = true                            -- don't display lines as one long line
set.linebreak = true                            -- with above true; wrap lines by words
set.scrolloff = 8                           -- is one of my fav
set.sidescrolloff = 8
set.guifont = "monospace:h17"               -- the font used in graphical neovim applications
set.backup = false                          -- creates a backup file
set.swapfile = false                        -- creates a swapfile

set.tabstop = 4       -- number of visual spaces per TAB
set.softtabstop = 4   -- number of spaces in tab when editing
set.shiftwidth = 4    -- number of spaces to use for autoindent
set.expandtab = true  -- tabs are spaces
set.autoindent = true -- indent carries on to the next line
set.copyindent = true -- copies the tab/space chars indent from the previous line
set.showtabline = 4                         -- always show tabs
set.smartindent = true                      -- make indenting smarter again

set.number = true --show absolute line numbers; using with retivenumber sets a hybrid mode; toggle with nu!
--set.relativenumber = true -- show relative line numbers; using with number sets a hybrid mode; toggle with rnu!
set.ruler = true -- show the cursor position
set.incsearch = true -- search as characters are entered
set.hlsearch = true -- highlight matches
set.ignorecase = true -- caseinsenitive searches; hotkeys \C to set \c to disable
set.smartcase = true -- requires ignorecase, case sensitive if searchterm has uppercase letter
set.showcmd = true -- show command in bottom bar
set.showmatch = true -- Show matching brackets
set.list = true -- See whitespace chars
--set.autowrite = true -- Automatically save before commands like :next and :make
--set.hidden = true -- Hide buffers when they are abandoned
set.mouse = "a"     -- Enable mouse usage (all modes)

set.history = 10000     -- keep the max of 10000 lines of command line history
set.wildmenu = true -- visual autocomplete for command menu
set.lazyredraw = true -- redraw only when we need to

-- Color column settings
set.colorcolumn = {"80"}
--vim.cmd([[highlight! link SignColumn colorcolumn]])
-- Off to start
vim.cmd([[
:execute "set colorcolumn=" . (&colorcolumn == "" ? "80" : "")
]])

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
--set.formatoptions = vim.opt.formatoptions + 'M' --works because ftplugin config does not remove 'M'

--Examples of using :gsub lua function to remove a char from a string
--vim.o.shortmess = vim.o.shortmess:gsub('c', '') --works
--set.formatoptions = vim.opt.formatoptions:gsub('c', '') --doesn't work, because ftplugin config re-adds 'c'
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
--set.formatoptions = vim.opt.formatoptions .. 'jcql'
--set.formatoptions='jcql'
--vim.o.formatoptions:=jcql
--vim.o.formatoptions:remove { "r", "o" }
--vim.o.formatoptions = vim.o.formatoptions:gsub('r', '')
--vim.o.formatoptions = vim.o.formatoptions:gsub('o', '')


-- Some attempts at a lua version of: filetype plugin indent on
-- These don't work in 0.6 unless stated otherwise
--set.filetype = on --works 0.6
--set.filetype-plugin = on
--set.plugin =  on
--set.indent = on
--set.formatoptions:remove { "r", "o" } --works 0.6
--set_global.formatoptions:remove { "r", "o" } --works -0.6
--vim.bo.formatoptions:remove { "r", "o" }
--vim.wo.formatoptions:remove { "r", "o" }
--vim.go.formatoptions:remove { "r", "o" }
--autocmd BufNewFile,BufRead * setlocal formatoptions-=cro

]]--

