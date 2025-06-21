return {
	{
		"elixir-tools/elixir-tools.nvim",
		ft = "elixir",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("elixir").setup({
				credo = { enable = true },
				elixirls = { enable = true },
			})
		end,
	},
}
