on_attach = require("user.lsp.handlers").on_attach

require("lspconfig")["pyright"].setup({
	on_attach = on_attach,
})
require("lspconfig")["jsonls"].setup({
	on_attach = on_attach,
})
require("lspconfig")["sumneko_lua"].setup({
	on_attach = on_attach,
	-- Server-specific settings...
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.stdpath("config") .. "/lua"] = true,
				},
			},
		},
	},
})
