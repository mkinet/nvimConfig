return {
    "lewis6991/gitsigns.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        version = "*"  -- Use latest version
    },
    -- <deepseek_r1_code>
    event = "VeryLazy",  -- Delay initialization
    init = function()
        -- Manual require after startup
        vim.schedule(function()
            require('gitsigns').setup()
        end)
    end,
    -- </deepseek_r1_code>
    config = function()
        local gitsigns = require("gitsigns")
        gitsigns.setup {
            signs = {
                add          = { text = '┃' },
                change       = { text = '┃' },
                delete       = { text = '契' },
                topdelete    = { text = '契' },
                changedelete = { text = '~' },
                untracked    = { text = '┆' },
            },
            signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
            numhl = false,   -- Toggle with `:Gitsigns toggle_numhl`
            linehl = false,  -- Toggle with `:Gitsigns toggle_linehl`
            word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
            watch_gitdir = {
                interval = 1000,
                follow_files = true,
            },
            attach_to_untracked = true,
            current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
            current_line_blame_opts = {
                virt_text = true,
                virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
                delay = 1000,
                ignore_whitespace = false,
            },
            current_line_blame_formatter = '<author>, <author_time:%R>',
            sign_priority = 6,
            update_debounce = 100,
            status_formatter = nil, -- Use default
            max_file_length = 40000,
            preview_config = {
                -- Options passed to nvim_open_win
                border = "single",
                style = "minimal",
                relative = "cursor",
                row = 0,
                col = 1,
            }
        }
    end,
}
