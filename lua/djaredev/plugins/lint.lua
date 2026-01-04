return {
	"mfussenegger/nvim-lint",
	ft = { "python", "javascript", "typescript", "html", "css", "svelte" },
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("lint").linters_by_ft = {
			python = { "ruff" },
			javascript = { "eslint" },
			typescript = { "eslint" },
			html = { "eslint" },
			css = { "eslint" },
			svelte = { "eslint" },
		}

		vim.api.nvim_create_autocmd({ "BufWritePost" }, {
			callback = function()
				-- try_lint without arguments runs the linters defined in `linters_by_ft`
				-- for the current filetype
				require("lint").try_lint()
			end,
		})
	end
}
