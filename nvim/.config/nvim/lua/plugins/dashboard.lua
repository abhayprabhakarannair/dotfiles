return {
	{
		"goolord/alpha-nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			local theme = require("alpha.themes.theta")
			local dashboard = require("alpha.themes.dashboard")
			theme.file_icons.provider = "devicons"
			theme.header.val = {} -- Remove default banner

			local quotes = {
				"★ Code is poetry written in logic",
				"▲ The best way to predict the future is to code it",
				"◆ Simplicity is the ultimate sophistication",
				"● First, solve the problem. Then, write the code",
				"▼ Any fool can write code that a computer can understand. Good programmers write code that humans can understand",
				"■ Talk is cheap. Show me the code",
				"▶ The only way to go fast, is to go well",
				"♦ Code never lies, comments sometimes do",
				"◇ Programs must be written for people to read, and only incidentally for machines to execute",
				"◈ The best error message is the one that never shows up",
				"◉ Programming isn't about what you know; it's about what you can figure out",
				"◎ Clean code always looks like it was written by someone who cares",
			}

			local function get_random_quote()
				math.randomseed(os.time())
				return quotes[math.random(#quotes)]
			end

			local function get_header_data()
				local datetime = os.date("*t")
				local day_names = { "Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat" }
				local month_names =
					{ "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec" }

				local day = day_names[datetime.wday]
				local month = month_names[datetime.month]
				local hour = datetime.hour > 12 and datetime.hour - 12 or (datetime.hour == 0 and 12 or datetime.hour)
				local time_suffix = datetime.hour >= 12 and "pm" or "am"
				local time_str = string.format("%d:%02d%s", hour, datetime.min, time_suffix)
				local date_str = string.format("%s, %s ~ %d %s %d", day, time_str, datetime.day, month, datetime.year)

				local version = vim.version()
				local nvim_version = string.format("v%d.%d.%d", version.major, version.minor, version.patch)

				return {
					welcome = "Welcome back, Abhay! • Neovim " .. nvim_version,
					datetime = "◷ " .. date_str,
				}
			end

			local quick_actions = {
				type = "group",
				val = {
					{ type = "text", val = "Quick Actions", opts = { hl = "SpecialComment", position = "center" } },
					{ type = "padding", val = 1 },
					dashboard.button("f", "◉ Find Files", ":lua require('fzf-lua').files()<CR>"),
					dashboard.button(
						"d",
						"◈ Find Dotfiles",
						":lua require('fzf-lua').files({cwd = vim.fn.expand('~/dotfiles')})<CR>"
					),
					dashboard.button("g", "◎ Live Grep", ":lua require('fzf-lua').live_grep()<CR>"),
					dashboard.button("h", "◐ Find Help", ":lua require('fzf-lua').help_tags()<CR>"),
					dashboard.button("u", "◑ Lazy Update", ":Lazy update<CR>"),
					dashboard.button("q", "◌ Quit", ":qa<CR>"),
				},
				position = "center",
			}

			-- Insert custom header elements
			table.insert(theme.config.layout, 1, { type = "padding", val = 3 })
			table.insert(theme.config.layout, 2, {
				type = "text",
				val = function()
					return get_header_data().welcome
				end,
				opts = { hl = "Title", position = "center" },
			})
			table.insert(theme.config.layout, 3, { type = "padding", val = 1 })
			table.insert(theme.config.layout, 4, {
				type = "text",
				val = function()
					return get_header_data().datetime
				end,
				opts = { hl = "Type", position = "center" },
			})
			table.insert(theme.config.layout, 5, { type = "padding", val = 1 })

			-- Insert quick actions after existing content
			table.insert(theme.config.layout, 7, { type = "padding", val = 1 })
			table.insert(theme.config.layout, 8, quick_actions)
			table.insert(theme.config.layout, 9, { type = "padding", val = 2 })

			-- Replace footer with quote
			theme.config.layout[#theme.config.layout] = {
				type = "text",
				val = get_random_quote,
				opts = { hl = "Comment", position = "center" },
			}

			require("alpha").setup(theme.config)
		end,
	},
}
