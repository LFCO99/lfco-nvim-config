local jdtls = require("jdtls")

-- Determine project root and workspace dir
local root_markers = { ".git", "mvnw", "gradlew" }
local root_dir = require("jdtls.setup").find_root(root_markers)
if root_dir == nil then
	return
end

local home = os.getenv("HOME")
local workspace_dir = home .. "/.local/share/eclipse/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")

-- start or attach JDTLS
jdtls.start_or_attach({
	cmd = { "jdtls" },
	root_dir = root_dir,
	workspace_folder = workspace_dir,
	init_options = {
		settings = {
			java = {
				configuration = {
					runtimes = {
						{
							name = "JavaSE-21",
							path = "/usr/lib/jvm/java-21-openjdk-amd64/",
						},
						{
							name = "JavaSE-17",
							path = "/usr/lib/jvm/java-17-openjdk-amd64/",
						},
					},
				},
				imports = {
					gradle = {
						wrapper = {
							enabled = true,
							checksums = {
								{
									sha256 = "7d3a4ac4de1c32b59bc6a4eb8ecb8e612ccd0cf1ae1e99f66902da64df296172",
									allowed = true,
								},
							},
						},
					},
				},
			},
		},
	},
})
