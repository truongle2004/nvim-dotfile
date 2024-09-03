return {
    {
        "nvim-tree/nvim-tree.lua",
        config = function()
            require("nvim-tree").setup({
                view = {
                    width = 40,
                },
            })
        end,
    },
}
