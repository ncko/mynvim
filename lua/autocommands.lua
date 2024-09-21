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
    local filename = vim.fn.expand '%'
    print(string.format('Ready to run %s', filename))
    if vim.bo.filetype == 'lua' then
      vim.keymap.set('n', '<leader>cr', string.format(':luafile %s<CR>', filename), { desc = '[C]ode [R]un' })
    elseif vim.tbl_contains({ 'sh', 'bash', 'zsh' }, vim.bo.filetype) then
      vim.keymap.set('n', '<leader>cr', string.format(':! %s<CR>', filename), { desc = '[C]ode [R]un' })
    end
  end,
})

vim.api.nvim_create_autocmd('BufLeave', {
  desc = 'Remove keymap for running the current file when leaving the buffer',
  group = vim.api.nvim_create_augroup('ncko-run-keymap', { clear = false }),
  callback = function()
    if vim.tbl_contains({ 'lua', 'sh', 'bash', 'zsh' }, vim.bo.filetype) then
      vim.keymap.del('n', '<leader>cr')
    end
  end,
})
