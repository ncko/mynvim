-- This plugin matches on text that starts with one of your defined keywords followed by a colon:
-- PERF: performance note
-- TODO: do this thing
-- FIX: this should be fixed
-- NOTE: This is a note
-- HACK: weird code warning
-- WARNING: weird code warning

return {
  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false },
  },
}
