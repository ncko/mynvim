return {
  {
    'folke/tokyonight.nvim',
    priority = 1000, -- Load this before all other plugins
    lazy = false,
    init = function()
      vim.cmd.colorscheme 'tokyonight-night'
      -- Below `vim.cmd` runs a git commad, in this case `hi`. `:h vim.cmd()` and `:h hi`
      -- Configure custom highlights this way
      -- vim.cmd.hi 'Comment gui=none'
    end,
  },
}
