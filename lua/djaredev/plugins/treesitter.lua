return {
    {
        "nvim-treesitter/nvim-treesitter", 
        build = ":TSUpdate",
        event = "VeryLazy",
        main = "nvim-treesitter.configs",
        opts = {
            highlight = { enable = true },
            indent = { enable = true },
            autopairs = { enable = true},
            ensure_installed = {
                "python",
                "rust",
                "lua",
                "luadoc",
                "bash",
                "cpp",
                "c",
                "csv",
                "vim",
                "yaml",
            },
        },
    },
    {
        "nvim-treesitter/nvim-treesitter-context"
    }
}

        
    