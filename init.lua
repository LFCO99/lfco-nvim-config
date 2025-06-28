require("lfco")
require("config.lazy")
-- So far, ensure you have installed the following languages
-- for this config to work properly:
-- - Python3
-- - Elixir, and required dependencies for Phoenix.
-- >>> DON'T FORGET TO INSTALL ASDF ERLANG, ELIXIR
-- - Java

-- For python projects,
-- Install Django and pynvim, the nvim config will take care of the rest.

-- IMPORTANT! For the ELIXIR LSP to work .
vim.o.completeopt = "menuone,noselect"
-- Set the colorscheme for NVIM
vim.cmd("colorscheme tokyonight-night")
-- Some general preferences:
vim.opt.guicursor = ""
vim.opt.guicursor = "a:blinkon0"
vim.api.nvim_set_hl(0, "LineNr", { fg = "#3cb371" })
vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#615f50" })
vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#615f50" })

-- Django File Detection
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = {
		"*/templates/*.html", -- Standard Django template path
		"*/templates/*/*.html", -- App-specific templates (e.g., myapp/templates/myapp/)
	},
	callback = function()
		vim.bo.filetype = "htmldjango"
	end,
})
