return {
  "linux-cultist/venv-selector.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "neovim/nvim-lspconfig",
    -- "mfussenegger/nvim-dap",
    -- "mfussenegger/nvim-dap-python", --optional
  },
  ft = "python",
  opts = {
    search = {
      -- my_venvs = {
      --   -- Quote the path and use regex that specifically looks for .venv directories
      --   command = "fd 'bin/python$' $CWD --full-path --color never -HI -a -L",
      -- },
    },
    options = {
      debug = true,  -- Enable debug logging
      notify_user_on_activate = true,
    }
  },
  keys = {
    { "<leader>v", "<cmd>VenvSelect<cr>" },
  },
}
