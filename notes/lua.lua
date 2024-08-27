-- Neovim API composed of 3 layers
-- 1. Vim API (accessed through vim.cmd() and vim.fn)
-- 	- `:h lua-guide-vimscript`
-- 	- `:h Ex-commands`
-- 	- `:h builtin-functions`
-- 	- `:h user-function` writtenin Vimscript
-- 2. Nvim API (accessed through vim.api) - Written in C for use in remote plugins and GUIs
-- 	- `:h api`
-- 	- `:h vim.api`
-- 3. Lua API (everything else `vim.*`)
-- 	- `:h lua-stdlib`

-----------
--- Loading modules
-----------

local ok, fakemod = pcall(require, 'fakemodule') -- this module doesn't exist. pcall protects use from an error
if not ok then
  print "fakemod doesn't exist"
else
  fakemod.dostuff()
end

-- require caches the loaded manual so requiring it again will not execute the module
-- to rerun the file, remove it from the cache:
package.loaded['fakemodule'] = nil
-- now require('fakemodule') again and it will run again

-----------------------------------
--- Vim Commands
-----------------------------------

-- run vim commands with `vim.cmd()`
vim.cmd 'colorscheme habamax'
vim.cmd 'colorscheme tokyonight-night'

-- lua has literal strings `:h lua-literal` which are useful for
-- passing multiple lines to a single call to vim.cmd()
vim.cmd [[
  highlight Error guibg=red
  highlight link Warning Error
]]

-- If building up the command programmatically, this is useful:
-- these are the same as above
vim.cmd.highlight { 'Error', 'guibg=red' }
vim.cmd.highlight { 'link', 'Warning', 'Error' }

-----------------------------------
--- Vimscript Functions
-----------------------------------

-- To call vimscript functions, use `vim.fn`
-- This works for builtin-functions and user-functions `:h builtin-functions` and `:h user-functions`
-- print(vim.fn.printf('Hello from %s', 'Lua'))
-- local reversed_list = vim.fn.reverse { 'a', 'b', 'c' }
-- vim.print(reversed_list)
--
-- local function print_stdout(chan_id, data, name)
--   print(data[1] .. chan_id .. name)
-- end
--
-- vim.fn.jobstart('ls', { on_stdout = print_stdout })
--
-- -- it is better to use `vim.system` instead of `vim.fn.jobstart`
-- local on_exit = function(obj)
--   print(obj.code)
--   print(obj.signal)
--   print(obj.stdout)
--   print(obj.stderr)
-- end
--
-- vim.system({ 'ls', '-1' }, { text = true }, on_exit) -- async
-- -- local obj = vim.fn.system({ 'ls', '-1' }, {}, on_exit):wait() -- sync
-- -- print(vim.inspect(obj))

local stdin = vim.uv.new_pipe()
local stdout = vim.uv.new_pipe()
local stderr = vim.uv.new_pipe()

local handle, pid = vim.uv.spawn('cat', {
  stdio = { stdin, stdout, stderr },
}, function(code, signal)
  print('exit code', code)
  print('exit signal', signal)
end)

print('process opened', handle, pid)

-----------------------------------
--- variables `:h variable-scope` `:h lua-guide-variables`
--- - vim.g global variables
--- - vim.b variables for the current buffer
--- - vim.w variables for the current window
--- - vim.t variables for the current tabpage
--- - vim.v predefined Vim variables
--- - vim.env environment variables defined in the editor session
-----------------------------------

-- define custom global variables
vim.g.some_global_variable = {
  key1 = 'value',
  key2 = 300,
}

-- target specific buffers via number, windows via window-ID (`:h window-ID) or tab pages by indexing the wrappers
vim.b[2].myvar = 1
local winid = vim.fn.win_getid()
vim.w[winid].myothervar = true

-- Can't direclty change fields of array variables. This won't work
vim.g.some_global_variable.key2 = 400
vim.print(vim.g.some_global_variable) -- no change

-- Instead you have to create an intermediate table:
local tmp_table = vim.g.some_global_variable
tmp_table.key2 = 400
vim.g.some_global_variable = tmp_table
vim.print(vim.g.some_global_variable) -- it worked!

-- to delete, set to nil
vim.g.some_global_variable = nil

---------------------
---
vim.api.nvim_create_user_command('Test', function(opts)
  print(string.upper(opts.fargs[1]))
end, { nargs = 1 })
