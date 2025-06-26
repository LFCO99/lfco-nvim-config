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

		-- CMP handles the capabilities
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

		-- Default config for every LSP
		vim.lsp.config("*", {
			capabilities = capabilities,
			on_attach = on_attach,
		})

		-- Lua setup
		vim.lsp.config("lua_ls", {
			cmd = { "lua-language-server" },
			filetypes = { "lua" },
			root_markers = { ".luarc.json", ".luarc.jsonc", ".git" },
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

		-- Django root_markers:
		local djangoRootMarkers = { "pyproject.toml", ".git", "manage.py" }
		-- Pyright setup
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
			root_markers = djangoRootMarkers,
			settings = {
				pyright = {
					disableOrganizeImports = true,
				},
				python = {
					analysis = {
						ignore = { "*" },
						-- diagnosticMode = "workspace",
						-- typeCheckingMode = "basic",
						-- autoSearchPaths = "true",
						-- useLibraryCodeForTypes = true,
						-- reportMissingTypeStubs = false,
					},
				},
			},
			on_attach = function(client, bufnr)
				on_attach(client, bufnr)
				vim.api.nvim_buf_create_user_command(bufnr, "LspPyrightSetPythonPath", set_python_path, {
					desc = "Reconfigure pyright with the provided python path",
					nargs = 1,
					complete = "file",
				})
			end,
		})
		vim.lsp.enable("pyright")

		-- Ruff setup
		vim.lsp.config("ruff", {
			cmd = { "ruff", "server" },
			filetypes = { "python" },
			root_markers = djangoRootMarkers,
			capabilities = {
				general = {
					positionEncodings = { "utf-16" },
				},
			},
			init_options = {
				settings = {
					lint = {
						enable = true,
						preview = true,
						select = { "F", "W", "I", "DJ" }, -- Add E for more Formatting style warnings
					},
					format = {
						enable = true,
						preview = true,
					},
					logLevel = "info",
				},
			},
		})
		vim.lsp.enable("ruff")

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("lsp_attach_disable_ruff_hover", { clear = true }),
			callback = function(args)
				local client = vim.lsp.get_client_by_id(args.data.client_id)
				if client == nil then
					return
				end
				if client.name == "ruff" then
					--Disable hover in favor of pyright
					client.server_capabilities.hoverProvider = false
				end
			end,
			desc = "LSP : Disable hover capability from Ruff",
		})

		-- WEB DEV ORIENTED LSPs

		-- Html-ls setup
		vim.lsp.config("html-ls", {
			cmd = { "vscode-html-language-server", "--stdio" },
			filetypes = { "html", "htmldjango" },
			root_markers = djangoRootMarkers,
		})
		vim.lsp.enable("html-ls")

		--Emmet-language-server setup
		vim.lsp.config("emmet_ls", {
			cmd = { "emmet-language-server", "--stdio" },
			filetypes = { "html", "htmldjango", "css" },
			root_markers = djangoRootMarkers,
		})
		vim.lsp.enable("emmet_ls")

		--Css-lsp setup
		vim.lsp.config("cssls", {
			cmd = { "vscode-css-language-server", "--stdio" },
			filetypes = { "css", "scss", "less" },
			root_markers = djangoRootMarkers,
			settings = {
				css = { validate = true },
				scss = { validate = true },
				less = { validate = true },
			},
		})
		vim.lsp.enable("cssls")

		--Typescript-ls setup
		vim.lsp.config("ts_ls", {
			cmd = { "typescript-language-server", "--stdio" },
			filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
			root_markers = djangoRootMarkers,
		})
		vim.lsp.enable("ts_ls")

		--Django-template-ls setup
		vim.lsp.config("djlsp", {
			cmd = { "djlsp" },
			filetypes = { "htmldjango" },
			root_markers = djangoRootMarkers,
		})
		vim.lsp.enable("djlsp")
	end,
}
