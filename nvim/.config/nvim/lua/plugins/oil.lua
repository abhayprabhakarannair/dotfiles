return {
	{
		"stevearc/oil.nvim",
		lazy = false,
		dependencies = { "nvim-tree/nvim-web-devicons" },
		keys = {
			{
				"-",
				"<cmd>Oil<CR>",
				desc = "Open parent directory",
			},
			-- Angular generation keymaps
			{
				"<leader>nc",
				function()
					require("oil.angular").generate("component")
				end,
				desc = "Generate Angular Component",
			},
			{
				"<leader>nd",
				function()
					require("oil.angular").generate("directive")
				end,
				desc = "Generate Angular Directive",
			},
			{
				"<leader>np",
				function()
					require("oil.angular").generate("pipe")
				end,
				desc = "Generate Angular Pipe",
			},
			{
				"<leader>ns",
				function()
					require("oil.angular").generate("service")
				end,
				desc = "Generate Angular Service",
			},
			{
				"<leader>ng",
				function()
					require("oil.angular").generate("guard")
				end,
				desc = "Generate Angular Guard",
			},
			{
				"<leader>ni",
				function()
					require("oil.angular").generate("interface")
				end,
				desc = "Generate Angular Interface",
			},
			{
				"<leader>ne",
				function()
					require("oil.angular").generate("enum")
				end,
				desc = "Generate Angular Enum",
			},
			{
				"<leader>nm",
				function()
					require("oil.angular").generate("module")
				end,
				desc = "Generate Angular Module",
			},
			-- Add rerun keymap
			{
				"<leader>nr",
				function()
					require("oil.angular").rerun_last_command()
				end,
				desc = "Rerun last Angular command without dry-run",
			},
		},
		config = function()
			local oil = require("oil")
			oil.setup({})

			-- Create the oil.angular module
			local angular = {}

			-- Store last command
			angular.last_command = nil

			-- Angular schematic definitions
			angular.schematics = {
				component = {
					command = "g c",
					prompt = "Component name: ",
					error = "Component name cannot be empty",
					options = {
						{ "Skip tests", "--skip-tests" },
						{ "Standalone", "--standalone" },
						{ "Inline template", "--inline-template" },
						{ "Inline style", "--inline-style" },
					},
				},
				directive = {
					command = "g d",
					prompt = "Directive name: ",
					error = "Directive name cannot be empty",
					options = {
						{ "Skip tests", "--skip-tests" },
						{ "Standalone", "--standalone" },
					},
				},
				pipe = {
					command = "g p",
					prompt = "Pipe name: ",
					error = "Pipe name cannot be empty",
					options = {
						{ "Skip tests", "--skip-tests" },
						{ "Standalone", "--standalone" },
					},
				},
				service = {
					command = "g s",
					prompt = "Service name: ",
					error = "Service name cannot be empty",
					options = {
						{ "Skip tests", "--skip-tests" },
					},
				},
				guard = {
					command = "g g",
					prompt = "Guard name: ",
					error = "Guard name cannot be empty",
					options = {
						{ "Skip tests", "--skip-tests" },
						{ "Functional", "--functional" },
					},
				},
				interface = {
					command = "g i",
					prompt = "Interface name: ",
					error = "Interface name cannot be empty",
				},
				enum = {
					command = "g e",
					prompt = "Enum name: ",
					error = "Enum name cannot be empty",
				},
				module = {
					command = "g m",
					prompt = "Module name: ",
					error = "Module name cannot be empty",
					options = {
						{ "Routing", "--routing" },
					},
				},
			}

			-- Helper functions
			local function get_user_input(prompt, validation_msg)
				local input = vim.fn.input(prompt)
				if input == "" then
					vim.notify(validation_msg, vim.log.levels.ERROR)
					return nil
				end
				return input
			end

			local function select_options(schematic_options)
				if not schematic_options then
					return ""
				end

				local selected_options = {}
				for _, option in ipairs(schematic_options) do
					local choice = vim.fn.confirm(string.format("Include %s?", option[1]), "&Yes\n&No", 2)
					if choice == 1 then
						table.insert(selected_options, option[2])
					end
				end

				return table.concat(selected_options, " ")
			end

			local function show_output(output)
				local lines = vim.split(output, "\n")
				local bufnr = vim.api.nvim_create_buf(false, true)
				vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)

				local width = 60
				local height = math.min(#lines, 20)
				local win_opts = {
					relative = "editor",
					width = width,
					height = height,
					row = (vim.o.lines - height) / 2,
					col = (vim.o.columns - width) / 2,
					style = "minimal",
					border = "rounded",
				}

				local win = vim.api.nvim_open_win(bufnr, true, win_opts)

				vim.api.nvim_buf_set_option(bufnr, "modifiable", false)
				vim.api.nvim_buf_set_keymap(bufnr, "n", "q", ":q<CR>", { noremap = true, silent = true })
				vim.api.nvim_win_set_option(win, "winhl", "Normal:Normal,FloatBorder:Special")
			end

			-- Main generation function
			function angular.generate(schematic_type)
				local schematic = angular.schematics[schematic_type]
				if not schematic then
					vim.notify("Invalid schematic type", vim.log.levels.ERROR)
					return
				end

				local current_dir = oil.get_current_dir() or vim.fn.expand("%:p:h")
				local name = get_user_input(schematic.prompt, schematic.error)

				if not name then
					return
				end

				local options = ""
				if schematic.options then
					options = select_options(schematic.options)
				end

				local project_root = vim.fn.getcwd()
				local relative_path = string.sub(current_dir, #project_root + 2)
				local artifact_path = relative_path .. "/" .. name

				-- Add --dry-run by default to the first run
				local cmd = string.format("ng %s %s %s --dry-run", schematic.command, artifact_path, options)

				-- Store the command without --dry-run for potential rerun
				angular.last_command = string.format("ng %s %s %s", schematic.command, artifact_path, options)

				local output = vim.fn.system(cmd)
				show_output(output)
			end

			-- Function to rerun last command without dry-run
			function angular.rerun_last_command()
				if not angular.last_command then
					vim.notify("No previous Angular command to rerun", vim.log.levels.ERROR)
					return
				end

				-- Confirm before executing
				local choice =
					vim.fn.confirm("Execute last command without dry-run?\n" .. angular.last_command, "&Yes\n&No", 2)

				if choice == 1 then
					local output = vim.fn.system(angular.last_command)
					show_output(output)
					oil.reload()
				end
			end

			-- Create user commands
			for schematic_type, _ in pairs(angular.schematics) do
				local command_name = "Ng" .. schematic_type:sub(1, 1):upper() .. schematic_type:sub(2)
				vim.api.nvim_create_user_command(command_name, function()
					angular.generate(schematic_type)
				end, {})
			end

			-- Add rerun command
			vim.api.nvim_create_user_command("NgRerun", angular.rerun_last_command, {})

			-- Attach the angular module to oil
			package.loaded["oil.angular"] = angular
		end,
	},
}
