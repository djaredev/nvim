return {
    {
        "folke/tokyonight.nvim",
        lazy = false,
        -- opts = { style = "storm", transparent = true},
        config = function()
            require("tokyonight").setup({
                transparent = true,
                styles = {
                    sidebars = "transparent",
                    floats = "transparent",
                },
            })
            vim.cmd[[colorscheme tokyonight-storm]]
        end
    },

    { 
        "catppuccin/nvim", 
        name = "catppuccin", 
        lazy = true,
        priority = 1000,
        opts = {
    
        },
        config = function()
            -- load the colorscheme here
            vim.cmd([[colorscheme catppuccin-mocha]])
    
            -- require("catppuccin").setup {
            --     integration = {
            --       telescope = { enabled = true, border = false },
            --       cmp = { enabled = true, border = false },
            --       which_key = { enabled = true, border = false }
            --     }
            -- }
    
            -- integration = {
            --     telescope = { enabled = true, border = false },
            --     cmp = { enabled = true, border = false },
            --     which_key = { enabled = true, border = false }
            -- }
            -- cmp = {
            --     enabled = true,
            --     border = {
            --       completion = true,
            --       documentation = true
            --     }
            -- }
            -- telescope = { enabled = true, border = false }
        end,
    
        integrations = {
            telescope = { enabled = false, border = false },
            cmp = { enabled = true, border = false },
            -- which_key = { enabled = true, border = false }
            native_lsp = {
                enabled = false,
                virtual_text = {
                    errors = { "italic" },
                    hints = { "italic" },
                    warnings = { "italic" },
                    information = { "italic" },
                },
                underlines = {
                    errors = { "underline" },
                    hints = { "underline" },
                    warnings = { "underline" },
                    information = { "underline" },
                },
                inlay_hints = {
                    background = false,
                },
            },
        }
    }
}



