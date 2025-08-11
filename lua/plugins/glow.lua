return {
    "ellisonleao/glow.nvim",
    init = function()
        local opts = { noremap = true, }
        vim.api.nvim_buf_set_keymap(0, "n", "<leader>m", ":Glow <cr>", opts)
    end,
    opts = {
        style = "dark",
        width = 180,
    },

}
