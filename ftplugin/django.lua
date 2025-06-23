vim.opt_local.filetype = "django"
vim.keymap.set("n", "<leader>dt", ":e templates/<CR>", { buffer = true, desc = "Open Django templates" })
