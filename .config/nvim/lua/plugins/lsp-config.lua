return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = { "lua_ls", "tsserver", "clangd", "rust_analyzer" } -- Add any here to the servers table below to use
            })
        end
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require('lspconfig')

            -- General lsp setup. Be sure to add lsp server names to the servers table as they are installed. And they may be added to it without first being installed without errors or warnings.
            -- Don't add any servers that are manually setup (e.g. if different settings are desired) or it will get overwritten and setup again.
            -- This uses a loop to call 'setup' on every item in servers.
            -- Lua note: we might think to use the dot operator style of `lspconfig.lsp.setup({}), but this is pretty much impossible. To do this we'd make the command into a string and then use `loadstring(string)()`, which is a deprecated function. Best to use the strings as index.as below.
            local servers = { "lua_ls", "tsserver", "clangd", "rust_analyzer" }

            -- This capabilities variable is from hrsh7th/cmp-nvim-lsp for completions from lsp's (see nvim-cmp.lua).
            -- It gets assigned in the setup function below. The next comment is from hrsh7th/cmp-nvim-lsp.
            -- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
            local capabilities = require('cmp_nvim_lsp').default_capabilities()


            -- Most of the keybindings here and this on_attach function comes from the minimal config
            -- It is linked from the main README.md and is here: https://github.com/neovim/nvim-lspconfig/blob/master/test/minimal_init.lua
            local on_attach = function(_, bufnr)
                local function buf_set_option(...)
                  vim.api.nvim_buf_set_option(bufnr, ...)
                end

                buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

                -- Mappings.
                local opts = { buffer = bufnr, noremap = true, silent = true }
                vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
                vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
                vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
                vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
                vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
                vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
                vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
                vim.keymap.set('n', '<space>wl', function()
                    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                end, opts)
                vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
                vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
                vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
                vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
                vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
                vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
                vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

                vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)

                -- Show line diagnostics automatically in hover window
                -- from https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization
                vim.api.nvim_create_autocmd("CursorHold", {
                    buffer = bufnr,
                    callback = function()
                        local opts = {
                            focusable = false,
                            close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
                            border = 'rounded',
                            source = 'always',
                            prefix = ' ',
                            scope = 'cursor',
                        }
                        vim.diagnostic.open_float(nil, opts)
                    end
                })

            end

            for _, lsp in pairs(servers) do
                lspconfig[lsp].setup({
                    capabilities = capabilities,
                    on_attach = on_attach,
                })
                vim.lsp.inlay_hint.enable()
            end
        end
    }
}
