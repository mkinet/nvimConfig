local nvim_buf_set_keymap = vim.api.nvim_buf_set_keymap

local function jdtls_keymaps(bufnr)
  local opts = { noremap = true, silent = true }
  -- specific keymaps
  --[[ nvim_buf_set_keymap(bufnr,"n", "<leader>di", "<Cmd>lua require'jdtls'.organize_imports()<CR>", opts) ]]
  --[[ nvim_buf_set_keymap(bufnr,"n", "<leader>dt", "<Cmd>lua require'jdtls'.test_class()<CR>", opts) ]]
  --[[ nvim_buf_set_keymap(bufnr,"n", "<leader>dn", "<Cmd>lua require'jdtls'.test_nearest_method()<CR>", opts) ]]
  --[[ nvim_buf_set_keymap(bufnr,"v", "<leader>de", "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>", opts) ]]
  --[[ nvim_buf_set_keymap(bufnr,"n", "<leader>de", "<Cmd>lua require('jdtls').extract_variable()<CR>", opts) ]]
  --[[ nvim_buf_set_keymap(bufnr,"v", "<leader>dm", "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>", opts) ]]
end

local on_attach = function(client,bufnr)
  -- default settings from lsp
  require("user.lsp.handlers").on_attach(client,bufnr)
  jdtls_keymaps(bufnr)
end
-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
local config = {
  -- The command that starts the language server
  -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
  cmd = {
    -- 💀
    "java", -- or '/path/to/java17_or_newer/bin/java'
    -- depends on if `java` is in your $PATH env variable and if it points to the right version.
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-Xms1g",
    "--add-modules=ALL-SYSTEM",
    "--add-opens",
    "java.base/java.util=ALL-UNNAMED",
    "--add-opens",
    "java.base/java.lang=ALL-UNNAMED",
    "-jar",
    "/Users/mkinet/.local/share/nvim/lsp_servers/jdtls/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar",
    -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                                       ^^^^^^^^^^^^^^
    -- Must point to the                                                     Change this to
    -- eclipse.jdt.ls installation                                           the actual version
    "-configuration",
    "/Users/mkinet/.local/share/nvim/lsp_servers/jdtls/config_mac",
    -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        ^^^^^^
    -- Must point to the                      Change to one of `linux`, `win` or `mac`
    -- eclipse.jdt.ls installation            Depending on your system.
    -- See `data directory configuration` section in the README
    "-data",
    "/Users/mkinet/.cache/nvim/workspace/",
  },

  -- 💀
  -- This is the default if not provided, you can remove it. Or adjust as needed.
  -- One dedicated LSP server & client will be started per unique root_dir
  root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew" }),

  -- Here you can configure eclipse.jdt.ls specific settings
  -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
  -- for a list of options
  settings = {
    java = {},
  },

  -- Language server `initializationOptions`
  -- You need to extend the `bundles` with paths to jar files
  -- if you want to use additional eclipse.jdt.ls plugins.
  --
  -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
  --
  -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
  init_options = {
    bundles = vim.list_extend(
      -- Java debug adapter
      vim.split(vim.fn.glob(vim.fn.stdpath("data") .. "/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar"), "\n"),
      -- Java test runner  
      vim.split(vim.fn.glob(vim.fn.stdpath("data") .. "/mason/packages/java-test/extension/server/*.jar"), "\n")
    ),
  },

  on_attach = on_attach,
}
-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
require("jdtls").start_or_attach(config)
