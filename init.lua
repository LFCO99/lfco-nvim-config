require("lfco")
require("config.lazy")

-- Sets the version of Python to work with.
vim.g.python3_host_prog = "/usr/local/bin/python3"

-- Set the colorscheme
vim.cmd("colorscheme tokyonight-night")

vim.opt.guicursor = ""
vim.opt.guicursor = "a:blinkon0"
vim.api.nvim_set_hl(0, "LineNr", { fg = "#3cb371" })
vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#615f50" })
vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#615f50" })
