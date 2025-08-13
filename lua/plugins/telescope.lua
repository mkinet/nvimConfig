return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.6",
    dependencies = {
        { "nvim-lua/plenary.nvim" },
        {
            "isak102/telescope-git-file-history.nvim",
            dependencies = { "tpope/vim-fugitive" }
        }
    },
    config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")
        local builtin = require("telescope.builtin")
        local utils = require("telescope.utils")
        local gfh_actions = require("telescope").extensions.git_file_history.actions
        local function get_wd()
            -- get start directory for pickers
            -- logic is as follows :
            --  - always use the buffer directory and no the directory where vim was startedas
            --    as starting point
            --  - if the current buffer is within a git project, search the whole project
            --  - else use current buffer directory as root
            -- Note ; the -C arg to the git command is used to run the git command in a
            --      directory that is not the current working directory (remember the
            --      current buffer is not necessarily in the current working directory)
            local cmd = "git -C " .. utils.buffer_dir() .. " rev-parse --is-inside-work-tree"
            local is_git_0 = vim.fn.system(cmd)
            if string.match(is_git_0, 'true') then
                local cmd = "git -C " .. utils.buffer_dir() .. " rev-parse --show-toplevel"
                return vim.fn.systemlist(cmd)[1]
            else
                return utils.buffer_dir()
            end
        end
        telescope.setup {
            defaults = {
                prompt_prefix = " ",
                selection_caret = " ",
                path_display = { "smart" },
                file_ignore_patterns = { "Pictures", "Desktop", "Library", "__pycache__", ".git", ".ipynb_checkpoints" },
            },
            pickers = {
                -- Default configuration for builtin pickers goes here:
                find_files = {
                    cwd = get_wd(),
                    no_ignore = true,
                    hidden = true,
                },
                live_grep = {
                    cwd = get_wd(),
                    additional_args = function(opts)
                        return {"--no-ignore", "--hidden"}
                    end,
                }
                -- Now the picker_config_key will be applied every time you call this
                -- builtin picker
            },
            extensions = {
                git_file_history = {
                    -- Keymaps inside the picker
                    mappings = {
                        i = {
                            ["<C-g>"] = gfh_actions.open_in_browser,
                        },
                        n = {
                            ["<C-g>"] = gfh_actions.open_in_browser,
                        },
                    },
                    -- The command to use for opening the browser (nil or string)
                    -- If nil, it will check if xdg-open, open, start, wslview are available, in that order.
                    browser_command = nil,
                },
            },
        }
        -- set keymaps
        local keymap = vim.keymap

        keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Fuzzy find files in cwd" })
        keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Fuzzy find recent files" })
        keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find string in cwd" })
        keymap.set("n", "<leader>fs", "<cmd>Telescope git_status<cr>", { desc = "Find string under cursor in cwd" })
        keymap.set("n", "<leader>fc", "<cmd>Telescope git commits<cr>", { desc = "Find todos" })
        keymap.set("n", "<leader>fh", "<cmd>Telescope git_file_history<cr>", { desc = "Search Git history" })
    end,
    keys = { "<leader>ff", "<leader>fg", "<leader>fb", "<leader>fs", "<leader>fc", "<leader>fh" }
}
