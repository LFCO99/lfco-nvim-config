return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" }, -- Load before saving files
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				python = { "isort", "black" }, -- sort imports, then format with black.
				lua = { "stylua" }, -- format with stylua
				java = { "google-java-format" },
				html = { "prettier" },
				css = { "prettier" },
				javascript = { "prettier" },
				elixi = { "mix_format" },
			},
			formatters = {
				mix_format = {
					command = "mix",
					args = { "format", "-" },
					stdin = true,
				},
			},
			format_on_save = {
				timeout_ms = 500, --  Max formatting time
				lsp_fallback = true, -- Use LSP if formatter fails
			},
		})
	end,
}
