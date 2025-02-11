return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	lazy = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("nvim-tree").setup({
			actions = {
				open_file = {
					quit_on_open = true,
				},
			},
			update_focused_file = {
				enable = true,
			},
			diagnostics = {
				enable = true,
				show_on_dirs = true,
				show_on_open_dirs = false,
				severity = { min = vim.diagnostic.severity.WARNING, max = vim.diagnostic.severity.ERROR },
				icons = {
					hint = "",
					info = "",
					warning = "",
					error = "",
				},
			},
			view = {
				signcolumn = "yes",
			},

			log = {
				enable = true,
				truncate = true,
				types = {
					diagnostics = true,
				},
			},
		})
	end,
}
