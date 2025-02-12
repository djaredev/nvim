return { "lukas-reineke/indent-blankline.nvim", 
	lazy = true,
    main = "ibl", 
    opts = {
        exclude = {
            filetypes = {
              "help",
              "alpha",
              "dashboard",
              "neo-tree",
              "Trouble",
              "trouble",
              "lazy",
              "mason",
              "notify",
              "toggleterm",
              "lazyterm",
            },
        },
        scope = { enabled = false },
    },
}
