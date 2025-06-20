require("lfco")
require("config.lazy")

-- -- Sets the version of Python to work with. According to OS
-- local function set_python_host_prog()
-- 	if vim.fn.has("macunix") == 1 then
-- 		vim.g.python3_host_prog = "/Library/Frameworks/Python.framework/Versions/3.13/bin//python3"
-- 	elseif vim.fn.has("unix") == 1 then
-- 		vim.g.python3_host_prog = "/usr/local/bin/python3"
-- 	else
-- 		vim.g.python3_host_prog = "python3"
-- 	end
--
-- 	if vim.fn.executable(vim.g.python3_host_prog) == 0 then
-- 		print("Warning: python3_host_prog not found at " .. vim.g.python3_host_prog)
-- 	end
-- end
--
-- set_python_host_prog()

-- Other way:
local os_config = {
	macunix = { python3_host_prog = "/Library/Frameworks/Python.framework/Versions/3.13/bin//python3" },
	unix = { python3_host_prog = "/usr/local/bin/python3" },
}

for os, config in pairs(os_config) do
	if vim.fn.has(os) == 1 then
		vim.g.python3_host_prog = config.python3_host_prog
		break
	end
end

-- Set the colorscheme
vim.cmd("colorscheme tokyonight-night")

vim.opt.guicursor = ""
vim.opt.guicursor = "a:blinkon0"
vim.api.nvim_set_hl(0, "LineNr", { fg = "#3cb371" })
vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#615f50" })
vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#615f50" })
