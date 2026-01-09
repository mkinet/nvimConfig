return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "nvim-neotest/nvim-nio",
            "jay-babu/mason-nvim-dap.nvim",
        },
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")

            -- Setup Mason DAP for auto-installing adapters
            require("mason-nvim-dap").setup({
                ensure_installed = {
                    "python",
                    "java-debug-adapter",
                    "java-test",
                    "lua-debug-adapter",
                },
                automatic_installation = true,
            })


            -- Setup DAP UI
            dapui.setup()

            -- Auto open/close DAP UI
            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close()
            end

            -- DAP Keymaps
            local opts = { noremap = true, silent = true }
            vim.api.nvim_set_keymap("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", opts)
            vim.api.nvim_set_keymap("n", "<leader>dB", "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>", opts)
            vim.api.nvim_set_keymap("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", opts)
            vim.api.nvim_set_keymap("n", "<leader>di", "<cmd>lua require'dap'.step_into()<cr>", opts)
            vim.api.nvim_set_keymap("n", "<leader>do", "<cmd>lua require'dap'.step_over()<cr>", opts)
            vim.api.nvim_set_keymap("n", "<leader>dO", "<cmd>lua require'dap'.step_out()<cr>", opts)
            vim.api.nvim_set_keymap("n", "<leader>dr", "<cmd>lua require'dap'.repl.open()<cr>", opts)
            vim.api.nvim_set_keymap("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>", opts)
            vim.api.nvim_set_keymap("n", "<leader>du", "<cmd>lua require'dapui'.toggle()<cr>", opts)
            vim.api.nvim_set_keymap("n", "<leader>dt", "<cmd>lua require'dap'.terminate()<cr>", opts)

            -- DAP signs
            dap.defaults.fallback.sign_text = {
                breakpoint = '🛑',
                breakpoint_condition = '🔍',
                stopped = '▶️',
            }
            vim.api.nvim_set_hl(0, 'DapStoppedLine', { bg = '#3e4451' })
        end,
    },
    {
        "mfussenegger/nvim-dap-python",
        dependencies = {
            "mfussenegger/nvim-dap",
        },
        ft = "python",
        build = false, -- Disable luarocks build (known issue: nvim-dap-python rockspec expects nvim-dap via luarocks)
        config = function()
            -- Try to find python in virtual environment, fallback to system python
            local python_path = vim.fn.exepath("python3") or vim.fn.exepath("python")
            if vim.env.VIRTUAL_ENV then
                python_path = vim.env.VIRTUAL_ENV .. "/bin/python"
            end
            require("dap-python").setup(python_path)
        end,
    },
    {
        "jbyuki/one-small-step-for-vimkind",
        dependencies = {
            "mfussenegger/nvim-dap",
        },
        config = function()
            local dap = require("dap")
            dap.adapters.nlua = function(callback, config)
                callback({ type = 'server', host = config.host or "127.0.0.1", port = config.port or 8086 })
            end
            dap.configurations.lua = {
                {
                    type = 'nlua',
                    request = 'attach',
                    name = "Attach to running Neovim instance",
                },
            }
        end,
        keys = {
            {
                "<leader>dL",
                function() require("osv").launch({ port = 8086 }) end,
                desc = "Launch Lua Debugger Server",
            },
        },
    },
}
