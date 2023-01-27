local status_ok, glow = pcall(require, "glow")
if not status_ok then
  return
end

glow.setup({
  style = "dark",
  width = 120,
})


local opts = {silent=true, noremap = true, }
vim.api.nvim_buf_set_keymap(0, "n", "<leader>m", ":Glow <cr>",   opts)
