-- mapleader is changed in config.lua, in order to be loaded near the start

local function keymap(mode, shortcut, command)
    vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end

--" kj is escape; homerow alternative
keymap("i","kj","<esc>")

-- Turn off highlighted chars after a search
keymap("n","<leader><space>",":nohlsearch<CR>")

-- Turn off and on transparency according to colorscheme
if vim.g.colors_name == "lushwal" then
keymap("n","<leader>s",[[:colorscheme lushwal<enter> | :lua print("LushWal colorscheme")<enter>]])
keymap("n","<leader>t",[[:lua Colorscheme_transparency()<enter> | :lua Colorscheme_transparency_tlf()<enter> | :lua print("LushWal colorscheme with transparency")<enter>]])
end

if vim.g.colors_name == "dracula" then
keymap("n","<leader>s",[[:colorscheme dracula<enter> | :lua print("Dracula colorscheme")<enter>]])
keymap("n","<leader>t",[[:lua Colorscheme_transparency()<enter> | :lua print("Dracula colorscheme with transparency")<enter>]])
end

-- Toggle colorcolumn
vim.cmd([[nnoremap <leader>c :execute "set colorcolumn=" . (&colorcolumn == "" ? "80" : "")<CR>]])
-- Neither of these work (single quotes nor escaped double quotes):
--keymap ("n", "<leader>c", 'execute "set colorcolumn=" . (&colorcolumn == "" ? "80" : "")<CR>')
--keymap ("n", "<leader>c", "execute \"set colorcolumn=\" . (&colorcolumn == \"\" ? \"80\" : \"\")<CR>")

--"Remappings to make vim behave like an IDE
--"Go to string via search, then, using the null buffer to keep anything yanked/x'ed/etc delete using cmd following 'c'.
--inoremap ;; <Esc>/<++><Enter>"_c4l
--inoremap ;cl console.log();<Esc>hi
--"The following are remaps specific to filetype
--"HTML
--autocmd FileType html inoremap ;em <em></em><Space><++><Esc>2F>a
--autocmd FileType html inoremap ;b <b></b><Space><++><Esc>2F>a
--autocmd FileType html inoremap ;p <p></p><Enter><Enter><++><Esc>2k$F<i
