local has_remote, remote = pcall(require, 'sonicpi.remote')
if not has_remote then
  return
end

local map = vim.keymap.set
local opts = { noremap = true, silent = true, buffer = vim.api.nvim_get_current_buf() }

local function run_buffer()
  remote.run_buffer(vim.api.nvim_get_current_buf())
end

map('n', '<leader>s', function()
  remote.stop()
end, opts)

map('n', '<leader>r', function()
  run_buffer()
end, opts)

vim.api.nvim_buf_create_user_command(0, 'SonicPiStartDaemon', function()
  remote.startServer()
end, {})
vim.api.nvim_buf_create_user_command(0, 'SonicPiStopDaemon', function()
  remote.stopServer()
end, {})
vim.api.nvim_buf_create_user_command(0, 'SonicPiStop', function()
  remote.stop()
end, {})

vim.api.nvim_buf_create_user_command(0, 'SonicPiSendBuffer', run_buffer, {})
