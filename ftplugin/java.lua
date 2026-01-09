-- Java filetype configuration using nvim-jdtls
local jdtls_ok, jdtls = pcall(require, "jdtls")
if not jdtls_ok then
    vim.notify("nvim-jdtls not found, install it with :Lazy sync", vim.log.levels.WARN)
    return
end

-- Use direct path to Mason's JDTLS installation (more reliable than registry)
local jdtls_path = vim.fn.stdpath("data") .. "/mason/packages/jdtls"
local launcher_jar = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")

if launcher_jar == "" then
    vim.notify("JDTLS not installed. Run :MasonInstall jdtls", vim.log.levels.WARN)
    return
end

-- Determine OS config folder
local os_config = "config_mac"
if vim.fn.has("linux") == 1 then
    os_config = "config_linux"
elseif vim.fn.has("win32") == 1 then
    os_config = "config_win"
end

-- Project-specific workspace folder
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = vim.fn.stdpath("cache") .. "/jdtls-workspace/" .. project_name

-- Debug bundles from Mason
local bundles = {}
local mason_packages = vim.fn.stdpath("data") .. "/mason/packages"

-- Java Debug Adapter
local debug_jar = vim.fn.glob(mason_packages .. "/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar")
if debug_jar ~= "" then
    table.insert(bundles, debug_jar)
end

-- Java Test Runner
local test_jars = vim.split(vim.fn.glob(mason_packages .. "/java-test/extension/server/*.jar"), "\n")
for _, jar in ipairs(test_jars) do
    if jar ~= "" then
        table.insert(bundles, jar)
    end
end

-- LSP capabilities with completion support
local capabilities = vim.lsp.protocol.make_client_capabilities()
local cmp_nvim_lsp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if cmp_nvim_lsp_ok then
    capabilities = vim.tbl_deep_extend("force", capabilities, cmp_nvim_lsp.default_capabilities())
end

-- Java-specific keymaps
local function java_keymaps(bufnr)
    local opts = { noremap = true, silent = true, buffer = bufnr }

    -- Java-specific actions
    vim.keymap.set("n", "<leader>jo", jdtls.organize_imports, vim.tbl_extend("force", opts, { desc = "Organize Imports" }))
    vim.keymap.set("n", "<leader>jv", jdtls.extract_variable, vim.tbl_extend("force", opts, { desc = "Extract Variable" }))
    vim.keymap.set("v", "<leader>jv", function() jdtls.extract_variable(true) end, vim.tbl_extend("force", opts, { desc = "Extract Variable" }))
    vim.keymap.set("n", "<leader>jc", jdtls.extract_constant, vim.tbl_extend("force", opts, { desc = "Extract Constant" }))
    vim.keymap.set("v", "<leader>jc", function() jdtls.extract_constant(true) end, vim.tbl_extend("force", opts, { desc = "Extract Constant" }))
    vim.keymap.set("v", "<leader>jm", function() jdtls.extract_method(true) end, vim.tbl_extend("force", opts, { desc = "Extract Method" }))

    -- Test actions (require java-test)
    vim.keymap.set("n", "<leader>jt", jdtls.test_class, vim.tbl_extend("force", opts, { desc = "Test Class" }))
    vim.keymap.set("n", "<leader>jn", jdtls.test_nearest_method, vim.tbl_extend("force", opts, { desc = "Test Nearest Method" }))
end

-- On attach callback
local on_attach = function(client, bufnr)
    java_keymaps(bufnr)

    -- Setup DAP after LSP attaches
    if #bundles > 0 then
        jdtls.setup_dap({ hotcodereplace = "auto" })
        local ok, jdtls_dap = pcall(require, "jdtls.dap")
        if ok then
            jdtls_dap.setup_dap_main_class_configs()
        end
    end
end

-- JDTLS configuration
local config = {
    cmd = {
        "java",
        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        "-Dosgi.bundles.defaultStartLevel=4",
        "-Declipse.product=org.eclipse.jdt.ls.core.product",
        "-Dlog.protocol=true",
        "-Dlog.level=ALL",
        "-Xmx1g",
        "--add-modules=ALL-SYSTEM",
        "--add-opens", "java.base/java.util=ALL-UNNAMED",
        "--add-opens", "java.base/java.lang=ALL-UNNAMED",
        "-jar", launcher_jar,
        "-configuration", jdtls_path .. "/" .. os_config,
        "-data", workspace_dir,
    },
    root_dir = require("jdtls.setup").find_root({ ".git", "gradlew", "mvnw", "pom.xml", "build.gradle" }),
    settings = {
        java = {
            signatureHelp = { enabled = true },
            contentProvider = { preferred = "fernflower" },
            completion = {
                favoriteStaticMembers = {
                    "org.junit.jupiter.api.Assertions.*",
                    "org.mockito.Mockito.*",
                },
                filteredTypes = {
                    "com.sun.*",
                    "io.micrometer.shaded.*",
                    "java.awt.*",
                    "jdk.*",
                    "sun.*",
                },
            },
            sources = {
                organizeImports = {
                    starThreshold = 9999,
                    staticStarThreshold = 9999,
                },
            },
            codeGeneration = {
                toString = {
                    template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
                },
                hashCodeEquals = {
                    useJava7Objects = true,
                },
                useBlocks = true,
            },
            configuration = {
                runtimes = {
                    {
                        name = "JavaSE-21",
                        path = vim.fn.expand("$JAVA_HOME"),
                        default = true,
                    },
                },
            },
        },
    },
    capabilities = capabilities,
    on_attach = on_attach,
    init_options = {
        bundles = bundles,
    },
}

-- Start JDTLS
jdtls.start_or_attach(config)
