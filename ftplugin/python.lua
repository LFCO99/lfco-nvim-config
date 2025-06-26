-- Python-specific settings
vim.opt_local.formatoptions = "jcroql"
vim.opt_local.textwidth = 88 -- Matches Black
vim.opt_local.tabstop = 4
vim.opt_local.softtabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.expandtab = true
vim.opt_local.smartindent = true

--Buffer-local keymaps for Python/Django
vim.keymap.set("n", "<leader>r", ":RunCode<CR>")
