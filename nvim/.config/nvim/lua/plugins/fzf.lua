return {
	{
		"ibhagwan/fzf-lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		cmd = "FzfLua",
		keys = {
			{
				"<leader>sh",
				"<cmd>FzfLua helptags<cr>",
				desc = "[S]earch [H]elp",
			},
			{
				"<leader>sk",
				"<cmd>FzfLua keymaps<cr>",
				desc = "[S]earch [K]eymaps",
			},
			{
				"<leader>sf",
				"<cmd>FzfLua files<cr>",
				desc = "[S]earch [F]iles",
			},
			{ "<leader>ss", "<cmd>FzfLua<cr>", desc = "[S]earch [S]elect FZF Lua" },
			{ "<leader>sw", "<cmd>FzfLua grep<cr>", desc = "[S]earch current [W]ord" },
			{ "<leader>sg", "<cmd>FzfLua live_grep<cr>", desc = "[S]earch by [G]rep" },
			{ "<leader>sd", "<cmd>FzfLua diagnostics_document<cr>", desc = "[S]earch [D]iagnostics" },
			{ "<leader>s.", "<cmd>FzfLua oldfiles<cr>", desc = '[S]earch Recent Files ("." for repeat)' },
			{ "<leader>sr", "<cmd>FzfLua resume<cr>", desc = "[S]earch [R]esume" },
			{ "<leader><leader>", "<cmd>FzfLua buffers<cr>", desc = "[ ] Find existing buffers" },
			{ "<leader>/", "<cmd>FzfLua lgrep_curbuf<cr>", desc = "[/] Fuzzily search in current buffer" },
			{
				"<leader>sc",
				function()
					require("fzf-lua").files({ cwd = vim.fn.expand("%:p:h") })
				end,
				desc = "[S]earch files in [C]urrent directory",
			},
		},
		config = function()
			local fzf = require("fzf-lua")
			
			-- Trouble integration
			fzf.config.defaults.actions.files["ctrl-t"] = require("trouble.sources.fzf").actions.open
			
			-- Set fzf-lua as vim.ui.select backend
			fzf.register_ui_select()
		end,
	},
}
