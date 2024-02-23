
-- Black formatting
vim.cmd [[
    autocmd BufWritePre *.py lua vim.lsp.buf.format()
  ]]


-- shortcut for pdb
local opts = { noremap = true, silent = true }
local term_opts = { noremap = false, silent = true }
vim.api.nvim_set_keymap("n", "<leader>b", "oimport pdb; pdb.set_trace()<ESC>", opts)
vim.api.nvim_set_keymap("n", "<leader>B", "Oimport pdb; pdb.set_trace()<ESC>", opts)

vim.cmd [[
    let g:jupytext_fmt = 'py'
    let g:jupytext_style = 'hydrogen'
  ]]

-- shortcut for jupyter
vim.api.nvim_set_keymap("n", "<leader>n", "o<CR># %%<CR>", opts)

local iron = require('iron.core')

-- function get_ipython()
--   poetry_path = vim.api.nvim_exec("!poetry env info --path", true)
--   print(poetry_path)
--   if(poetry_path ~= nil)
--   then
--     command = poetry_path .. "/bin/" .. require("iron.fts.python").ipython
--   else
--     command = require("iron.fts.python").ipython 
--   end
--   return command
-- end
--
--
-- iron.add_repl_definitions{
--   python = {
--     poetry_python = {
--       -- Note that the command is a string and not a table.
--       -- This allows neovims job to find the correct binary throught the path.
--         command = get_ipython(),
--     }
--   }
-- }
-- iron.set_config{preferred = {python = "poetry_python"}}

iron.setup{
  config = {
    -- Highlights the last sent block with bold
    highlight_last = "IronLastSent",

    -- Toggling behavior is on by default.
    -- Other options are: `single` and `focus`
    visibility = require("iron.visibility").toggle,

    -- Scope of the repl
    -- By default it is one for the same `pwd`
    -- Other options are `tab_based` and `singleton`
    scope = require("iron.scope").path_based,

    -- Whether the repl buffer is a "throwaway" buffer or not
    scratch_repl = false,

    -- Automatically closes the repl window on process end
    close_window_on_exit = true,
    repl_definition = {
     -- forcing a default
      python = require("iron.fts.python").ipython,
    },
    -- Whether iron should map the `<plug>(..)` mappings
    should_map_plug = false,

    -- iron.view.curry will open a float window for the REPL.
    -- alternatively, pass a string of vimscript for opening a fixed window:
    repl_open_cmd = 'belowright 30 split',

    -- If the repl buffer is listed
    buflisted = false,
  },
  keymaps = {
    send_motion = "<leader>ix",
    visual_send = "<leader>ix",
    send_line = "<leader>il",
    interrupt = "<leader>ic",
    cr = "<leader>ir",
    exit = "<leader>iq",
    clear = "<leader>i0",
  }
}

-- custom mapping to send a hydrogen defined jupyter cell to ipython
vim.api.nvim_set_keymap("n", "<C-i>", ":IronRepl<CR>", term_opts)
vim.api.nvim_set_keymap("n", "<leader>ij", "<leader>ixah]h", term_opts)
