return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"natecraddock/telescope-zf-native.nvim",
				config = function() end,
			},
		},
		cmd = "Telescope",
		opts = function()
			local telescope = require("telescope")
			telescope.setup({
				defaults = {
					file_ignore_patterns = {
						".cache",
						"dist",
						"node_modules",
						"yarn.lock",
						"vendors/prisma",
					},

					-- layout_config = {
					-- 	width = 0.6,
					-- 	height = 0.7,
					-- },
				},
			})

			telescope.load_extension("harpoon")
			telescope.load_extension("zf-native")
			return telescope
		end,
	},
}
