return {
    "linux-cultist/venv-selector.nvim",
    dependencies = {
        "nvim-telescope/telescope.nvim",
        "neovim/nvim-lspconfig",
    },
    ft = "python",
    opts = {
        options = {
            notify_user_on_activate = true,
            enable_cached_venvs = false,  -- DISABLE auto-activation on startup!
        }
    },
    keys = {
        { "<leader>v", "<cmd>VenvSelect<cr>" },
    },
}
