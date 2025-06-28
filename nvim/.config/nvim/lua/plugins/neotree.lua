return {

	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
			-- {"3rd/image.nvim", opts = {}}, -- Optional image support in preview window: See `# Preview Mode` for more information
		},
		lazy = false, -- neo-tree will lazily load itself
		---@module "neo-tree"
		---@type neotree.Config?
		opts = {
			-- fill any relevant options here
			window = {
				position = "right",
			},
			hide_root_node = true,
			retain_hidden_root_indent = true,
			default_component_configs = {
				git_status = {
					symbols = {
						-- Change type
						added = "✚",
						modified = "✱",
						deleted = "✖",
						renamed = "󰁕",
						-- Status type
						untracked = "",
						ignored = "",
						unstaged = "●",
						staged = "✓",
						conflict = "!",
					},
				},
			},
			filesystem = {
				filtered_items = {
					visible = true, -- when true, they will just be displayed differently than normal items
					hide_dotfiles = false,
					hide_gitignored = false,
					hide_by_name = {
						".git",
						"node_modules",
						"__pycache__",
						".venv",
						".DS_Store",
					},
					show_hidden_count = false,
					never_show = { ".DS_Store", "thumbs.db" },
				},
			},
		},
		keys = {
			{
				"-",
				"<cmd>Neotree toggle filesystem reveal right<CR>",
				desc = "Open parent directory in NeoTree",
			},
			{
				"e",
				"<cmd>Neotree focus filesystem right<CR>",
				desc = "Focus NeoTree Filesystem",
			},
			{
				"<leader>g",
				"<cmd>Neotree focus git_status right<CR>",
				desc = "Focus NeoTree Git Status",
			},
			{
				"<leader>b",
				"<cmd>Neotree focus buffers right<CR>",
				desc = "Focus NeoTree Buffers",
			},
		},
	},
}
