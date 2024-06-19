return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
    },
    config = function()
      -- local on_attach = function(_, bufnr)
      --   vim.keymap.set('n', 'K', vim.lsp.buf.hover, {buffer = bufnr})
      -- end
        local lspconfig = require "lspconfig"
        -- lspconfig.pylsp.setup{}
        -- local on_attach = function(client, bufnr)
        --   if client.name == 'ruff' then
        --     -- Disable hover in favor of Pyright
        --     client.server_capabilities.hoverProvider = false
        --   end
        -- end
        -- lspconfig.ruff.setup{
        --   -- on_attach = on_attach,
        -- }

        lspconfig.pyright.setup{}

        lspconfig.rust_analyzer.setup{}


                -- Global mappings.
        -- See `:help vim.diagnostic.*` for documentation on any of the below functions
        vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
        vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
        vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

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
              vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
              vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
              vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
              vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
              vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
              vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
              vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
              vim.keymap.set('n', '<space>wl', function()
              print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
              end, opts)
              vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
              vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
              vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
              vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
              vim.keymap.set('n', '<space>f', function()
                vim.lsp.buf.format { async = true }
              end, opts)
            end,
        })
        vim.opt.winhighlight = 'Normal:CmpPmenu,FloatBorder:CmpBorder,CursorLine:PmenuSel,Search:None'
        local border = {
              {"╭", "FloatBorder"},
              {"─", "FloatBorder"},
              {"╮", "FloatBorder"},
              {"│", "FloatBorder"},
              {"╯", "FloatBorder"},
              {"─", "FloatBorder"},
              {"╰", "FloatBorder"},
              {"│", "FloatBorder"},
        }

        -- LSP settings (for overriding per client)
        local handlers =  {
          ["textDocument/hover"] =  vim.lsp.with(vim.lsp.handlers.hover, {border = border}),
          ["textDocument/signatureHelp"] =  vim.lsp.with(vim.lsp.handlers.signature_help, {border = border }),
        }

        -- Do not forget to use the on_attach function
        --require 'lspconfig'.myserver.setup { handlers=handlers }

        -- To instead override globally
        local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
        function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
          opts = opts or {}
          opts.border = opts.border or border
          return orig_util_open_floating_preview(contents, syntax, opts, ...)
        end

        -- require 'lspconfig'.myservertwo.setup {}
    end
}