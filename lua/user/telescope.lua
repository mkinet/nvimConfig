local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

local actions = require "telescope.actions"
local utils = require "telescope.utils"


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
  local cmd = "git -C "..utils.buffer_dir().." rev-parse --is-inside-work-tree"
  local is_git_0 = vim.fn.system(cmd)
  if string.match(is_git_0,'true') then
    local cmd = "git -C "..utils.buffer_dir().." rev-parse --show-toplevel"
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
    file_ignore_patterns = {"Pictures","Desktop","Library", "__pycache__",".git",".ipynb_checkpoints"},

    mappings = {
      i = {
        ["<C-n>"] = actions.cycle_history_next,
        ["<C-p>"] = actions.cycle_history_prev,

        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,

        ["<C-c>"] = actions.close,

        ["<Down>"] = actions.move_selection_next,
        ["<Up>"] = actions.move_selection_previous,

        ["<CR>"] = actions.select_default,
        ["<C-x>"] = actions.select_horizontal,
        ["<C-v>"] = actions.select_vertical,
        ["<C-t>"] = actions.select_tab,

        ["<C-u>"] = actions.preview_scrolling_up,
        ["<C-d>"] = actions.preview_scrolling_down,

        ["<PageUp>"] = actions.results_scrolling_up,
        ["<PageDown>"] = actions.results_scrolling_down,

        ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
        ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
        ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
        ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
        ["<C-l>"] = actions.complete_tag,
        ["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
      },

      n = {
        ["<esc>"] = actions.close,
        ["<CR>"] = actions.select_default,
        ["<C-x>"] = actions.select_horizontal,
        ["<C-v>"] = actions.select_vertical,
        ["<C-t>"] = actions.select_tab,

        ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
        ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
        ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
        ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

        ["j"] = actions.move_selection_next,
        ["k"] = actions.move_selection_previous,
        ["H"] = actions.move_to_top,
        ["M"] = actions.move_to_middle,
        ["L"] = actions.move_to_bottom,

        ["<Down>"] = actions.move_selection_next,
        ["<Up>"] = actions.move_selection_previous,
        ["gg"] = actions.move_to_top,
        ["G"] = actions.move_to_bottom,

        ["<C-u>"] = actions.preview_scrolling_up,
        ["<C-d>"] = actions.preview_scrolling_down,

        ["<PageUp>"] = actions.results_scrolling_up,
        ["<PageDown>"] = actions.results_scrolling_down,

        ["?"] = actions.which_key,
      },
    },
  },
  pickers = {
    -- Default configuration for builtin pickers goes here:
    find_files = {
        cwd = get_wd() ,
    },
    live_grep = {
        cwd = get_wd(),
    }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
  },
  extensions = {
    -- Your extension configuration goes here:
    -- extension_name = {
    --   extension_config_key = value,
    -- }
    -- please take a look at the readme of the extension you want to configure
  },
}
