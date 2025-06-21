return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"mason-org/mason.nvim", -- Updated to your Mason fork
		"mason-org/mason-lspconfig.nvim",
	},
	config = function()
		-- Diagnostics configuration
		vim.diagnostic.config({
			underline = true,
			update_in_insert = false,
			virtual_text = {
				spacing = 4,
				source = "if_many",
				prefix = "●",
			},
			severity_sort = true,
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = "✖",
					[vim.diagnostic.severity.WARN] = "▲",
					[vim.diagnostic.severity.HINT] = "⚑",
					[vim.diagnostic.severity.INFO] = "ℹ",
				},
			},
		})

		-- Capabilities for completion (if using cmp or blink)
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
		local has_blink, blink = pcall(require, "blink.cmp")
		if has_cmp then
			capabilities = vim.tbl_deep_extend("force", capabilities, cmp_nvim_lsp.default_capabilities())
		end
		if has_blink then
			capabilities = vim.tbl_deep_extend("force", capabilities, blink.get_lsp_capabilities())
		end

		-- Server setup
		local lspconfig = require("lspconfig")
		local servers = {
			pyright = {
				settings = {
					python = {
						analysis = {
							autoSearchPaths = true,
							useLibraryCodeForTypes = true,
						},
					},
				},
			},
			ts_ls = {},
			html = {},
			cssls = {},
			emmet_language_server = {},
			elixirls = {
				settings = {
					elixirLS = {
						dialyzerEnabled = true, --Enable Dialyzer for type checking
						fetchDeps = true, --Auto-fetch Mix dependencies
						suggestSpecs = true, -- Suggest @spec annotations
						trace = { server = "verbose" }, -- Helpful for debugging LSP issues
					},
				},
			},
		}

		-- Mason-lspconfig setup
		local mason_lspconfig = require("mason-lspconfig")
		local ensure_installed = { "pyright", "lua_ls", "html", "cssls", "ts_ls", "emmet_language_server", "elixirls" }
		mason_lspconfig.setup({
			automatic_enable = true,
			ensure_installed = ensure_installed,
			handlers = {
				function(server_name)
					local server_opts = servers[server_name] or {}
					server_opts.capabilities =
						vim.tbl_deep_extend("force", {}, capabilities, server_opts.capabilities or {})
					lspconfig[server_name].setup(server_opts)
				end,
			},
		})
	end,
}
