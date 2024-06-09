return {
    -- amongst your other plugins
    'akinsho/toggleterm.nvim',
    version = "*",
    config = function()
        require("toggleterm").setup({
            open_mapping = [[<c-\>]],
            direction = "float",
            float_opts = {
                border = 'curved',
                winblend = 0,
            },
        })
        local Terminal  = require('toggleterm.terminal').Terminal
        -- local python = Terminal:new({ cmd = "python", hidden = true})
        local python = Terminal:new({ cmd = "python " .. vim.api.nvim_buf_get_name(0), hidden = true })
        function _PYTHON_TOGGLE()
            python:toggle()
        end

        function _PP()
            --local s = vim.api.nvim_buf_get_name(0)
            --local run = "TermExec cmd='python " .. vim.api.nvim_buf_get_name(0) .. "'"
            --print("Hola" .. run)
            local run = "TermExec cmd='python %'<cr>"
            vim.cmd(run)
        end
    end
}