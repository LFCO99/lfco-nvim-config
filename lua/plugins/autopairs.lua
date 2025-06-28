return {
	"windwp/nvim-autopairs",
	event = "InsertEnter",
	config = function()
		require("nvim-autopairs").setup({
			check_ts = true,
			ts_config = {
				htmldjango = { "django" },
			},
		})

		local Rule = require("nvim-autopairs.rule")
		local npairs = require("nvim-autopairs")
		-- local cond = require("nvim-autopairs.conds")

		npairs.remove_rule("{")

		local django_template_tags = { { "{%", "%}" }, { "{{", "}}" } }
		for _, tag in ipairs(django_template_tags) do
			npairs.add_rules({
				Rule(tag[1], tag[2], "htmldjango"),
			})
		end
		-- npairs.add_rules({
		-- 	Rule("{%", "%}", "htmldjango"),
		-- 	Rule("{{", "}}", "htmldjango"),
		-- })

		npairs.add_rule(Rule("{", "}", "-htmldjango"))
	end,
}
