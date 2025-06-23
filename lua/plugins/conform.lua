return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" }, -- Load before saving files
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				-- python = { "isort", "black", "ruff" }, -- sort imports, then format with black.
				lua = { "stylua" }, -- format with stylua
				-- java = { "google-java-format" },
				-- html = { "prettier" },
				-- css = { "prettier" },
				-- javascript = { "prettier" },
				-- elixir = { "mix_format" },
			},
			-- formatters = {
			-- 	isort = {
			-- 		command = "isort",
			-- 		args = { "--profile", "black", "--line-length", "88", "-" },
			-- 		stdin = true,
			-- 		-- use virtualenv's via VIRTUAL_ENV
			-- 		env = {
			-- 			VIRTUAL_ENV = function()
			-- 				if vim.g.python3_host_prog then
			-- 					return vim.fn.fnamemodify(vim.g.python3_host_prog, ":h:h")
			-- 				end
			-- 				return nil
			-- 			end,
			-- 		},
			-- 	},
			-- 	black = {
			-- 		command = "black",
			-- 		args = { "--line-length", "88", "--fast", "-" },
			-- 		stdin = true,
			-- 		-- use virtualenv's via VIRTUAL_ENV
			-- 		env = {
			-- 			VIRTUAL_ENV = function()
			-- 				if vim.g.python3_host_prog then
			-- 					return vim.fn.fnamemodify(vim.g.python3_host_prog, ":h:h")
			-- 				end
			-- 				return nil
			-- 			end,
			-- 		},
			-- 	},
			-- 	mix_format = {
			-- 		command = "mix",
			-- 		args = { "format", "-" },
			-- 		stdin = true,
			-- 	},
			-- 	ruff = {
			-- 		command = "ruff",
			-- 		args = { "format", "--line-length", "88", "-" },
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
