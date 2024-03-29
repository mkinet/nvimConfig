local status_ok, zen_mode = pcall(require, "zen-mode")
if not status_ok then
  return
end

zen_mode.setup( {
        window = {
            width = 1,
            options = { }
        },
    })
vim.keymap.set("n", "<leader>z", "<Cmd>ZenMode<CR>", { noremap = true, silent = true })
