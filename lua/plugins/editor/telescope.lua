return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
		},
		branch = "0.1.x",
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
			telescope.load_extension("fzf")
			return telescope
		end,
	},
}
