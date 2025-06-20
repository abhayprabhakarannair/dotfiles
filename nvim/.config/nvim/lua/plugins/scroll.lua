return {
	{
		"karb94/neoscroll.nvim",
		opts = {
			mappings = {
				"<C-u>",
				"<C-d>",
				"<C-b>",
				"<C-f>",
				"<C-y>",
				"<C-e>",
				"zt",
				"zz",
				"zb",
			},
			hide_cursor = true, -- Hide cursor while scrolling
			stop_eof = true, -- Stop at <EOF> when scrolling down
			respect_scrolloff = false, -- Stop scrolling at scrolloff margin
			cursor_scrolls_alone = true, -- Cursor keeps scrolling if window can't
			easing_function = "linear", -- Easing function for animation
		},
	},
}
