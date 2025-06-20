return {
	cmd = { "pylsp" },
	filetypes = { "python" },
	root_markers = {
		"pyproject.toml",
		"setup.py",
		"setup.cfg",
		"requirements.txt",
		"Pipfile",
		".git",
	},
	settings = {
		pylsp = {
			configurationSources = {},
			plugins = {
				rope_autoimport = { enabled = true },
				ruff = {
					enabled = true, -- Enable the plugin
					formatEnabled = true, -- Enable formatting using ruffs formatter
					executable = "ruff",
				},
				pycodestyle = {
					enabled = false,
				},
				mccabe = {
					enabled = false,
				},
				pyflakes = {
					enabled = false,
				},
				autopep8 = {
					enabled = false,
				},
				black = {
					enabled = false,
				},
				flake8 = {
					enabled = false,
				},
				yapf = {
					enabled = false,
				},
			},
		},
	},
}
