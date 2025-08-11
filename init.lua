if vim.g.vscode then
    -- VSCode extension
    require("config.vscode")
else
    require("config.options")
    require("config.keymaps")
    require("config.lazy")
    -- ordinary Neovim
end

