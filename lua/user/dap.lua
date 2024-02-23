local status_ok, dap = pcall(require, "dap")
if not status_ok then
	return
end

local status_ok, dapui = pcall(require, "dapui")
if not status_ok then
	return
end

-- dap-ui setup
dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end


vim.fn.sign_define('DapBreakpoint',{ text ='🟥', texthl ='', linehl ='', numhl =''})
vim.fn.sign_define('DapStopped',{ text ='▶️', texthl ='', linehl ='', numhl =''})

vim.keymap.set('n', '<F5>', dap.continue)
vim.keymap.set('n', '<F10>', dap.step_over)
vim.keymap.set('n', '<F11>', dap.step_into)
vim.keymap.set('n', '<F12>', dap.step_out)
vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint)

local status_ok, dap_python = pcall(require, "dap-python")
if not status_ok then
	return
end
dap_python.setup("~/.pyenv/version/debugpy/bin/python")
