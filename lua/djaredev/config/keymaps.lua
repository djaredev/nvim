local wk = require("which-key")

-- Move Lines
vim.keymap.set("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move Down" })
vim.keymap.set("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move Up" })
vim.keymap.set("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
vim.keymap.set("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
vim.keymap.set("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move Down", silent = true }) -- slient = true : mapped command will not be shown on the command line
vim.keymap.set("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move Up", silent = true })

-- Resize window using <ctrl> arrow keys
vim.keymap.set("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
vim.keymap.set("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

-- Buffer
wk.add({ "<leader>b", group = "Buffer" })
vim.keymap.set("n", "<leader>bp", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
vim.keymap.set("n", "<leader>bn", "<cmd>bnext<cr>", { desc = "Next Buffer" })
vim.keymap.set("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
vim.keymap.set("n", "<leader>`", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
-- vim.keymap.set("n", "<leader>bd", LazyVim.ui.bufremove, { desc = "Delete Buffer" })
vim.keymap.set("n", "<leader>bD", "<cmd>:bd<cr>", { desc = "Delete Buffer and Window" })

-- Clear search with <esc>
vim.keymap.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and Clear hlsearch" })

-- Trouble
wk.add({ "<leader>t", group = "Trouble" })
vim.keymap.set("n", "<leader>tx", function() require("trouble").toggle() end, { desc = "Open Trouble" })
vim.keymap.set("n", "<leader>tw", function() require("trouble").toggle("diagnostics") end,
	{ desc = "Workspace diagnostics" })
vim.keymap.set("n", "<leader>td", function() require("trouble").toggle("diagnostics") end,
	{ desc = "Document diagnostics" })
vim.keymap.set("n", "<leader>tq", function() require("trouble").toggle("qflist") end, { desc = "Quickfix" })
vim.keymap.set("n", "<leader>tl", function() require("trouble").toggle("loclist") end, { desc = "Location list" })
vim.keymap.set("n", "<leader>tc", function() require("trouble").close() end, { desc = "Close Trouble" })
vim.keymap.set("n", "gR", function() require("trouble").toggle("lsp") end, { desc = "Lsp references" })

-- Debug
wk.add({ "<leader>d", group = "Debugger" })
vim.keymap.set("n", "<leader>db", function() require('dap').toggle_breakpoint() end, { desc = "Breakpoint" })
vim.keymap.set("n", "<leader>dc", function() require('dap').continue() end, { desc = "Continue" })
vim.keymap.set("n", "<leader>do", function() require('dap').step_over() end, { desc = "Step Over" })
vim.keymap.set("n", "<leader>di", function() require('dap').step_into() end, { desc = "Step into" })
vim.keymap.set("n", "<leader>dO", function() require('dap').step_out() end, { desc = "Step Out" })
vim.keymap.set("n", "<leader>dr", function() require('dap').repl.open() end, { desc = "Repl Open" })
vim.keymap.set("n", "<leader>dx", function() require('dap').terminate() end, { desc = "Exit" })


-- Safe file
vim.keymap.set({ "i", "x", "n", "s" }, "<C-s>", "<CMD>w<CR>", { desc = "Save file", silent = true })

-- Code run
wk.add({ "<leader>x", group = "Code options" })
vim.keymap.set("n", "<leader>xf", function() require("conform").format({ timeout_ms = 500, lsp_fallback = true }) end,
	{ desc = "Format code", silent = true })

-- Oil
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- UndoTree
vim.keymap.set("n", "<leader>u", "<CMD>UndotreeToggle<CR>", { desc = "UndoTree" })
