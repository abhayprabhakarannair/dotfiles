return {

	{
		"mfussenegger/nvim-lint",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local lint = require("lint")
			local lint_helper_biome = require("utils.lint_helper_biome")

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

			-- Expose methods globally for manual use
			_G.extend_biome_filetypes = lint_helper_biome.extend_biome_filetypes
			_G.select_biome_linters = lint_helper_biome.select_biome_linters
		end,
	},
}
