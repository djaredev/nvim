return {
	"mfussenegger/nvim-dap",
	dependencies = {
		{
			"mfussenegger/nvim-dap-python",
			lazy = true
		},
		"nvim-neotest/nvim-nio",
		"rcarriga/nvim-dap-ui",
		"nvim-dap-ui",
		"folke/neodev.nvim"
	},
	keys = { "<leader>d" },
	config = function()
		require('dap-python').setup()
		require("dapui").setup()
		require("neodev").setup({
			library = { plugins = { "nvim-dap-ui" }, types = true }
		})
	end
}

