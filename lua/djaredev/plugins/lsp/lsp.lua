return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
    },
    config = function()
        local lspconfig = require "lspconfig"
        local capabilities = require('cmp_nvim_lsp').default_capabilities()

        lspconfig.pyright.setup{
          capabilities = capabilities,
          settings = {
            python = {
                analysis = {
                    diagnosticSeverityOverrides = {
                        reportUnusedImport = "none",
                    },
                },
            },
          },
        }
        lspconfig.rust_analyzer.setup{}


                -- Global mappings.
        -- See `:help vim.diagnostic.*` for documentation on any of the below functions
        vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, {desc = "Open float diagnostic"})
        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, {desc = "Go to previous diagnostic"})
        vim.keymap.set('n', ']d', vim.diagnostic.goto_next, {desc = "Go to next diagnostic"})
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
    end
}