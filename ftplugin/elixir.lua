-- Elixir-specific settings
vim.opt_local.tabstop = 2
vim.opt_local.shiftwidth = 2
vim.opt_local.expandtab = true

-- Optional: Add keymaps for Mix tasks
vim.keymap.set("n", "<leader>mt", ":terminal mix test<CR>", { buffer = true, desc = "Run Mix Test" })
vim.keymap.set("n", "<leader>mf", ":terminal mix format<CR>", { buffer = true, desc = "Run Mix Format" })
