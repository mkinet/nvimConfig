return {
    "mfussenegger/nvim-dap-python",
    dependencies = {
        "mfussenegger/nvim-dap",
    },
    lazy = true,
    setup = function()
        require("dap-python").setup("$VIRTUAL_ENV/bin/python")
    end,
}
