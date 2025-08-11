return {
    'numToStr/Comment.nvim',
    event = { "BufReadPre", "BufNewFile" }, -- Or "VeryLazy"
    opts = {
        -- Add your custom options here, for example:
        padding = true,
        sticky = true,
        ignore = nil,
        toggler = {
          line = 'gcc',
          block = 'gbc',
        },
        operater = {
          line = 'gc',
          block = 'gb',
        },
        extra = {
          above = 'gcO',
          below = 'gco',
          eol = 'gcA',
        },
    },
    config = function(_, opts)
        -- The main setup call should be for 'Comment'
        local comment_ok, Comment = pcall(require, 'Comment')
        if not comment_ok then
            vim.notify("Comment.nvim plugin not found after loading spec!", vim.log.levels.ERROR)
            return
        end
        Comment.setup(opts)
    end,
}
