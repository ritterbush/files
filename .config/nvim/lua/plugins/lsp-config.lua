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
                ensure_installed = { "lua_ls", "tsserver" } -- Add any here to the servers table below to use
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
            local servers = { "lua_ls", "tsserver" }

            -- This capabilities variable is from hrsh7th/cmp-nvim-lsp for completions from lsp's (see completions.lua).
            -- It gets assigned in the setup function below. The next comment is from hrsh7th/cmp-nvim-lsp.
            -- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
            local capabilities = require('cmp_nvim_lsp').default_capabilities()


            for _, lsp in pairs(servers) do
                lspconfig[lsp].setup({ capabilities = capabilities, })
            end

            vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, {})

            -- LATER!
            -- map buffer local keybindings when the language server attaches
        end
    }
}
