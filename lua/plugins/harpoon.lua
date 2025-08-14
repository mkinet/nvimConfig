return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local harpoon = require("harpoon")
        
        harpoon:setup({
            settings = {
                save_on_toggle = false,
                sync_on_ui_close = false,
                key = function()
                    return vim.loop.cwd()
                end,
            }
        })

        -- Set keymaps
        local keymap = vim.keymap

        keymap.set("n", "<leader>a", function() harpoon:list():add() end, { desc = "Add file to harpoon" })
        keymap.set("n", "<leader>h", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Toggle harpoon menu" })

        -- Navigate to files
        keymap.set("n", "<leader>1", function() harpoon:list():select(1) end, { desc = "Go to harpoon file 1" })
        keymap.set("n", "<leader>2", function() harpoon:list():select(2) end, { desc = "Go to harpoon file 2" })
        keymap.set("n", "<leader>3", function() harpoon:list():select(3) end, { desc = "Go to harpoon file 3" })
        keymap.set("n", "<leader>4", function() harpoon:list():select(4) end, { desc = "Go to harpoon file 4" })

        -- Toggle previous & next buffers stored within Harpoon list
        keymap.set("n", "<C-p>", function() harpoon:list():prev() end, { desc = "Go to previous harpoon file" })
        keymap.set("n", "<C-n>", function() harpoon:list():next() end, { desc = "Go to next harpoon file" })
    end,
    keys = { "<leader>a", "<leader>h", "<leader>1", "<leader>2", "<leader>3", "<leader>4", "<C-p>", "<C-n>" }
}