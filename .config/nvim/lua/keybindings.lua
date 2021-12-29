function keymap(mode, shortcut, command)    
    vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })    
end

-- Turn off highlighting when done
keymap("n","<leader><space>",":nohlsearch<CR>")
--" turn off search highlight;
--nnoremap <leader><space> :nohlsearch<CR>

--" jk is escape; homerow alternative; to still type 'jk', wait a beat after
--" typing 'j'
--inoremap kj <esc>
keymap("i","kj","<esc>")

--"Remappings to make vim behave like an IDE
--"Go to string via search, then, using the null buffer to keep anything yanked/x'ed/etc delete using cmd following 'c'.
--inoremap ;; <Esc>/<++><Enter>"_c4l
--inoremap ;cl console.log();<Esc>hi
--"The following are remaps specific to filetype
--"HTML
--autocmd FileType html inoremap ;em <em></em><Space><++><Esc>2F>a
--autocmd FileType html inoremap ;b <b></b><Space><++><Esc>2F>a
--autocmd FileType html inoremap ;p <p></p><Enter><Enter><++><Esc>2k$F<i 
