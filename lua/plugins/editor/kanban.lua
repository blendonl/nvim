return {
	{
		"hasansujon786/super-kanban.nvim",
		dependencies = {
			"folke/snacks.nvim", -- [required]
			"nvim-orgmode/orgmode", -- [optional] Org format support
		},
		opts = {},             -- optional: pass your config table here
	},
	{
		'nvim-orgmode/orgmode',
		event = 'VeryLazy',
		ft = { 'org' },
		config = function()
			-- Setup orgmode
			require('orgmode').setup({
				org_agenda_files = '/mnt/data/notes/**/*',
				org_default_notes_file = '~/mnt/data/notes/refile.org',
			})

			-- NOTE: If you are using nvim-treesitter with ~ensure_installed = "all"~ option
			-- add ~org~ to ignore_install
			-- require('nvim-treesitter.configs').setup({
			--   ensure_installed = 'all',
			--   ignore_install = { 'org' },
			-- })
		end,
	}
}
