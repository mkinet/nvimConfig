print("Using VSCode extension")

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- remap leader key
keymap("n", "<Space>", "", opts)
vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- yank to system clipboard
keymap({"n", "v"}, "<leader>y", '"+y', opts)

-- paste from system clipboard
-- keymap({"n", "v"}, "<leader>p", '"+p', opts)

-- better indent handling
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- move text up and down
keymap("v", "J", ":m .+1<CR>==", opts)
keymap("v", "K", ":m .-2<CR>==", opts)
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)

-- Remap j and k to move by display line without opening folds
keymap("n", "j", "gj", opts)
keymap("n", "k", "gk", opts)

-- paste preserves primal yanked piece
keymap("v", "p", '"_dP', opts)

-- removes highlighting after escaping vim search
keymap("n", "<leader><Space>", "<Esc>:noh<CR>", opts)

-- call vscode commands from neovim
-- general keymaps
keymap({"n", "v"}, "<leader>t", "<cmd>lua require('vscode').action('workbench.action.terminal.toggleTerminal')<CR>")
keymap({"n", "v"}, "<C-\\> ", "<cmd>lua require('vscode').action('workbench.action.terminal.toggleTerminal')<CR>")
-- Close terminal and focus editor with Ctrl+K
-- keymap({"t"}, "<C-k>", "<cmd>lua require('vscode').action('workbench.action.terminal.toggleTerminal')<CR><cmd>lua require('vscode').action('workbench.action.focusActiveEditorGroup')<CR>")
-- keymap({"t"}, "<leader>t", "<C-\\><C-n><cmd>lua require('vscode').action('workbench.action.terminal.toggleTerminal')<CR>")

keymap({"n", "v"}, "<leader>b", "<cmd>lua require('vscode').action('editor.debug.action.toggleBreakpoint')<CR>")
keymap({"n", "v"}, "<leader>d", "<cmd>lua require('vscode').action('editor.action.showHover')<CR>")
keymap({"n", "v"}, "<leader>a", "<cmd>lua require('vscode').action('editor.action.quickFix')<CR>")
keymap({"n", "v"}, "<leader>ll", "<cmd>lua require('vscode').action('workbench.actions.view.problems')<CR>")
keymap({"n", "v"}, "<leader>lo", "<cmd>lua require('vscode').action('editor.action.showDefinitionPreviewHover')<CR>")
keymap({"n", "v"}, "<leader>lw", "<cmd>lua require('vscode').action('editor.action.triggerParameterHints')<CR>")
keymap({"n", "v"}, "<leader>ld", "<cmd>lua require('vscode').action('editor.action.goToDeclaration')<CR>")
keymap({"n", "v"}, "<leader>lu", "<cmd>lua require('vscode').action('editor.action.showUsage')<CR>")

-- keymap({"n", "v"}, "<leader>cn", "<cmd>lua require('vscode').action('notifications.clearAll')<CR>")
-- keymap({"n", "v"}, "<leader>ff", "<cmd>lua require('vscode').action('workbench.action.quickOpen')<CR>")
-- keymap({"n", "v"}, "<leader>cp", "<cmd>lua require('vscode').action('workbench.action.showCommands')<CR>")
-- keymap({"n", "v"}, "<leader>pr", "<cmd>lua require('vscode').action('code-runner.run')<CR>")
-- keymap({"n", "v"}, "<leader>fd", "<cmd>lua require('vscode').action('editor.action.formatDocument')<CR>")

-- zen mode 
keymap({"n", "v"}, "<leader>z", "<cmd>lua require('vscode').action('workbench.action.toggleZenMode')<CR>")


-- return to previous location
keymap({"n", "v"}, "<C-t>", "<cmd>lua require('vscode').action('workbench.action.navigateBack')<CR>")

-- open/close file explorer with focus
keymap({"n"}, "<leader>es", "<cmd>lua require('vscode').action('workbench.view.explorer')<CR><cmd>lua require('vscode').action('workbench.explorer.fileView.focus')<CR>")
keymap({"n"}, "<leader>ec", "<cmd>lua require('vscode').action('workbench.action.focusActiveEditorGroup')<CR><cmd>lua require('vscode').action('workbench.action.closeSidebar')<CR>")

