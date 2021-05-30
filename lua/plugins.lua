return require('packer').startup(function()

  -- Packer can manage itself as an optional plugin
  use {'wbthomason/packer.nvim', opt = true}

  -- Color scheme
  use { 'chriskempson/base16-vim' }
  use { 'norcalli/nvim-colorizer.lua' }

  -- Fuzzy finder
  use {
       'nvim-telescope/telescope.nvim',
       requires = {
				 	{'nvim-lua/popup.nvim' },
					{'nvim-lua/plenary.nvim' },
					{'nvim-telescope/telescope-media-files.nvim' }
			 }
   }

  -- LSP and completion
  use { 'neovim/nvim-lspconfig' }
  use { 'nvim-lua/completion-nvim' }

  -- Lua development
  use { 'tjdevries/nlua.nvim' }

  -- neovim without Tpope?  Now Way!!!
  use { 'tpope/vim-commentary' }
  use { 'tpope/vim-dispatch' }
  use { 'tpope/vim-endwise' }
  use { 'tpope/vim-fugitive' }
  use { 'tpope/vim-surround' }
  use { 'tpope/vim-unimpaired' }

	-- File manager
  use { 'kyazdani42/nvim-tree.lua' }
  use { 'kyazdani42/nvim-web-devicons' }
  use { 'ryanoasis/vim-devicons' }

  -- RipGrep
  use { 'jremmen/vim-ripgrep' }

  -- Easyaling
  use { 'junegunn/vim-easy-align' }

  -- Load personalizations. 
  local configs = {
    'settings',
    'keymappings',
    'config.colorscheme',
    'config.completions',
    'config.fugitive',
    'config.nvim-tree'
  }
  for _, cfg in ipairs(configs) do
    require(cfg)
  end

end)
