local wk = require("which-key")

-- Move Lines

vim.keymap.set("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move Down" })
vim.keymap.set("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move Up" })
vim.keymap.set("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
vim.keymap.set("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
vim.keymap.set("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move Down",  silent=true}) -- slient = true : mapped command will not be shown on the command line
vim.keymap.set("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move Up",  silent=true})

-- Telescope 
vim.keymap.set("n", "<leader>fg", function() require('telescope.builtin').git_files({ show_untracked = true }) end, {desc = "Telescope Git Files"})
vim.keymap.set("n", "<leader>fb", function() require("telescope.builtin").buffers() end, {desc = "Telescope buffers"})
vim.keymap.set("n", "<leader>gs", function() require("telescope.builtin").git_status().buffers() end, {desc = "Telescope Git status"})
vim.keymap.set("n", "<leader>gc", function() require("telescope.builtin").git_bcommits() end, {desc = "Telescope Git commits"})
vim.keymap.set("n", "<leader>gb", function() require("telescope.builtin").git_branches() end, {desc = "Telescope Git branches"})
vim.keymap.set("n", "<leader>ff", function() require('telescope.builtin').find_files() end, {desc = "Telescope Find Files"})
vim.keymap.set("n", "<leader>fh", function() require("telescope.builtin").help_tags() end, {desc = "Telescope Help"})
vim.keymap.set("n", "<leader>fs", function() require("telescope").extensions.file_browser.file_browser({ path = "%:h:p", select_buffer = true }) end, {desc = "Telescope file browser"})
--vim.keymap.set("n", "<leader>pe", function() require("telescope.builtin").buffers() end, {desc = "Telescope buffers"})
wk.register({f = { name = "Files" }, }, {prefix = "<leader>"})
wk.register({g = { name = "Git Files" }, }, {prefix = "<leader>"})


-- Trouble
vim.keymap.set("n", "<leader>tx", function() require("trouble").toggle() end, {desc = "Open Trouble"})
vim.keymap.set("n", "<leader>tw", function() require("trouble").toggle("diagnostics") end, {desc = "Workspace diagnostics"})
vim.keymap.set("n", "<leader>td", function() require("trouble").toggle("diagnostics") end, {desc = "Document diagnostics"})
vim.keymap.set("n", "<leader>tq", function() require("trouble").toggle("qflist") end, {desc = "Quickfix"})
vim.keymap.set("n", "<leader>tl", function() require("trouble").toggle("loclist") end, {desc = "Location list"})
vim.keymap.set("n", "<leader>tc", function() require("trouble").close() end, {desc = "Close Trouble"})
vim.keymap.set("n", "gR", function() require("trouble").toggle("lsp") end, {desc = "Lsp references"})
wk.register({t = { name = "Trouble" }, }, {prefix = "<leader>"})

-- Debug
vim.keymap.set("n", "<leader>db", function() require('dap').toggle_breakpoint() end, {desc = "Breakpoint"})
vim.keymap.set("n", "<leader>dc", function() require('dap').continue() end, {desc = "Continue"})
vim.keymap.set("n", "<leader>do", function() require('dap').step_over() end, {desc = "Step Over"})
vim.keymap.set("n", "<leader>di", function() require('dap').step_into() end, {desc = "Step into"})
vim.keymap.set("n", "<leader>dO", function() require('dap').step_out() end, {desc = "Step Out"})
vim.keymap.set("n", "<leader>dr", function() require('dap').repl.open() end, {desc = "Repl Open"})
vim.keymap.set("n", "<leader>dx", function() require('dap').terminate() end, {desc = "Exit"})
wk.register({d = { name = "Debug" }, }, {prefix = "<leader>"})


-- Safe file
vim.keymap.set("n", "<C-s>", ":w <CR>", {desc = "Save file", silent = true})

-- Code run
vim.keymap.set("n", "<leader>xp", ":TermExec cmd='python %'<CR>", {desc = "Execute Python file", silent = true})
vim.keymap.set("n", "<leader>xf", function() require("conform").format({ timeout_ms = 500, lsp_fallback = true}) end, {desc = "Format code", silent = true})
wk.register({x = { name = "Code options" }, }, {prefix = "<leader>"})


