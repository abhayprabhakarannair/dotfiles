return {
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {
			ensure_installed = {
				"lua_ls",
				"gopls",
				"pylsp",
				"ruff",
				"angularls",
				"ts_ls",
				"html",
				"cssls",
				"jsonls",
				"biome",
			},
		},
		dependencies = {
			{
				"mason-org/mason.nvim",
				opts = {
					ui = {
						icons = {
							package_installed = "✓",
							package_pending = "➜",
							package_uninstalled = "✗",
						},
					},
				},
			},
			{

				"WhoIsSethDaniel/mason-tool-installer.nvim",
				opts = { ensure_installed = { "stylua", "prettierd", "eslint_d", "markdownlint", "jsonlint" } },
			},
		},
	},
}
