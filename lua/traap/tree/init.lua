-- {{{ Alias to vim APis.

local g = vim.g
local api = vim.api
local map = require('traap.utility.helpers').keymap

-- ------------------------------------------------------------------------- }}}
-- {{{ list of keys mapped

map('n', '<c-n>',       '<cmd>NvimTreeToggle<cr>')
map('n', '<leader>nr',  '<cmd>NvimTreeRefresh<cr>')
map('n', '<leader>nf',  '<cmd>NvimTreeFindFile<cr>')

local callback = require'nvim-tree.config'.nvim_tree_callback

local keymap_list = {
  { key = {"<CR>", "o", "<2-LeftMouse>"}, cb = callback("edit") },
  { key = {"<2-RightMouse>", "<C-}>"},    cb = callback("cd") },
  { key = "<C-v>",                        cb = callback("vsplit") },
  { key = "<C-x>",                        cb = callback("split") },
  { key = "<C-t>",                        cb = callback("tabnew") },
  { key = "<",                            cb = callback("prev_sibling") },
  { key = ">",                            cb = callback("next_sibling") },
  { key = "P",                            cb = callback("parent_node") },
  { key = "<BS>",                         cb = callback("close_node") },
  { key = "<S-CR>",                       cb = callback("close_node") },
  { key = "<Tab>",                        cb = callback("preview") },
  { key = "K",                            cb = callback("first_sibling") },
  { key = "J",                            cb = callback("last_sibling") },
  { key = "I",                            cb = callback("toggle_ignored") },
  { key = "H",                            cb = callback("toggle_dotfiles") },
  { key = "R",                            cb = callback("refresh") },
  { key = "a",                            cb = callback("create") },
  { key = "d",                            cb = callback("remove") },
  { key = "r",                            cb = callback("rename") },
  { key = "<C->",                         cb = callback("full_rename") },
  { key = "x",                            cb = callback("cut") },
  { key = "c",                            cb = callback("copy") },
  { key = "p",                            cb = callback("paste") },
  { key = "y",                            cb = callback("copy_name") },
  { key = "Y",                            cb = callback("copy_path") },
  { key = "gy",                           cb = callback("copy_absolute_path") },
  { key = "[c",                           cb = callback("prev_git_item") },
  { key = "]c",                           cb = callback("next_git_item") },
  { key = "-",                            cb = callback("dir_up") },
  { key = "q",                            cb = callback("close") },
  { key = "g?",                           cb = callback("toggle_help") },
  { mode = "n", key = "<C-t>", cb = "<cmd>lua require'telescope.builtin'.live_grep()<cr>" }
}

-- ------------------------------------------------------------------------- }}}
-- {{{ nvim-config : nvim-tree.lua
--     https://github.com/kyazdani42/nvim-config

g.nvim_tree_show_icons = {
  git = 1,
  folders = 1,
  files = 1,
  folder_arrows = 1
}
g.nvim_tree_group_empty = 1
g.nvim_tree_window_picker_exclude = {
  filetype = {
    "packer",
    "qf",
    "Trouble"
  }
}

g.nvim_tree_icons = {
  default = '',
  git= {
    unstaged = "✗",
    staged = "✓",
    unmerged = "",
    renamed = "➜",
    untracked = "★"
  },
  folder = {
    default = "",
    open = ""
  }
}

require'nvim-tree'.setup {

  disable_netrw       = true,
  hijack_netrw        = true,
  open_on_setup       = false,
  open_on_tab         = false,
  auto_close          = false,
  hijack_cursor       = true,
  update_cwd          = true,
  update_focused_file = {
    enable = true,
    update_cwd = true,
    ignore_list = { 'fzf' }
  },
  ignore_ft_on_setup = {'.git', 'node_modules', 'dist'},
  system_open = {
    cmd  = nil,
    args = {}
  },
  git = {
    enable = true,
    height = true,
    timeout = 300,
  },
  view = {
    width = 27,
    side = 'right',
    auto_resize = true,
    mappings = {
      custom_only = false,
      list = keymap_list
    }
  }
}

-- ------------------------------------------------------------------------- }}}