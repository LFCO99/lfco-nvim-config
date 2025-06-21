require("lfco")
require("config.lazy")

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