-- comment and uncomment
-- keymap({"n", "v"}, "<leader>c", "<cmd>lua require('vscode').action('editor.action.commentLine')<CR>")
keymap({"n"}, "<leader>c", "<cmd>lua require('vscode').action('editor.action.commentLine')<CR>")
keymap({"v"}, "<leader>c", "<cmd>lua require('vscode').action('editor.action.commentLine')<CR>")


-- format file and selection
keymap({"n"}, "<leader>p", "<cmd>lua require('vscode').action('editor.action.formatDocument')<CR>")
keymap({"v"}, "<leader>p", "<cmd>lua require('vscode').action('editor.action.formatSelection')<CR>")

-- close buffer
keymap({"n"}, "<leader>q", "<cmd>lua require('vscode').action('workbench.action.closeActiveEditor')<CR>")
-- go to next buffer
keymap({"n"}, "L", "<cmd>lua require('vscode').action('workbench.action.nextEditor')<CR>")
-- go to previous buffer
keymap({"n"}, "H", "<cmd>lua require('vscode').action('workbench.action.previousEditor')<CR>")
-- vertical split
keymap({"n"}, "<leader>|", "<cmd>lua require('vscode').action('workbench.action.splitEditorRight')<CR>")
-- horizontal split
keymap({"n"}, "<leader>-", "<cmd>lua require('vscode').action('workbench.action.splitEditorDown')<CR>")
-- close all buffer
keymap({"n"}, "<leader>Q", "<cmd>lua require('vscode').action('workbench.action.closeAllEditors')<CR>")
-- finf files
keymap({"n"}, "<leader>ff", "<cmd>lua require('vscode').action('workbench.action.quickOpen')<CR>")
-- grep in files
-- keymap({"n"}, "<leader>fg", "<cmd>lua require('vscode').action('workbench.action.findInFiles')<CR>")
-- periscope search
keymap({"n"}, "<leader>fg", "<cmd>lua require('vscode').action('periscope.search')<CR>")
-- zenmode
keymap({"n"}, "<leader>z", "<cmd>lua require('vscode').action('workbench.action.toggleZenMode')<CR>")
-- quick save
keymap({"n"}, "<leader>w", "<cmd>lua require('vscode').action('workbench.action.files.save')<CR>")
-- rename function: <leader>r
keymap({"n"}, "<leader>r", "<cmd>lua require('vscode').action('editor.action.rename')<CR>")
-- go to bottom
-- move between splits
keymap({"n"}, "<C-h>", "<cmd>lua require('vscode').action('workbench.action.navigateLeft')<CR>")
keymap({"n"}, "<C-l>", "<cmd>lua require('vscode').action('workbench.action.navigateRight')<CR>")
-- keymap({"n"}, "<C-k>", "<cmd>lua require('vscode').action('workbench.action.navigateUp')<CR>")
keymap({"n"}, "<C-j>", "<cmd>lua require('vscode').action('workbench.action.navigateDown')<CR>")

-- Folding commands mimicking Vim:
keymap("n", "za", "<cmd>lua require('vscode').action('editor.toggleFold')<CR>", opts)
keymap("n", "zA", "<cmd>lua require('vscode').action('editor.toggleFoldRecursively')<CR>", opts)
keymap("n", "zr", "<cmd>lua require('vscode').action('editor.unfold')<CR>", opts)
keymap("n", "zR", "<cmd>lua require('vscode').action('editor.unfoldAll')<CR>", opts)
keymap("n", "zm", "<cmd>lua require('vscode').action('editor.fold')<CR>", opts)
keymap("n", "zM", "<cmd>lua require('vscode').action('editor.foldAll')<CR>", opts)

vim.api.nvim_create_user_command('Gdiff', function()
    require('vscode').action('git.openChange')
end, { nargs = 0 })