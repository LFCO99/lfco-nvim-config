require("lfco")
require("config.lazy")
-- So far, ensure you have installed the following languages
-- for this config to work properly:
-- - Python3
-- - Elixir, and required dependencies for Phoenix.
-- >>> DON'T FORGET TO INSTALL ASDF ERLANG, ELIXIR
-- - Java
-- IMPORTANT! For the ELIXIR LSP to work .

-- LSP set ups:
-- Lua-Language-server:
local lua_ls_config = require("lsp.lua_ls")
vim.lsp.config("lua_ls", lua_ls_config)
vim.lsp.enable("lua_ls")

-- Set the colorscheme for NVIM
vim.cmd("colorscheme tokyonight-night")

-- Some general preferences:
vim.opt.guicursor = ""
vim.opt.guicursor = "a:blinkon0"
vim.api.nvim_set_hl(0, "LineNr", { fg = "#3cb371" })
vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#615f50" })
vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#615f50" })
