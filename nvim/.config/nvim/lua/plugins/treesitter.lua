return {
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPre", "BufNewFile" },
		build = ":TSUpdate",
		main = "nvim-treesitter.configs",
		opts = {
			ensure_installed = {
				"bash",
				"diff",
				"html",
				"css",
				"scss",
				"lua",
				"luadoc",
				"markdown",
				"markdown_inline",
				"query",
				"vim",
				"vimdoc",
				"javascript",
				"typescript",
				"python",
				"go",
			},
			auto_install = true,
			highlight = {
				enable = true,
			},
			indent = { enable = true },
		},
	},
}
