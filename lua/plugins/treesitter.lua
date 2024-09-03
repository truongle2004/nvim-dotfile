---@diagnostic disable: missing-fields
return {
	{
		"nvim-treesitter/nvim-treesitter",
	},
	{
		"windwp/nvim-ts-autotag",
		dependencies = "nvim-treesitter/nvim-treesitter",
		config = function()
			require("nvim-ts-autotag").setup({})
			require("nvim-treesitter.configs").setup({
				highlight = {
					enable = true,
				},
			})
		end,
		lazy = true,
		event = "VeryLazy",
	},
	{
		"nvim-treesitter/playground",
		event = "BufRead",
	},
}
