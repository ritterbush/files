return {
    "nvim-treesitter/nvim-treesitter", 
    build = ":TSUpdate",
    config = function()
        local configs = require("nvim-treesitter.configs")
        configs.setup({
          auto_install = true,
          --ensure_installed = "all", --use if auto_install is failing to work
          sync_install = false,
          highlight = { enable = true },
          indent = { enable = true },
        })
    end
}
