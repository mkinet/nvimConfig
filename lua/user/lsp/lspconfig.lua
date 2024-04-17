local on_attach = require("user.lsp.handlers").on_attach

require("lspconfig")["pyright"].setup({
    on_attach = on_attach,
    settings = {
        pyright = {
            -- Using Ruff's import organizer
            disableOrganizeImports = true,
        },
        python = {
            analysis = {
                -- Ignore all files for analysis to exclusively use Ruff for linting
                ignore = { "*" },
            },
        },
    },
})
require("lspconfig")["jsonls"].setup({
    on_attach = on_attach,
})
require("lspconfig")["dockerls"].setup({
    on_attach = on_attach,
})
require("lspconfig")["sqlls"].setup({
    on_attach = on_attach,
})
require("lspconfig")["groovyls"].setup({
    on_attach = on_attach,
})
require("lspconfig")["ruff"].setup({
    on_attach = on_attach,
})
require("lspconfig")["lua_ls"].setup({
    on_attach = on_attach,
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" },
            },
        },
    },
})
