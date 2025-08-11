return {
    "github/copilot.vim",
    config = function()
        local opts = { noremap = true }
        vim.api.nvim_buf_set_keymap(0, "n", "<leader>cd", "<cmd>Copilot disable<CR>", opts)
        vim.api.nvim_buf_set_keymap(0, "n", "<leader>cs", "<cmd>Copilot status<CR>", opts)
        vim.api.nvim_buf_set_keymap(0, "n", "<leader>ce", "<cmd>Copilot enable<CR>", opts)
    end,
    ft = { 'lua', 'python', 'java', 'json', 'yaml','sh' },
    keys = { "<leader>cd", "<leader>cs", "<leader>ce" }
}
