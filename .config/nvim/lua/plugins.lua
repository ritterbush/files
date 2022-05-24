-- Packer Plugin Manager
--https://github.com/wbthomason/packer.nvim

--[[
-- You must run this or `PackerSync` whenever you make changes to your plugin configuration
-- Regenerate compiled loader file
:PackerCompile

-- Remove any disabled or unused plugins
:PackerClean

-- Clean, then install missing plugins
:PackerInstall

-- Clean, then update and install plugins
:PackerUpdate

-- Perform `PackerUpdate` and then `PackerCompile`
:PackerSync

-- Loads opt plugin immediately
:PackerLoad completion-nvim ale
]]--

-- Bootstrap Packer--automatically install and setup packer.nvim
--on any machine you clone your configuration to.
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

--[[ Placed below
return require('packer').startup(function(use)
  -- My plugins here
  -- use 'foo1/bar1.nvim'
  -- use 'foo2/bar2.nvim'

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
--]]

-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
--vim.cmd [[packadd packer.nvim]]

-- Fix for spurious linter error for use being undefined
--packer.startup(function(use)
--...your config...
--end)


return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  use 'dracula/vim'

  use {
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate'
   }

  -- lsp
  use {
    'williamboman/nvim-lsp-installer',
    'neovim/nvim-lspconfig',
  }


--[[ -- The below is another default lsp-installer (with lspconfig) config possibility, but lspconfig is already setup in lsp.lua
  -- lsp
  use {
    'williamboman/nvim-lsp-installer',
    {
        'neovim/nvim-lspconfig',
        config = function()
            require("nvim-lsp-installer").setup {}
            local lspconfig = require("lspconfig")
            lspconfig.sumneko_lua.setup {}
            --lspconfig.pyright.setup {}
        end
    }
  }

--]]

    -- nvim-cmp
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/nvim-cmp'

    -- Use a snippet (config will need to get updated)

    -- vsnip
    use 'hrsh7th/cmp-vsnip'
    use 'hrsh7th/vim-vsnip'

    -- telescope
   
    -- telescope sorter
    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    
    -- telescope
    use {
      'nvim-telescope/telescope.nvim',
      requires = { {'nvim-lua/plenary.nvim'} }
    }


--[[
    -- dap debugger tool
    use 'mfussenegger/nvim-dap'
    ]]--



  -- Simple plugins can be specified as strings
  --use '9mm/vim-closer'

  -- Lazy loading:
  -- Load on specific commands
  --use {'tpope/vim-dispatch', opt = true, cmd = {'Dispatch', 'Make', 'Focus', 'Start'}}

  -- Load on an autocommand event
  --use {'andymass/vim-matchup', event = 'VimEnter'}

  -- Load on a combination of conditions: specific filetypes or commands
  -- Also run code after load (see the "config" key)
  --use {
  --  'w0rp/ale',
  --  ft = {'sh', 'zsh', 'bash', 'c', 'cpp', 'cmake', 'html', 'markdown', 'racket', 'vim', 'tex'},
  --  cmd = 'ALEEnable',
  --  config = 'vim.cmd[[ALEEnable]]'
  --}

  --[[

  -- Plugins can have dependencies on other plugins
  use {
    'haorenW1025/completion-nvim',
    opt = true,
    requires = {{'hrsh7th/vim-vsnip', opt = true}, {'hrsh7th/vim-vsnip-integ', opt = true}}
  }

  -- Plugins can also depend on rocks from luarocks.org:
  use {
    'my/supercoolplugin',
    rocks = {'lpeg', {'lua-cjson', version = '2.1.0'}}
  }

  -- You can specify rocks in isolation
  use_rocks 'penlight'
  use_rocks {'lua-resty-http', 'lpeg'}

  -- Local plugins can be included
  use '~/projects/personal/hover.nvim'

  -- Plugins can have post-install/update hooks
  use {'iamcco/markdown-preview.nvim', run = 'cd app && yarn install', cmd = 'MarkdownPreview'}

  -- Post-install/update hook with neovim command
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

  -- Post-install/update hook with call of vimscript function with argument
  use { 'glacambre/firenvim', run = function() vim.fn['firenvim#install'](0) end }

  -- Use specific branch, dependency and run lua file after load
  use {
    'glepnir/galaxyline.nvim', branch = 'main', config = function() require'statusline' end,
    requires = {'kyazdani42/nvim-web-devicons'}
  }

  -- Use dependency and run lua function after load
  use {
    'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' },
    config = function() require('gitsigns').setup() end
  }

  -- You can specify multiple plugins in a single call
  use {'tjdevries/colorbuddy.vim', {'nvim-treesitter/nvim-treesitter', opt = true}}

  -- You can alias plugin names
  use {'dracula/vim', as = 'dracula'}

  ]]--
  if packer_bootstrap then
    require('packer').sync()
  end

end)

-- Automatically run :PackerCompile whenever plugins.lua is updated
--vim.cmd([[
--  augroup packer_user_config
--    autocmd!
--    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
--  augroup end
--]])

