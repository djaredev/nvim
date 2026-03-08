--###############
--##           ##
--##  OPTIONS  ##
--##           ##
--###############

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

--###############
--##           ##
--##  PLUGINS  ##
--##           ##
--###############


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
    {

        --##############
        --##          ##
        --##  THEMES  ##
        --##          ##
        --##############

        {
            "folke/tokyonight.nvim", lazy = true,
            config = function()
                require("tokyonight").setup({
                    transparent = true,
                    styles = {
                        sidebars = "transparent",
                        floats = "transparent",
                    },
                })
                vim.cmd.colorscheme "tokyonight-storm"
            end
        },

        {
            "catppuccin/nvim", name = "catppuccin", lazy = false, priority = 1000,
            config = function()
                require("catppuccin").setup({
                    transparent_background = true,
                    color_overrides = {
                        mocha = {
                            base = "#000000",
                            mantle = "#000000",
                            crust = "#000000",
                        }
                    },
                    integrations = { blink_cmp = true },
                })
                vim.cmd.colorscheme "catppuccin-mocha"
            end,
        },

        --################
        --##            ##
        --## COMPLETION ##
        --##            ##
        --################

        {
            'saghen/blink.cmp', 
            dependencies = { 'rafamadriz/friendly-snippets' }, 
            version = '1.*',
            opts_extend = { "sources.default" },

            config = function()
                require("blink.cmp").setup({
                    keymap = { preset = 'default' },
                    cmdline = {
                        enabled = true,
                        completion = {
                            menu = {
                                auto_show = true
                            },
                            list = {
                                selection = {
                                    preselect = false,
                                    -- auto_insert = false
                                }
                            }
                        },
                    },

                    appearance = { nerd_font_variant = 'normal' },

                    completion = {
                        documentation = {
                            auto_show = true,
                            window = {
                                border = 'rounded'
                            },
                        },
                        menu = {
                            border = 'rounded',
                            auto_show = true,
                            draw = {
                                columns = {
                                    { "label",     "label_description", gap = 1 },
                                    { "kind_icon", "kind" }
                                },
                                treesitter = { 'lsp' },
                            }
                        },
                    },

                    signature = { 
                        enabled = true,
                        window = {
                            border = 'rounded'
                        }
                    },

                    sources = {
                        default = { 'lsp', 'path', 'snippets', 'buffer', 'lazydev' },
                        providers = {
                            lazydev = {
                                name = "LazyDev",
                                module = "lazydev.integrations.blink",
                                score_offset = 100,
                            },
                        },
                    },

                    fuzzy = { implementation = "prefer_rust_with_warning" }
            })
            end
        },

        --#################
        --##             ##
        --##  FORMATTER  ##
        --##             ##
        --#################


        {
            'stevearc/conform.nvim',
            ft = { "python", "javascript", "html", "css", "lua", "typescript", "svelte" },
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
                        javascript = { "prettier" },
                        typescript = { "prettier" },
                        html = { "prettier" },
                        css = { "prettier" },
                        svelte = { "prettier" },
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
        },

        --##########
        --##      ##
        --##  AI  ##
        --##      ##
        --##########


        {
            "zbirenbaum/copilot.lua",
            event = "InsertEnter",
            opts = {
                suggestion = {
                    auto_trigger = true,
                    keymap = {
                        accept = "<s-tab>",
                        accept_word = false,
                        accept_line = false,
                        next = "<M-]>",
                        prev = "<M-[>",
                        dismiss = "<C-/>",
                    },
                },
            },
        },

        --################
        --##            ##
        --##  DEBUGGER  ##
        --##            ##
        --################

        {
            "mfussenegger/nvim-dap",
            dependencies = {
                "mfussenegger/nvim-dap-python",
                "rcarriga/nvim-dap-ui",
                "nvim-neotest/nvim-nio",
            },
            keys = { "<leader>d" },
            config = function()
                local dap = require('dap')
                local dapui = require('dapui')
                require('dap-python').setup("debugpy-adapter")
                dapui.setup({
                    layouts = { {
                        elements = { {
                            id = "scopes",
                            size = 0.25
                        }, {
                            id = "breakpoints",
                            size = 0.25
                        }, {
                            id = "stacks",
                            size = 0.25
                        }, {
                            id = "watches",
                            size = 0.25
                        } },
                        position = "left",
                        size = 80
                    }, {
                        elements = { {
                            id = "repl",
                            size = 0.5
                        }, {
                            id = "console",
                            size = 0.5
                        } },
                        position = "bottom",
                        size = 10
                    } },
                })
                require("lazydev").setup({
                    library = { "nvim-dap-ui" },
                })
                -- Change breakpoint icons
                vim.api.nvim_set_hl(0, 'DapBreak', { fg = '#e51400' })
                vim.api.nvim_set_hl(0, 'DapStop', { fg = '#ffcc00' })
                local breakpoint_icons = vim.g.have_nerd_font
                    and { Breakpoint = '', BreakpointCondition = '', BreakpointRejected = '', LogPoint = '', Stopped = '' }
                    or { Breakpoint = '●', BreakpointCondition = '⊜', BreakpointRejected = '⊘', LogPoint = '◆', Stopped = '' }
                for type, icon in pairs(breakpoint_icons) do
                    local tp = 'Dap' .. type
                    local hl = (type == 'Stopped') and 'DapStop' or 'DapBreak'
                    vim.fn.sign_define(tp, { text = icon, texthl = hl, numhl = hl })
                end

                dap.listeners.after.event_initialized['dapui_config'] = dapui.open
                dap.listeners.before.event_terminated['dapui_config'] = dapui.close
                dap.listeners.before.event_exited['dapui_config'] = dapui.close
            end
        },

        --##############
        --##          ##
        --##  LINTER  ##
        --##          ##
        --##############


        {
            "mfussenegger/nvim-lint",
            ft = { "python", "javascript", "typescript", "html", "css", "svelte" },
            event = { "BufReadPre", "BufNewFile" },
            config = function()
                require("lint").linters_by_ft = {
                    python = { "ruff" },
                    javascript = { "eslint" },
                    typescript = { "eslint" },
                    html = { "eslint" },
                    css = { "eslint" },
                    svelte = { "eslint" },
                }

                vim.api.nvim_create_autocmd({ "BufWritePost" }, {
                    callback = function()
                        -- try_lint without arguments runs the linters defined in `linters_by_ft`
                        -- for the current filetype
                        require("lint").try_lint()
                    end,
                })
            end
        },

        --###########
        --##       ##
        --##  LSP  ##
        --##       ##
        --###########

        {
            "neovim/nvim-lspconfig",
            config = function()
                vim.lsp.enable("pyright")
                -- vim.lsp.enable("pyrefly")
                vim.lsp.enable("rust_analyzer")
                vim.lsp.enable("ts_ls")
                vim.lsp.enable("html")
                vim.lsp.enable("cssls")
                vim.lsp.enable("lua_ls")
                vim.lsp.enable("svelte")
                vim.lsp.enable('tailwindcss')


                -- Global mappings.
                -- See `:help vim.diagnostic.*` for documentation on any of the below functions
                vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, { desc = "Open float diagnostic" })
                vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
                vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
                -- vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, {desc = ""})

                -- Use LspAttach autocommand to only map the following keys
                -- after the language server attaches to the current buffer
                vim.api.nvim_create_autocmd('LspAttach', {
                    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
                    callback = function(ev)
                        -- Enable completion triggered by <c-x><c-o>
                        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

                        -- Buffer local mappings.
                        -- See `:help vim.lsp.*` for documentation on any of the below functions
                        local opts = { buffer = ev.buf }
                        opts.desc = "Go to declaration"
                        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
                        opts.desc = "Go to definition"
                        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
                        opts.desc = "Show documentation for what is under cursor"
                        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
                        opts.desc = "Go to implementation"
                        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
                        opts.desc = "Signature help"
                        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
                        opts.desc = "Add workspace folder"
                        vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
                        opts.desc = "Remove workspace folder"
                        vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
                        opts.desc = "List workspace folders"
                        vim.keymap.set('n', '<space>wl', function()
                            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                        end, opts)
                        opts.desc = "Go to type definition"
                        vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
                        opts.desc = "Smart rename"
                        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
                        opts.desc = "Code action"
                        vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
                        opts.desc = "Refereces"
                        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
                        opts.desc = "Format"
                        vim.keymap.set('n', '<space>f', function()
                            vim.lsp.buf.format { async = true }
                        end, opts)
                    end,
                })

                vim.diagnostic.config {
                    severity_sort = true,
                    float = { border = 'rounded', source = 'if_many' },
                    underline = { severity = vim.diagnostic.severity.ERROR },
                    signs = {
                        text = {
                            [vim.diagnostic.severity.ERROR] = ' ',
                            [vim.diagnostic.severity.WARN] = ' ',
                            [vim.diagnostic.severity.INFO] = ' ',
                            [vim.diagnostic.severity.HINT] = '󰌵 ',
                        },
                    } or {},
                    virtual_text = {
                        source = 'if_many',
                        spacing = 2,
                        prefix = '󰁨 ',
                    },
                }
            end
        },

        --###################
        --##               ##
        --##  HIGHLIGHTED  ##
        --##               ##
        --###################


        {
            "nvim-treesitter/nvim-treesitter",
            build = ":TSUpdate",
            event = "VeryLazy",
            main = "nvim-treesitter.configs",
            opts = {
                highlight = { enable = true },
                indent = { enable = true },
                autopairs = { enable = true },
                ensure_installed = {
                    "python",
                    "rust",
                    "lua",
                    "luadoc",
                    "bash",
                    "cpp",
                    "c",
                    "java",
                    "csv",
                    "vim",
                    "yaml",
                    "toml",
                    "kdl",
                    "javascript",
                    "typescript",
                    "html",
                    "css",
                    "svelte",
                },
            },
        },

        {
            "nvim-treesitter/nvim-treesitter-context"
        },

        --###################
        --##               ##
        --##  QOL PLUGINS  ##
        --##               ##
        --###################

        { 'windwp/nvim-autopairs', event = "InsertEnter", opts = {} },
        { 'numToStr/Comment.nvim', opts = {} },
        { "lewis6991/gitsigns.nvim", opts = {} },
        { 'nvim-lualine/lualine.nvim', dependencies = { 'nvim-tree/nvim-web-devicons' }, opts = {} },
        { "williamboman/mason.nvim", opts = {} },
        { 'stevearc/oil.nvim', dependencies = { "nvim-tree/nvim-web-devicons" }, opts = {} },
        { "kylechui/nvim-surround", version = "*", event = "VeryLazy", config = true },
        { "folke/trouble.nvim", dependencies = { "nvim-tree/nvim-web-devicons" }, cmd = { "Trouble" } },
        { "mbbill/undotree", cmd = { "UndotreeToggle" }, opts = {} },
        { "RRethy/vim-illuminate" },


        {
            "folke/snacks.nvim",
            priority = 1000,
            lazy = false,
            ---@type snacks.Config
            opts = {
                animation = { enabled = true },
                bufdelete = { enabled = true },
                bigfile = { enabled = true },
                dashboard = { enabled = true },
                explorer = { enabled = true },
                git = { enabled = true },
                -- indent = { enabled = true },
                input = { enabled = true },
                picker = {
                    enabled = true,
                    formatters = {
                        file = {
                            filename_first = true,
                        }
                    },
                },
                notifier = { enabled = true },
                quickfile = { enabled = true },
                scope = { enabled = true },
                scroll = { enabled = true },
                -- statuscolumn = { enabled = true },
                -- words = { enabled = true },
            },
            keys = {
                -- Top Pickers & Explorer
                { "<leader><space>", function() Snacks.picker.smart() end,                                   desc = "Smart Find Files" },
                { "<leader>/",       function() Snacks.picker.grep() end,                                    desc = "Grep" },
                { "<leader>:",       function() Snacks.picker.command_history() end,                         desc = "Command History" },
                { "<leader>n",       function() Snacks.picker.notifications() end,                           desc = "Notification History" },
                { "<leader>fe",      function() Snacks.explorer() end,                                       desc = "File Explorer" },
                -- find
                { "<leader>fb",      function() Snacks.picker.buffers() end,                                 desc = "Buffers" },
                { "<leader>fc",      function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
                { "<leader>ff",      function() Snacks.picker.files() end,                                   desc = "Find Files" },
                { "<leader>fg",      function() Snacks.picker.git_files() end,                               desc = "Find Git Files" },
                { "<leader>fp",      function() Snacks.picker.projects() end,                                desc = "Projects" },
                { "<leader>fr",      function() Snacks.picker.recent() end,                                  desc = "Recent" },
                -- git
                { "<leader>gb",      function() Snacks.picker.git_branches() end,                            desc = "Git Branches" },
                { "<leader>gl",      function() Snacks.picker.git_log() end,                                 desc = "Git Log" },
                { "<leader>gs",      function() Snacks.picker.git_status() end,                              desc = "Git Status" },
                { "<leader>gS",      function() Snacks.picker.git_stash() end,                               desc = "Git Stash" },
                { "<leader>gd",      function() Snacks.picker.git_diff() end,                                desc = "Git Diff (Hunks)" },
                { "<leader>gf",      function() Snacks.picker.git_log_file() end,                            desc = "Git Log File" },
                -- Grep
                { "<leader>sb",      function() Snacks.picker.lines() end,                                   desc = "Buffer Lines" },
                { "<leader>sB",      function() Snacks.picker.grep_buffers() end,                            desc = "Grep Open Buffers" },
                { "<leader>sg",      function() Snacks.picker.grep() end,                                    desc = "Grep" },
                -- search
                { '<leader>s/',      function() Snacks.picker.search_history() end,                          desc = "Search History" },
                { "<leader>sd",      function() Snacks.picker.diagnostics() end,                             desc = "Diagnostics" },
                { "<leader>sD",      function() Snacks.picker.diagnostics_buffer() end,                      desc = "Buffer Diagnostics" },
                { "<leader>si",      function() Snacks.picker.icons() end,                                   desc = "Icons" },
                { "<leader>sk",      function() Snacks.picker.keymaps() end,                                 desc = "Keymaps" },
                { "<leader>su",      function() Snacks.picker.undo() end,                                    desc = "Undo History" },
                { "<leader>sc",      function() Snacks.picker.colorschemes() end,                            desc = "Colorschemes" },
                -- LSP
                { "gd",              function() Snacks.picker.lsp_definitions() end,                         desc = "Goto Definition" },
                { "gD",              function() Snacks.picker.lsp_declarations() end,                        desc = "Goto Declaration" },
                { "gr",              function() Snacks.picker.lsp_references() end,                          nowait = true,                  desc = "References" },
                { "gI",              function() Snacks.picker.lsp_implementations() end,                     desc = "Goto Implementation" },
                { "gy",              function() Snacks.picker.lsp_type_definitions() end,                    desc = "Goto T[y]pe Definition" },
                { "<leader>ss",      function() Snacks.picker.lsp_symbols() end,                             desc = "LSP Symbols" },
                { "<leader>sS",      function() Snacks.picker.lsp_workspace_symbols() end,                   desc = "LSP Workspace Symbols" },
            },
        },

        {
            "folke/which-key.nvim", event = "VeryLazy", opts = { preset = "modern"},
            keys = {
                { "<leader>?", function() require("which-key").show({ global = false }) end, desc = "Buffer Local Keymaps (which-key)", },
            },
        },

        {
            "folke/lazydev.nvim", ft = "lua",
            opts = {
                library = {
                    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                },
            },
        },

    }
})

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
