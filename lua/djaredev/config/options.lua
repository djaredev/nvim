vim.opt.number         = true
vim.opt.relativenumber = true
vim.opt.tabstop        = 4
vim.opt.shiftwidth     = 4
vim.opt.expandtab      = true
vim.g.mapleader        = " "
vim.opt.termguicolors  = true -- 24-bit colour
vim.opt.clipboard      = 'unnamedplus'
-- vim.opt.hlsearch             = false

-- To delete the message "clipboard: provider returned invalid data"
-- See: https://github.com/neovim/neovim/discussions/28010#discussioncomment-9877494
local function disable_paste()
    return {
        vim.fn.split(vim.fn.getreg(""), "\n"),
        vim.fn.getregtype(""),
    }
end

-- Enable only copy
vim.g.clipboard = {
  name = 'OSC 52',
  copy = {
    ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
    ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
  },
  paste = {
    ['+'] = disable_paste,
    ['*'] = disable_paste,
  },
}
