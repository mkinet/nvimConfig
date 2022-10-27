vim.g.gruvbox_baby_function_style = "bold"
vim.g.gruvbox_baby_keyword_style = "italic"
vim.g.gruvbox_baby_background_color="dark"
vim.g.gruvbox_baby_telescope_theme = 1
-- vim.g.gruvbox_baby_highlights = {Normal = {fg = "NONE", bg = "#050000", style="underline"}}
vim.cmd [[
try
  colorscheme gruvbox-baby
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry
]]
