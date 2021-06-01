return require('packer').startup(
  function()

    -- Packer can manage itself as an optional plugin
    use {'wbthomason/packer.nvim', opt = true}

    -- Color scheme
    use 'chriskempson/base16-vim'
    use 'siduck76/nvim-base16.lua'

    -- Fuzzy finder
    use {
      'nvim-telescope/telescope.nvim',
      requires = {
        'nvim-lua/popup.nvim',
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope-media-files.nvim',
        'nvim-telescope/telescope-snippets.nvim',
        'norcalli/snippets.nvim'
      }
    }

    -- LSP and completion
    use 'neovim/nvim-lspconfig'
    use 'kabouzeid/nvim-lspinstall'
    use 'nvim-lua/completion-nvim'
    use 'hrsh7th/nvim-compe'
    use 'nvim-treesitter/nvim-treesitter'

    -- Lua development
    use { 'tjdevries/nlua.nvim' }

    -- neovim without Tpope?  No Way!!!
    use 'tpope/vim-commentary'
    use 'tpope/vim-dispatch'
    use 'tpope/vim-endwise'
    use 'tpope/vim-fugitive'
    use 'tpope/vim-surround'
    use 'tpope/vim-unimpaired'

    -- File manager
    use 'kyazdani42/nvim-tree.lua'
    use 'kyazdani42/nvim-web-devicons'
    use 'glepnir/galaxyline.nvim'

    -- LaTeX and Wiki
    use 'lervag/vimtex'
    use 'lervag/wiki-ft.vim'
    use 'lervag/wiki.vim'

    -- RipGrep
    use 'jremmen/vim-ripgrep'

    -- Easyaling
    use 'junegunn/vim-easy-align'

    -- Utility
    use 'sbdchd/neoformat'
    use 'tweekmonster/startuptime.vim'

  end,
  {
    display = {
      border = { '┌', '─', '┐', '│', '┘', '─', '└', '│' }
    }
  }
)
