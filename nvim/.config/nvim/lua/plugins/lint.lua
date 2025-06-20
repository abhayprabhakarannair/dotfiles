return {

	{
		"mfussenegger/nvim-lint",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local lint = require("lint")
			lint.linters_by_ft = {
				markdown = { "markdownlint" },
				typescript = { "eslint_d" },
				javascript = { "eslint_d" },
				html = { "eslint_d" },
				python = { "ruff" },
			}
		end,
	},
}
