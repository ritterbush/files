-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end
vim.opt.rtp:prepend(lazypath)

local set = vim.opt

-- Default mapleader key is '\'
vim.g.mapleader = ',' -- we are setting a global editor variable

-- Have Vim jump to the last position when reopening a file
-- see :help last-position-jump
vim.cmd([[autocmd BufRead * autocmd FileType <buffer> ++once
\ if &ft !~# 'commit\|rebase' && line("'\"") > 1 && line("'\"") <= line("$") | exe 'normal! g`"' | endif]])

-- Disable comments continuing on entering a new line
-- https://stackoverflow.com/questions/68685327/how-can-i-override-configurations-from-the-built-in-ftplugins
-- https://www.notonlycode.org/neovim-lua-config/
-- https://stackoverflow.com/questions/6076592/vim-set-formatoptions-being-lost
--vim.cmd([[
--filetype plugin indent on
--autocmd BufNewFile,BufRead * setlocal formatoptions-=ro
--]])
vim.cmd('autocmd BufEnter * set formatoptions-=ro')
vim.cmd('autocmd BufEnter * setlocal formatoptions-=ro')


-- See :help nvim-defaults
-- Many of these are default but defaults can change

vim.g.compatible = false              -- disable vi compatibility
set.clipboard = "unnamedplus"         -- allows neovim to access the system clipboard
set.title = true                      -- shows file name and directory path instead of terminal prompt
set.backspace = "indent,eol,start"    -- backspace behaves better
set.formatoptions = "tcqj"             -- does not work after plugins loaded; use vim cmd above; supposed to disable comments (options r and o) from continuing on a new line (other defaults kept)
set.syntax = "enable"                 -- syntax highlighting; enable (vs. on) keeps color settings

set.cmdheight = 1                     -- controls amount of space in the neovim command line for displaying messages, just below the statusbar (bottom bar)
--see if completeopt below is needed, or which can be changed
set.completeopt = { "menu", "menuone", "noselect" }    -- mostly just for cmp; options for insert mode completion
set.conceallevel = 0                  -- 0 conceals no text; 1 conceals keywords with a character in syn-cchar
set.fileencoding = "utf-8"            -- the encoding written to a file
set.pumheight = 10                    -- pop up menu height
set.showmode = true                   -- set to false to not see things like -- INSERT -- anymore
set.splitbelow = true                 -- force all horizontal splits to go below current window
set.splitright = true                 -- force all vertical splits to go to the right of current window
set.termguicolors = true              -- set term gui colors (most terminals support this)
set.timeoutlen = 400                  -- time to wait for a mapped sequence to complete (in milliseconds)
set.undofile = true                   -- enable persistent undo
set.updatetime = 300                  -- faster completion (4000ms default)
set.writebackup = false               -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
set.cursorline = true                 -- highlight the current line
set.signcolumn = "yes"                -- always show the sign column, otherwise it would shift the text each time
set.wrap = true                       -- don't display lines as one long line
set.linebreak = true                  -- with above true; wrap lines by words
set.scrolloff = 8                     -- scrolls when at top or bottom by this amount
set.sidescrolloff = 8                 -- scrolls when at the left or right by this amount
--set.guifont = "monospace:h17"       -- the font used in graphical neovim applications
set.backup = false                    -- creates a backup file
set.swapfile = false                  -- creates a swapfile

set.list = true                       -- shows tabs and any other whitespace chars set in listchars
set.tabstop = 4                       -- number of spaces shown per tab (does not change tabs to spaces)
set.expandtab = true                  -- tabs are spaces
set.softtabstop = 4                   -- number of spaces in tab when editing
set.shiftwidth = 4                    -- number of spaces to use for autoindent
set.autoindent = true                 -- indent carries on to the next line
set.copyindent = true                 -- copies the tab/space chars indent from the previous line
set.showtabline = 4                   -- always show tabs
set.smartindent = true                -- make indenting smarter again

set.number = true                     --show absolute line numbers; using with retivenumber sets a hybrid mode; toggle with nu!
--set.relativenumber = true             -- show relative line numbers; using with number sets a hybrid mode; toggle with rnu!
set.ruler = true                      -- show the cursor position in the statusline (bottom bar)
set.incsearch = true                  -- search as characters are entered
set.hlsearch = true                   -- highlight matches
set.ignorecase = true                 -- caseinsenitive searches; hotkeys \C to set \c to disable
set.smartcase = true                  -- requires ignorecase, case sensitive if searchterm has uppercase letter
set.showcmd = true                    -- show command in statusline (bottom bar)
set.showmatch = true                  -- show matching brackets
--set.autowrite = true                  -- automatically save before commands like :next and :make
--set.hidden = true                     -- hide buffers when they are abandoned
set.mouse = "a"                       -- enable mouse usage for all modes

set.history = 10000                   -- keep the max of 10000 lines of command line history
set.wildmenu = true                   -- visual autocomplete for command menu
set.lazyredraw = true                 -- redraw only when we need to

require("lazy").setup("plugins")

local function keymap(mode, shortcut, command)
    vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end

-- kj is escape; homerow alternative
keymap("i","kj","<esc>")

-- Turn off highlighted chars after a search
keymap("n","<leader><space>",":nohlsearch<CR>")

-- Toggle colorcolumn
vim.cmd([[nnoremap <leader>c :execute "set colorcolumn=" . (&colorcolumn == "" ? "80" : "")<CR>]])
