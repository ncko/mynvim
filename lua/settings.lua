------------
-- Settings
-- experiment and explore with :options
------------

vim.g.have_nerd_font = true

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = 'a'
vim.opt.showmode = false

-- sync clipboard. Schedule after UiEnter because it can increase
-- startup time. `:help 'clipboard'`
vim.schedule(function()
	vim.opt.clipboard = 'unnamedplus'
end)

vim.opt.breakindent = true
vim.opt.undofile = true
-- case insensitive searching unles \C or one or more capital letters
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.signcolumn = 'yes'
vim.opt.updatetime = 250

-- displays which-key popup sooner
vim.opt.timeoutlen = 300

-- open new splits right and down
vim.opt.splitright = true
vim.opt.splitbelow = true

-- display whitespace chars with certain symbols
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- preview substitutions live as you type
vim.opt.inccommand = 'split'

vim.opt.cursorline = true

vim.opt.scrolloff = 5

