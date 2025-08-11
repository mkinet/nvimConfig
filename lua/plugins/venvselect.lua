return {
    "linux-cultist/venv-selector.nvim",
    dependencies = {
        "nvim-telescope/telescope.nvim",
        "neovim/nvim-lspconfig",
        "mfussenegger/nvim-dap",
        "mfussenegger/nvim-dap-python", --optional
    },
    lazy = true,
    branch = "regexp", -- This is the regexp branch, use this for the new version
    opts = {
        settings = {
            search = {
                cwd = false,                               -- setting this to false disables the default cwd search
                workspace = false,
                file = false,
                pipx = false,
                virtualenvs=false,
                poetry = {
                    command = "fd --full-path -HI /bin/python$ $(git rev-parse --show-toplevel)"
                }
            },
        },
    },
    keys = {
        { "<leader>v", "<cmd>VenvSelect<cr>" },
    },
}
