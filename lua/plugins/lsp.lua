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
			vim.keymap.set("n", "<leader>ds", vim.diagnostic.open_float, attach_opts)
			vim.keymap.set("n", "so", require("telescope.builtin").lsp_references, attach_opts)
		end

		-- nvim-cmp supports additional completion capabilities
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

		-- Enable the following language servers / little to none specific configuration
		-- local servers = { "pyright", "ruff" }
		-- for _, lsp in ipairs(servers) do
		-- 	vim.lsp.config(lsp, {
		-- 		on_attach = on_attach,
		-- 		capabilities = capabilities,
		-- 	})
		-- end
		-- vim.lsp.enable(servers)

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

		local function set_python_path(path)
			local clients = vim.lsp.get_clients({
				bufnr = vim.api.nvim_get_current_buf(),
				name = "pyright",
			})
			for _, client in ipairs(clients) do
				if client.settings then
					client.settings.python = vim.tbl_deep_extend("force", client.settings.python, { pythonPath = path })
				else
					client.config.settings =
						vim.tbl_deep_extend("force", client.config.settings, { python = { pythonPath = path } })
				end
				client.notify("workspace/didChangeConfiguration", { settings = nil })
			end
		end

		vim.lsp.config("pyright", {
			cmd = { "pyright-langserver", "--stdio" },
			filetypes = { "python" },
			root_markers = {
				"pyproject.toml",
				"setup.py",
				"requirements.txt",
				"Pipfile",
				"pyrightconfig.json",
				".git",
			},
			settings = {
				python = {
					analysis = {
						autoSearchPaths = true,
						useLibraryCodeForTypes = true,
						diagnosticMode = "openFilesOnly",
					},
				},
			},
			on_attach = function(client, bufnr)
				vim.api.nvim_buf_create_user_command(bufnr, "LspPyrightOrganizeImports", function()
					client:exec_cmd({
						command = "pyright.organizeimports",
						arguments = { vim.uri_from_bufnr(bufnr) },
					})
				end, {
					desc = "Organize Imports",
				})
				vim.api.nvim_buf_create_user_command(bufnr, "LspPyrightSetPythonPath", set_python_path, {
					desc = "Reconfigure pyright with the provided python path",
					nargs = 1,
					complete = "file",
				})
			end,
		})
		vim.lsp.enable("pyright")

		-- Explicitly setup Ruff
		vim.lsp.config("ruff", {
			init_options = {
				settings = {
					cmd = { "ruff", "server" },
					filetypes = { "python" },
					root_markers = { "pyproject.toml", "ruff.toml", ".ruff.toml", ".git" },
				},
			},
		})
		vim.lsp.enable("ruff")
	end,
}
