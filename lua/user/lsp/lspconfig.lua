on_attach = require("user.lsp.handlers").on_attach

require("lspconfig")["pyright"].setup({
  on_attach = on_attach,
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
