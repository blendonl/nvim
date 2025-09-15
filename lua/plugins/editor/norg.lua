return {
	"nvim-neorg/neorg",
	lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
	version = "*", -- Pin Neorg to the latest stable release
	config = function()
		require("neorg").setup {
			load = {
				["core.defaults"] = {}, -- Loads default behaviour
				["core.concealer"] = {}, -- Adds pretty icons to your documents
				["core.dirman"] = {  -- Manages Neorg workspaces
					config = {
						workspaces = {
							my_workspace = "~/neorg",
						},
						default_workspace = "neorg",
					},
				},
			},
		}
	end
}
