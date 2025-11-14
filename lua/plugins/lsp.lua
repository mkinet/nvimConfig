return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "antoinemadec/FixCursorHold.nvim",
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "j-hui/fidget.nvim",
    },

    config = function()
        local cmp = require('cmp')
        local cmp_lsp = require("cmp_nvim_lsp")
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities())

        -- Fix for Neovim 0.11.x changetracking with multiple LSP clients
        -- Force UTF-16 encoding (Pyright's default) for consistency
        capabilities.general = capabilities.general or {}
        capabilities.general.positionEncodings = { 'utf-16' }

        -- CRITICAL: Configure Ruff with --preview flag for Neovim 0.11+
        vim.lsp.config('ruff', {
            cmd = { 'ruff', 'server', '--preview' },
            filetypes = { 'python' },
            root_dir = vim.fs.root(0, { 'pyproject.toml', 'ruff.toml', '.ruff.toml', '.git' }),
            single_file_support = true,
        })

        require("fidget").setup({})
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "ruff",
                "pyright",
                "jsonls",
                "bashls",
                "marksman",
                "yamlls",
                "ts_ls"
            },
            handlers = {
                -- Default handler for all servers
                function(server_name)
                    require("lspconfig")[server_name].setup {
                        capabilities = capabilities
                    }
                end,

                -- Custom handlers for specific servers
                ["pyright"] = function()
                    require("lspconfig").pyright.setup {
                        capabilities = capabilities,
                        settings = {
                            python = {
                                analysis = {
                                    autoSearchPaths = true,
                                    diagnosticMode = "openFilesOnly",
                                    useLibraryCodeForTypes = true,
                                },
                            }
                        }
                    }
                end,
                ["lua_ls"] = function()
                    require("lspconfig").lua_ls.setup {
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                runtime = { version = "Lua 5.1" },
                                diagnostics = {
                                    globals = { "bit", "vim", "it", "describe", "before_each", "after_each" },
                                }
                            }
                        }
                    }
                end,
            }
        })

        -- Completion setup
        local cmp_select = { behavior = cmp.SelectBehavior.Select }
        cmp.setup({
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                ["<C-Space>"] = cmp.mapping.complete(),
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'luasnip' },
            }, {
                { name = 'buffer' },
            })
        })

        -- Diagnostic configuration
        vim.diagnostic.config({
            signs = {
                text = {
                    [vim.diagnostic.severity.ERROR] = "",
                    [vim.diagnostic.severity.WARN] = "",
                    [vim.diagnostic.severity.HINT] = "",
                    [vim.diagnostic.severity.HINT] = "",
                    [vim.diagnostic.severity.INFO] = "",
                },
            },
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
        })

        -- LSP keymaps
        local opts = { noremap = true, silent = true }
        vim.api.nvim_set_keymap("n", "<leader>le", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
        vim.api.nvim_set_keymap("n", "<leader>ld", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
        vim.api.nvim_set_keymap("n", "<leader>lk", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
        vim.api.nvim_set_keymap("n", "<leader>li", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
        vim.api.nvim_set_keymap("n", "<leader>lw", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
        vim.api.nvim_set_keymap("n", "<leader>r", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
        vim.api.nvim_set_keymap("n", "<leader>lu", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
        vim.api.nvim_set_keymap("n", "<leader>lca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
        vim.api.nvim_set_keymap("n", "<leader>lo", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
        vim.api.nvim_set_keymap("n", "[l", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', opts)
        vim.api.nvim_set_keymap("n", "]l", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', opts)
        vim.api.nvim_set_keymap("n", "<leader>ll", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
        vim.api.nvim_set_keymap("n", "<leader>p", "<cmd>lua vim.lsp.buf.format()<CR>", opts)
    end
}
