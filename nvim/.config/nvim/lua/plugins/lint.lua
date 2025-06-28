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
				typescriptreact = { "eslint_d" },
				javascriptreact = { "eslint_d" },
				html = { "eslint_d" },
				css = { "stylelint" },
				scss = { "stylelint" },
				python = { "ruff" },
			}
		end,
	},
}
