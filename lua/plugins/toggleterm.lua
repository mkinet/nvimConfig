return {
    'akinsho/toggleterm.nvim',
    version = "*",
    dependencies = { "mrjones2014/smart-splits.nvim" },
    config = function()
        require("toggleterm").setup({
            size = 40,
            open_mapping = [[<c-\>]],
            hide_numbers = true,
            shade_filetypes = {},
            shade_terminals = true,
            shading_factor = 2,
            start_in_insert = true,
            insert_mappings = true,
            persist_size = true,
            direction = "horizontal",
            close_on_exit = true,
            shell = vim.o.shell,
            float_opts = {
                border = "curved",
                winblend = 0,
                highlights = {
                    border = "Normal",
                    background = "Normal",
                },
            },
        })
        function _G.set_terminal_keymaps()
            local opts = { noremap = true, buffer = 0 }
            vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
            vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
            -- Navigation using smart-splits (enables Neovim <-> Ghostty pane navigation)
            vim.keymap.set("t", "<C-h>", function()
                vim.cmd([[stopinsert]])
                require("smart-splits").move_cursor_left()
            end, opts)
            vim.keymap.set("t", "<C-j>", function()
                vim.cmd([[stopinsert]])
                require("smart-splits").move_cursor_down()
            end, opts)
            vim.keymap.set("t", "<C-k>", function()
                vim.cmd([[stopinsert]])
                require("smart-splits").move_cursor_up()
            end, opts)
            vim.keymap.set("t", "<C-l>", function()
                vim.cmd([[stopinsert]])
                require("smart-splits").move_cursor_right()
            end, opts)
            -- Scroll keymaps (exit to normal, scroll, stay in normal for navigation)
            vim.keymap.set("t", "<C-u>", [[<C-\><C-n><C-u>]], opts)  -- Half page up
            vim.keymap.set("t", "<C-d>", [[<C-\><C-n><C-d>]], opts)  -- Half page down
        end

        vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

        local Terminal = require("toggleterm.terminal").Terminal
        local utils = require("toggleterm.utils")
        local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })

        function _LAZYGIT_TOGGLE()
            lazygit:toggle()
        end

        local node = Terminal:new({ cmd = "node", hidden = true })

        function _NODE_TOGGLE()
            node:toggle()
        end

        local ncdu = Terminal:new({ cmd = "ncdu", hidden = true })

        function _NCDU_TOGGLE()
            ncdu:toggle()
        end

        local htop = Terminal:new({ cmd = "htop", hidden = true })

        function _HTOP_TOGGLE()
            htop:toggle()
        end

        local python = Terminal:new({
            cmd = "python",
            hidden = true,
            direction = "vertical",
            size = function() return vim.o.columns * 0.4 end,
        })

        function _PYTHON_TOGGLE()
            python:toggle()
        end

        -- Keymap shortcuts for terminals
        vim.keymap.set("n", "<leader>tg", function() _LAZYGIT_TOGGLE() end, { desc = "Lazygit" })
        vim.keymap.set("n", "<leader>tp", function() _PYTHON_TOGGLE() end, { desc = "Python" })
        vim.keymap.set("n", "<leader>tn", function() _NODE_TOGGLE() end, { desc = "Node" })
        vim.keymap.set("n", "<leader>th", function() _HTOP_TOGGLE() end, { desc = "Htop" })

        -- Numbered terminals for flexibility
        vim.keymap.set("n", "<leader>t1", "<cmd>1ToggleTerm direction=vertical size=60<cr>", { desc = "Term 1 (vert)" })
        vim.keymap.set("n", "<leader>t2", "<cmd>2ToggleTerm direction=horizontal<cr>", { desc = "Term 2 (horiz)" })
    end,
    keys = { "<C-\\>" }
}
