return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
	},
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		vim.diagnostic.config({
			underline = true,
			update_in_insert = false,
			virtual_text = { spacing = 4, source = "if_many", prefix = "●" }, -- Fixed typo
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

		local lspconfig = require("lspconfig")
		local on_attach = function(_, bufnr)
			local attach_opts = { silent = true, buffer = bufnr }
			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, attach_opts)
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, attach_opts)
			vim.keymap.set("n", "K", vim.lsp.buf.hover, attach_opts)
			vim.keymap.set("n", "gi", vim.lsp.buf.implementation, attach_opts)
			vim.keymap.set("n", "<C-s>", vim.lsp.buf.signature_help, attach_opts)
			vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, attach_opts)
			vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, attach_opts)
			vim.keymap.set("n", "<leader>wl", function()
				print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
			end, attach_opts)
			vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, attach_opts)
			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, attach_opts)
			vim.keymap.set("n", "so", require("telescope.builtin").lsp_references, attach_opts)
		end

		-- nvim-cmp supports additional completion capabilities
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

		-- Enable the following language servers / little to none specific configuration
		local servers = {}
		for _, lsp in ipairs(servers) do
			lspconfig[lsp].setup({
				on_attach = on_attach,
				capabilities = capabilities,
			})
		end

		-- Explicit Lua setup
		vim.lsp.config("lua_ls", {
			cmd = { "lua-language-server" },
			filetypes = { "lua" },
			root_markers = { ".luarc.json", ".luarc.jsonc", ".git" },
			on_attach = on_attach,
			capabilities = capabilities,
			settings = {
				Lua = {
					runtime = {
						version = "LuaJIT",
					},
					diagnostics = {
						globals = { "vim" },
					},
					workspace = { library = vim.api.nvim_get_runtime_file("", true) },
				},
			},
		})
		vim.lsp.enable("lua_ls")
	end,
}
