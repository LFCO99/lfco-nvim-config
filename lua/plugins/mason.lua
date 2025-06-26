return {
	"mason-org/mason.nvim",
	config = function()
		require("mason").setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})
		local mason_registry = require("mason-registry")
		local tools = {
			-- Lua Related
			"lua-language-server", -- LSP
			"stylua", -- Formatter

			-- Python related
			"pyright", --LSP
			"ruff", -- Linter

			-- Web App related --
			-- General
			"css-lsp",
			"html-lsp",
			"emmet-language-server",
			"typescript-language-server", -- Js and Ts lsp
			"prettier", -- Html, css, js formatter
			-- Django Framework related
			"django-template-lsp",
			"djlint", -- Django linter
		}
		for _, tool in ipairs(tools) do
			if not mason_registry.is_installed(tool) then
				vim.cmd("MasonInstall " .. tool)
			end
		end
	end,
}
