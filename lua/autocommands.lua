------------
-- Basic Autocommands
-- `:help lua-guide-autocommands`
------------

-- highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('ncko-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd('BufEnter', {
  desc = 'Provide a keymap to run the current file when entering a buffer',
  group = vim.api.nvim_create_augroup('ncko-run-keymap', { clear = true }),
  callback = function()
    if vim.bo.filetype == 'lua' then
      vim.keymap.set('n', '<leader>cr', ':luafile %<CR>', { desc = '[C]ode [R]un' })
    end
  end,
})

vim.api.nvim_create_autocmd('BufLeave', {
  desc = 'Remove keyjmap for running the current file when leaving the buffer',
  group = vim.api.nvim_create_augroup('ncko-run-keymap', { clear = false }),
  callback = function()
    if vim.bo.filetype == 'lua' then
      vim.keymap.del('n', '<leader>cr')
    end
  end,
})
