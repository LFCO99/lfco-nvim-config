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
		local cond = require("nvim-autopairs.conds")

		npairs.remove_rule("{")

		npairs.add_rules({
			Rule("{%", "%}", "htmldjango"),
			Rule("{{", "}}", "htmldjango"),
		})
		npairs.add_rule(Rule("{", "}", "-htmldjango"))

		-- Add spaces between parentheses

		local brackets = { { "{%", "%}" }, { "{{", "}}" } }
		npairs.add_rules({
			-- Rule for a pair with left-side " " and right side " "
			Rule(" ", " ")
				-- Pair will only occur if the conditional returns true
				:with_pair(function(opts)
					-- We are checking if we are inserting a space in brackets
					local pair = opts.line:sub(opts.col - 1, opts.col)
					return vim.tbl_contains({
						brackets[1][1] .. brackets[1][2],
						brackets[2][1] .. brackets[2][2],
					}, pair)
				end)
				:with_move(cond.none())
				:with_cr(cond.none())
				-- We only want to delete the pair of spaces when the cursor is as such: ( | )
				:with_del(
					function(opts)
						local col = vim.api.nvim_win_get_cursor(0)[2]
						local context = opts.line:sub(col - 1, col + 2)
						return vim.tbl_contains({
							brackets[1][1] .. "   " .. brackets[1][2],
							brackets[2][1] .. "   " .. brackets[2][2],
						}, context)
					end
				),
		})

		for _, bracket in pairs(brackets) do
			npairs.add_rules({
				Rule(bracket[1] .. " ", " " .. bracket[2])
					:with_pair(cond.none())
					:with_move(function(opts)
						return opts.char == bracket[2]
					end)
					:with_del(cond.none())
					:use_key(bracket[2])
					-- Removes the trailing whitespace that can occur without this
					:replace_map_cr(function(_)
						return "<C-c>2xi<CR><C-C>O"
					end),
			})
		end
	end,
}
