return {
    {
        "sainnhe/sonokai",
        lazy = false,
        priority = 1000,
        config = function()
            -- load the colorscheme here
            vim.g.sonokai_style = "espresso"
            vim.g.sonokai_disable_italic = 0
            vim.g.sonokai_colors_override = { bg1 = "#050000", bg2 = "#050000" }
            vim.g.sonokai_disable_terminal_colors = 1
            vim.cmd([[colorscheme sonokai]])
        end
    },
    {
        'rose-pine/neovim',
        lazy = true,
    }
}
