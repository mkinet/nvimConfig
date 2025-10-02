return {
  "nvim-telescope/telescope.nvim",
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
     -- robust project root helper: prefer git toplevel, else buffer dir
    local function get_wd()
      local dir = utils.buffer_dir()
      -- use `-C` and quote the path
      local inside = vim.fn.system({ "bash", "-lc",
        "git -C " .. vim.fn.shellescape(dir) .. " rev-parse --is-inside-work-tree 2>/dev/null || echo false"
      }):gsub("%s+$","")
      if inside == "true" then
        local top = vim.fn.system({ "bash", "-lc",
          "git -C " .. vim.fn.shellescape(dir) .. " rev-parse --show-toplevel"
        })
        return top:gsub("%s+$","")
      end
      return dir
    end
    -- Lua-pattern, case-insensitive where needed:
    --  - escape dots with %.
    --  - use [Pp] to match both cases.
    local IGNORE = {
      "[Pp]ictures",
      "[Dd]esktop",
      "[Ll]ibrary",
      "__pycache__",
      "%%.git",               -- literal ".git"
      "%%.ipynb_checkpoints", -- literal ".ipynb_checkpoints"
      ".venv",              -- literal ".venv"
    }
    telescope.setup {
      defaults = {
        prompt_prefix = " ",
        selection_caret = " ",
        path_display = { "smart" },
      },
      pickers = {
        -- Default configuration for builtin pickers goes here:
        find_files = {
          cwd = get_wd(),
          file_ignore_patterns = IGNORE,  -- Use the IGNORE list to exclude specific patterns
          -- Use fd command to include hidden files and .env files while excluding specific directories
          find_command = { 
            "fd", 
            "--type", "f",
            "--hidden",
            "--follow",
            "--exclude", ".venv",
            "--exclude", ".git", 
            "--exclude", "__pycache__",
            "--exclude", ".ipynb_checkpoints"
          }
        },
        live_grep = {
          cwd = get_wd(),
          additional_args = function(opts)
            -- Include hidden files but respect .gitignore
            return { "--hidden", "--glob", "!.git", "--glob", "!.venv", "--glob", "!__pycache__", "--glob", "!.ipynb_checkpoints" }
          end,
          file_ignore_patterns = IGNORE,  -- Use the IGNORE list to exclude specific patterns
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
    keymap.set("n", "<leader>fc", "<cmd>Telescope git_commits<cr>", { desc = "Find todos" })
    keymap.set("n", "<leader>fh", "<cmd>Telescope git_file_history<cr>", { desc = "Search Git history" })
  end,
  keys = { "<leader>ff", "<leader>fg", "<leader>fb", "<leader>fs", "<leader>fc", "<leader>fh" }
}
