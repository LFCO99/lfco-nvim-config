require("lfco")
require("config.lazy")

-- So far, ensure you have installed the following languages
-- for this config to work properly:
-- - Python3
-- - Elixir, and required dependencies for Phoenix.
-- >>> DON'T FORGET TO INSTALL ASDF ERLANG, ELIXIR
-- - Java

-- IMPORTANT! For the ELIXIR LSP to work .
-- Used to set up the correct path for python3 across diverse os (currently MacOS and Linux)
local os_config = {
	macunix = { python3_host_prog = "/Library/Frameworks/Python.framework/Versions/3.13/bin//python3" },
	unix = { python3_host_prog = "/usr/local/bin/python3.13" },
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
