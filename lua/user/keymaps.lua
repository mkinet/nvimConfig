local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap comma as leader key
keymap("", "<,>", "<Nop>", opts)
vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Move text up and down
keymap("n", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
keymap("n", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)

-- Insert --
-- Press jk fast to enter
keymap("i", "jk", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Terminal --
-- Better terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

-- Own keymaps until I understand what whichkey does
keymap("n", "<leader>|", ":vsplit <CR>", opts)
keymap("n", "<leader>-", ":split <CR>", opts)
keymap("n", "<leader><Tab>", "gcc", term_opts)
keymap("n", "<leader>c", "gcc", term_opts)
keymap("v", "<leader><Tab>", "gc", term_opts)
keymap("v", "<leader>c", "gc", term_opts)
keymap("n","<leader>q","<cmd>Bdelete!<CR>",opts)
keymap("n","<leader><Space>",":noh<CR>",opts)
keymap("n","<leader>=","<cmd>wincmd =<CR>",opts)
-- keymap("n","<leader>p","<cmd>lua vim.lsp.buf.formatting_sync()<CR>",opts)


-- folds
-- keymap("n", "<space>", "za", opts)
-- keymap("v", "<space>", "za", opts)
-- Telescope commands
keymap("n","<leader>ff",":Telescope find_files<cr>",opts)
keymap("n","<leader>fg",":Telescope live_grep<cr>",opts)
-- TODO: this doesn't work well
-- keymap("n","<leader>fr","<cmd>lua require('telescope.builtin').find_files({cwd = '/Users/mkinet/', hidden=true, search_dirs={'.','./Documents','./Developer'}})<cr>",opts)

-- NvimTree
keymap("n","<leader>e","<cmd>NvimTreeToggle<cr>",opts)
