set nocompatible        "  Set compatibility to Vim only. Recommended or else it might make Vim or plugins behave unexpectedly. Description of 'compatible' from manual: This option has the effect of making Vim either more Vi-compatible, or make Vim behave in a more useful way.
"This next one is pathogen specific. 
execute pathogen#infect()

filetype plugin indent on "plugin needed for pathogen and autocompletion, enabled below.
"syntax on
syntax enable           " enable syntax processing

"C+X C+O to use intelliJ-style autocompletion. Use C+N and C+P to navigate the list menu.
set omnifunc=syntaxcomplete#Complete

set softtabstop=4   " number of spaces in tab when editing
set shiftwidth=4   " number of indents after a brackettab for compatible langauge file
set expandtab       " tabs are spaces
set number              " show absolute line numbers; using with retivenumber sets a hybrid mode; toggle with nu!
set relativenumber      " show relative line numbers; using with number sets a hybrid mode; toggle with rnu!
set ignorecase          " caseinsenitive searches; hotkeys \C to set \c to disable
set smartcase           " requires ignorecase, case sensitive if searchterm has uppercase letter
set showcmd             " show command in bottom bar
set cursorline          " highlight current line
set wildmenu            " visual autocomplete for command menu
set lazyredraw          " redraw only when we need to.
set incsearch           " search as characters are entered
set hlsearch            " highlight matches
" turn off search highlight; not working; unsure why; nno should reference that the remap is in normal mode
nnoremap <leader><space> :nohlsearch<CR>
" jk is escape; homerow alternative; to still type 'jk', wait a beat after
" typing 'j'
inoremap kj <esc>

"Remappings to make vim behave like an IDE

"Go to string via search, then, using the null buffer to keep anything yanked/x'ed/etc delete using cmd following 'c'.
inoremap ;; <Esc>/<++><Enter>"_c4l
inoremap ;cl console.log();<Esc>hi


"The following are remaps specific to filetype

"HTML
autocmd FileType html inoremap ;em <em></em><Space><++><Esc>2F>a
autocmd FileType html inoremap ;b <b></b><Space><++><Esc>2F>a
autocmd FileType html inoremap ;p <p></p><Enter><Enter><++><Esc>2k$F<i

"
""Conquer of Completion
""Example vim configuration
"
"" TextEdit might fail if hidden is not set.
"set hidden
"
"" Some servers have issues with backup files, see #649.
"set nobackup
"set nowritebackup
"
"" Give more space for displaying messages.
"set cmdheight=2
"
"" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
"" delays and poor user experience.
"set updatetime=300
"
"" Don't pass messages to |ins-completion-menu|.
"set shortmess+=c
"
"" Always show the signcolumn, otherwise it would shift the text each time
"" diagnostics appear/become resolved.
"if has("patch-8.1.1564")
  "" Recently vim can merge signcolumn and number column into one
  "set signcolumn=number
"else
  "set signcolumn=yes
"endif
"
"" Use tab for trigger completion with characters ahead and navigate.
"" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
"" other plugin before putting this into your config.
"inoremap <silent><expr> <TAB>
      "\ pumvisible() ? "\<C-n>" :
      "\ <SID>check_back_space() ? "\<TAB>" :
      "\ coc#refresh()
"inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
"
"function! s:check_back_space() abort
  "let col = col('.') - 1
  "return !col || getline('.')[col - 1]  =~# '\s'
"endfunction
"
"" Use <c-space> to trigger completion.
"if has('nvim')
  "inoremap <silent><expr> <c-space> coc#refresh()
"else
  "inoremap <silent><expr> <c-@> coc#refresh()
"endif
"
"" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
"" position. Coc only does snippet and additional edit on confirm.
"" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
"if exists('*complete_info')
  "inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
"else
  "inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
"endif
"
"" Use `[g` and `]g` to navigate diagnostics
"" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
"nmap <silent> [g <Plug>(coc-diagnostic-prev)
"nmap <silent> ]g <Plug>(coc-diagnostic-next)
"
"" GoTo code navigation.
"nmap <silent> gd <Plug>(coc-definition)
"nmap <silent> gy <Plug>(coc-type-definition)
"nmap <silent> gi <Plug>(coc-implementation)
"nmap <silent> gr <Plug>(coc-references)
"
"" Use K to show documentation in preview window.
"nnoremap <silent> K :call <SID>show_documentation()<CR>
"
"function! s:show_documentation()
  "if (index(['vim','help'], &filetype) >= 0)
    "execute 'h '.expand('<cword>')
  "else
    "call CocAction('doHover')
  "endif
