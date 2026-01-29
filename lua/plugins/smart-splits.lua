return {
    "mrjones2014/smart-splits.nvim",
    lazy = false,
    config = function()
        require("smart-splits").setup({
            -- Ghostty multiplexer support
            multiplexer_integration = "ghostty",
            -- Disable wrap-around (more intuitive)
            wrap_at_edge = false,
            -- Cursor follows to new pane
            cursor_follows_swapped_bufs = true,
        })

        -- Navigation keymaps (replaces default Ctrl+h/j/k/l)
        vim.keymap.set("n", "<C-h>", require("smart-splits").move_cursor_left, { desc = "Move to left split" })
        vim.keymap.set("n", "<C-j>", require("smart-splits").move_cursor_down, { desc = "Move to split below" })
        vim.keymap.set("n", "<C-k>", require("smart-splits").move_cursor_up, { desc = "Move to split above" })
        vim.keymap.set("n", "<C-l>", require("smart-splits").move_cursor_right, { desc = "Move to right split" })

        -- Resize keymaps (optional but useful)
        vim.keymap.set("n", "<A-h>", require("smart-splits").resize_left, { desc = "Resize left" })
        vim.keymap.set("n", "<A-j>", require("smart-splits").resize_down, { desc = "Resize down" })
        vim.keymap.set("n", "<A-k>", require("smart-splits").resize_up, { desc = "Resize up" })
        vim.keymap.set("n", "<A-l>", require("smart-splits").resize_right, { desc = "Resize right" })
    end,
}
