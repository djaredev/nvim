return {
	{
		"folke/tokyonight.nvim",
		lazy = true,
		-- opts = { style = "storm", transparent = true},
		config = function()
			require("tokyonight").setup({
				-- transparent = false,
				-- styles = {
				--     sidebars = "transparent",
				--     floats = "transparent",
				-- },
			})
			vim.cmd [[colorscheme tokyonight-storm]]
		end
	},

	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
		priority = 1000,
		opts = {
		},
		config = function()
			require("catppuccin").setup({
				transparent_background = true,
				color_overrides = {
					mocha = {
						base = "#000000",
						mantle = "#000000",
						crust = "#000000",
					}
				},
				integrations = {
					blink_cmp = true,
				},
			})
			vim.cmd.colorscheme "catppuccin-mocha"
		end,

	},
}
