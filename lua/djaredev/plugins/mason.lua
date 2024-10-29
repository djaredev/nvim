return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
	},
	-- cmd = "Mason",
	config = function()
		require("mason").setup()
		require("mason-lspconfig").setup({
			ensure_installed = {
				"pyright",
				"ts_ls",
				"jdtls",
				"html",
				"cssls",
				"lua_ls",
			}
		})
	end,
}
