------
-- Be careful not to add things unless you are confident you'll use them
------

-- TODO: document requirements, add automation
-- FIX: icons, nerd font stuff
-- TODO: setup harpoon
-- TODO: read :h lua-guide
-- TODO: read :h lua
-- TODO: read :h treesitter
-- TODO: read :h nvim-treesitter
-- TODO: setup snippets
--
-- After installing, run `:checkhealth`
--    - luarocks recommended `brew install luarocks`
--    - Requires Lua 5.1 - recommend using Lua Version Manager https://github.com/DhavalKapil/luaver

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require 'settings'
require 'keymaps'
require 'autocommands'

----------
-- Install lazy.nvim
-- :help lazy.nvim.txt
----------
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end
vim.opt.rtp:prepend(lazypath)

----------
-- Setup plugins
----------
require('lazy').setup {
  'tpope/vim-sleuth',
  require 'plugins.gitsigns',
  require 'plugins.which-key',
  require 'plugins.telescope',
  require 'plugins.lazydev',
  { 'Bilal2453/luvit-meta', lazy = true },
  require 'plugins.lspconfig',
  require 'plugins.conform',
  require 'plugins.completion',
  require 'plugins.colorscheme',
  require 'plugins.todo-comments',
  require 'plugins.treesitter',
}
