return {
    'akinsho/bufferline.nvim', 
    version = "*", 
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
        require("bufferline").setup({
          options = {
            diagnostics = "nvim_lsp",
            always_show_bufferline = true,
            -- separator_style = "slant" | "slope" | "thick" | "thin" | { 'any', 'any' },
            separator_style = "thick",
            offsets = {
              {
                filetype = "neo-tree",
                text = "Neo-tree",
                highlight = "Directory",
                text_align = "center",
                separator = true
              },
            },
          },
        })
    end
}