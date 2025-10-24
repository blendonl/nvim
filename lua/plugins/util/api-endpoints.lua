return {
	"zerochae/endpoint.nvim",
	dependencies = {
		-- Choose one or more pickers (all optional):
		"nvim-telescope/telescope.nvim", -- For telescope picker
		"folke/snacks.nvim",             -- For snacks picker
		"stevearc/dressing.nvim",        -- Enhances vim.ui.select with telescope backend
		-- vim.ui.select picker works without dependencies
	},
	cmd = { "Endpoint", "EndpointRefresh" },
	config = function()
		require("endpoint").setup({
			-- Picker configuration
			picker = {
				type = "telescope",          -- "telescope", "vim_ui_select", "snacks"
				options = {
					telescope = {},            -- Telescope-specific options
					snacks = {},               -- Snacks-specific options
					vim_ui_select = {          -- vim.ui.select-specific options
						enable_filter = false,   -- Enable filtering for large lists
						filter_threshold = 20,   -- Show filter prompt when endpoints > threshold
						filter_prompt = "Filter: ", -- Custom filter prompt
						show_filter_examples = true, -- Show filter examples in prompt
					},
				},
				-- Previewer configuration
				previewer = {
					enable_highlighting = true, -- Enable syntax highlighting in previewer (default: true)
				},
			},

			-- Cache configuration
			cache = {
				mode = "session", -- "none", "session", "persistent"
			},

			-- UI configuration
			ui = {
				show_icons = true,
				show_method = true,
				methods = {
					GET = { icon = "📥", color = "TelescopeResultsNumber" },
					POST = { icon = "📤", color = "TelescopeResultsConstant" },
					PUT = { icon = "✏️", color = "TelescopeResultsKeyword" },
					DELETE = { icon = "🗑️", color = "TelescopeResultsSpecialChar" },
					PATCH = { icon = "🔧", color = "TelescopeResultsFunction" },
					ROUTE = { icon = "🔗", color = "TelescopeResultsIdentifier" },
				},
			},
		})
	end,
}