"endfunction
"
"" Highlight the symbol and its references when holding the cursor.
"autocmd CursorHold * silent call CocActionAsync('highlight')
"
"" Symbol renaming.
"nmap <leader>rn <Plug>(coc-rename)
"
"" Formatting selected code.
"xmap <leader>f  <Plug>(coc-format-selected)
"nmap <leader>f  <Plug>(coc-format-selected)
"
"augroup mygroup
  "autocmd!
  "" Setup formatexpr specified filetype(s).
  "autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  "" Update signature help on jump placeholder.
  "autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
"augroup end
"
"" Applying codeAction to the selected region.
"" Example: `<leader>aap` for current paragraph
"xmap <leader>a  <Plug>(coc-codeaction-selected)
"nmap <leader>a  <Plug>(coc-codeaction-selected)
"
"" Remap keys for applying codeAction to the current buffer.
"nmap <leader>ac  <Plug>(coc-codeaction)
"" Apply AutoFix to problem on the current line.
"nmap <leader>qf  <Plug>(coc-fix-current)
"
"" Map function and class text objects
"" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
"xmap if <Plug>(coc-funcobj-i)
"omap if <Plug>(coc-funcobj-i)
"xmap af <Plug>(coc-funcobj-a)
"omap af <Plug>(coc-funcobj-a)
"xmap ic <Plug>(coc-classobj-i)
"omap ic <Plug>(coc-classobj-i)
"xmap ac <Plug>(coc-classobj-a)
"omap ac <Plug>(coc-classobj-a)
"
"" Use CTRL-S for selections ranges.
"" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
"nmap <silent> <C-s> <Plug>(coc-range-select)
"xmap <silent> <C-s> <Plug>(coc-range-select)
"
"" Add `:Format` command to format current buffer.
"command! -nargs=0 Format :call CocAction('format')
"
"" Add `:Fold` command to fold current buffer.
"command! -nargs=? Fold :call     CocAction('fold', <f-args>)
"
"" Add `:OR` command for organize imports of the current buffer.
"command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')
"
"" Add (Neo)Vim's native statusline support.
"" NOTE: Please see `:h coc-status` for integrations with external plugins that
"" provide custom statusline: lightline.vim, vim-airline.
"set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
"
"" Mappings for CoCList
"" Show all diagnostics.
"nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
"" Manage extensions.
"nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
"" Show commands.
"nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
"" Find symbol of current document.
"nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
"" Search workspace symbols.
"nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
"" Do default action for next item.
"nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
"" Do default action for previous item.
"nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
"" Resume latest coc list.
"nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
"
"
"
"
"" Added to remove how comments annoyingly continue
"" on the next line (it happened just now, which is
"" one of the few times it is useful, but once I add
"" in my cmd, I will need to backspace twice, and
"" comments are rarely longer than one line!
"autocmd BufNewFile,BufRead * setlocal formatoptions-=cro
"



" THE BELOW ARE JUST A COPY/PASTE FROM ONLINE
" DELETE OR USE LATER
" " Helps force plug-ins to load correctly when it is turned back on below.
" filetype off
"
" " Turn on syntax highlighting.
" syntax on
"
" " For plug-ins to load correctly.
" filetype plugin indent on
"
" " Turn off modelines
" set modelines=0
"
" " Automatically wrap text that extends beyond the screen length.
" set wrap
" " Vim's auto indentation feature does not work properly with text copied
" from outside of Vim. Press the <F2> key to toggle paste mode on/off.
" nnoremap <F2> :set invpaste paste?<CR>
" imap <F2> <C-O>:set invpaste paste?<CR>
" set pastetoggle=<F2>
"
" " Uncomment below to set the max textwidth. Use a value corresponding to the
" width of your screen.
" " set textwidth=79
" set formatoptions=tcqrn1
" set tabstop=2
" set shiftwidth=2
" set softtabstop=2
" set expandtab
" set noshiftround
"
" " Display 5 lines above/below the cursor when scrolling with a mouse.
" set scrolloff=5
" " Fixes common backspace problems
" set backspace=indent,eol,start
"
" " Speed up scrolling in Vim
" set ttyfast
"
" " Status bar
" set laststatus=2
"
" " Display options
" set showmode
" set showcmd
"
" " Highlight matching pairs of brackets. Use the '%' character to jump
" between them.
" set matchpairs+=<:>
"
" " Display different types of white spaces.
" set list
" set listchars=tab:›\ ,trail:•,extends:#,nbsp:.
"
" " Show line numbers
" set number
"
" " Set status line display
" set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\
" [BUFFER=%n]\ %{strftime('%c')}
"
" " Encoding
" set encoding=utf-8
"
" " Highlight matching search patterns
" set hlsearch
" " Enable incremental search
" set incsearch
" " Include matching uppercase words with lowercase search term
" set ignorecase
" " Include only uppercase words with uppercase search term
" set smartcase
"
