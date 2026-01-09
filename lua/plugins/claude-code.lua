return {
  "greggh/claude-code.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("claude-code").setup({
      window = {
        split_ratio = 0.4, -- Percentage of screen for the terminal window (height for horizontal, width for vertical splits)
        position = "vertical",
      },
      keymaps = {
        toggle = {
          normal = "<leader>cc", -- Normal mode keymap for toggling Claude Code, false to disable
          terminal = "<leader>cc", -- Terminal mode keymap for toggling Claude Code, false to disable
          variants = {
            continue = "<leader>cC", -- Normal mode keymap for Claude Code with continue flag
            verbose = "<leader>cV", -- Normal mode keymap for Claude Code with verbose flag
          },
        },
        window_navigation = true, -- Enable window navigation keymaps (<C-h/j/k/l>)
        scrolling = true,     -- Enable scrolling keymaps (<C-f/b>) for page up/down
      }
    })
  end,
  -- keys = {
  --   { "<leader>cc", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude Code" },
  -- },
}
