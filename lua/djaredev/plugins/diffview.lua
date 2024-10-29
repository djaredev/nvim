return {
	"sindrets/diffview.nvim",
	cmd = { "DiffviewOpen" },
	config = function()
		require("diffview").setup()
	end
}

