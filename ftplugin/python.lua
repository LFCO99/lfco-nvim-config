-- Used to set up the correct path for python3 across diverse os (currently MacOS and Linux)
local function get_python_path()
	local venv_dirs = { ".venv", "venv" }
	local current_dir = vim.fn.getcwd()

	-- Check for virtualenv in current directory or parents
	for _, venv in ipairs(venv_dirs) do
		local venv_path = current_dir .. "/" .. venv
		if vim.fn.isdirectory(venv_path) == 1 then
			local python_path = venv_path .. "/bin/python3"
			if vim.fn.executable(python_path) == 1 then
				return python_path
			end
		end
	end

	-- Fallback to system Python based on OS
	local os_config = {
		macunix = { python3_host_prog = "/Library/Frameworks/Python.framework/Versions/3.13/bin//python3" },
		unix = { python3_host_prog = "/usr/local/bin/python3.13" },
	}

	for os, config in pairs(os_config) do
		if vim.fn.has(os) == 1 then
			return config.python3_host_prog
		end
	end

	-- Default fallback (let Neovim find system Python)
	return "python3"
end

--set python3_host_prog
vim.g.python3_host_prog = get_python_path()

-- Python-specific settings
vim.opt_local.formatoptions = "jcroql"
vim.opt_local.textwidth = 88 -- Matches Black
vim.opt_local.tabstop = 4
vim.opt_local.softtabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.expandtab = true
vim.opt_local.smartindent = true

--Buffer-local keymaps for Python/Django
vim.keymap.set("n", "<leader>r", ":RunCode<CR>")
