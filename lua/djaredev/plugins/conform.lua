return {
    'stevearc/conform.nvim',
    ft = { "python", "javascript", "html", "css" },
    -- event = { "BufReadPre", "BufNewFile" },
    config = function()
        require("conform").setup({
            formatters_by_ft = {
              -- lua = { "stylua" },
              python = {
                 -- To fix lint errors.
                "ruff_fix",
                -- To run the Ruff formatter.
                "ruff_format",
              },
            },
            format_on_save = {
                -- These options will be passed to conform.format()
                timeout_ms = 500,
                lsp_fallback = true,
            },
          })

        vim.api.nvim_create_autocmd("BufWritePre", {
            pattern = "*",
            callback = function(args)
              require("conform").format({ bufnr = args.buf })
            end,
        })
    end
}
