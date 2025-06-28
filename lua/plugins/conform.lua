return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" }, -- Load before saving files
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				-- Nvim config and Lua
				lua = { "stylua" }, -- format with stylua

				-- Python related
				python = {
					"ruff_fix", -- To fix auto-fixable lint errors.
					"ruff_format", -- To run the Ruff formatter.
					"ruff_organize_imports", -- To organize the imports
				},

				--Django Web App Dev related
				htmldjango = { "djlint" },
				html = { "djlint" },
				css = { "prettier" },
				javascript = { "prettier" },
				-- java = { "google-java-format" },
				-- elixir = { "mix_format" },
			},
			-- 	mix_format = {
			-- 		command = "mix",
			-- 		args = { "format", "-" },
			-- 		stdin = true,
			-- 	},
			-- },
			format_on_save = {
				timeout_ms = 500, --  max formatting time
				lsp_fallback = true, -- use lsp if formatter fails
			},
		})
	end,
}
