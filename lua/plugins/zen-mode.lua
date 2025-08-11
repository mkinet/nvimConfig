return {
    "folke/zen-mode.nvim",
    init = function()
        vim.keymap.set("n", "<leader>z", "<Cmd>ZenMode<CR>", { noremap = true, silent = true })
    end,
    opts = {
        window = {
            width = 1,
            options = {}
        },
    },
    keys = { "<leader>z" }
}
