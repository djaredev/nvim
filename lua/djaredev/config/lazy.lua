local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    spec = {
		{import = "djaredev.plugins.editor"},
		{import = "djaredev.plugins.lang"},
		{import = "djaredev.plugins.lsp"},
		{import = "djaredev.plugins.ui"},
		{import = "djaredev.plugins.util"},



    }
})
