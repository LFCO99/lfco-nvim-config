vim.keymap.set("n", "<leader>F", function()
	require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Format Buffer", noremap = true, silent = true })
