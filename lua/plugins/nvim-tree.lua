return {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        local keymap = vim.api.nvim_set_keymap
        keymap("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", {})
        local opts = {
            disable_netrw = true,
            hijack_netrw = true,
            open_on_tab = false,
            hijack_cursor = false,
            update_cwd = true,
            -- update_to_buf_dir = {
            --   enable = true,
            --   auto_open = true,
            -- },
            diagnostics = {
                enable = true,
                icons = {
                    hint = "",
                    info = "",
                    warning = "",
                    error = "",
                },
            },
            update_focused_file = {
                enable = true,
                update_cwd = true,
                ignore_list = {},
            },
            system_open = {
                cmd = nil,
                args = {},
            },
            filters = {
                dotfiles = false,
                custom = {},
            },
            git = {
                enable = true,
                ignore = true,
                timeout = 500,
            },
            view = {
                adaptive_size = false,
                centralize_selection = false,
                width = 30,
                side = "left",
                number = false,
                relativenumber = false,
            },
            trash = {
                cmd = "trash",
                require_confirm = true,
            },
            actions = {
                open_file = {
                    quit_on_open = false,
                    resize_window = true,
                    window_picker = {
                        enable = false,
                    }
                },
            },
            renderer = {
                icons = {
                    glyphs = {
                        default = "",
                        symlink = "",
                        git = {
                            unstaged = "",
                            staged = "S",
                            unmerged = "",
                            renamed = "➜",
                            deleted = "",
                            untracked = "U",
                            ignored = "◌",
                        },
                        folder = {
                            default = "",
                            open = "",
                            empty = "",
                            empty_open = "",
                            symlink = "",
                        },
                    },
                },
            }
        }
        require("nvim-tree").setup(opts)
    end,
    keys = { "<leader>e" }
}
