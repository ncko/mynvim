local Job = require 'plenary.job'

Job:new({
  command = 'ls',
  -- cwd = '/bin',
  on_exit = function(j, return_value)
    -- print(j:result())
    print(vim.inspect(j:result()))
    -- print(return_value)
  end,
}):start()
