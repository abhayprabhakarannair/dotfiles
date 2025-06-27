local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.font = wezterm.font("JetBrainsMono Nerd Font Mono", { weight = "Bold" })

config.front_end = "OpenGL"
config.freetype_load_target = "Light"
config.freetype_render_target = "HorizontalLcd"
config.line_height = 1.1

config.initial_cols = 120
config.initial_rows = 28

config.font_size = 14
config.color_scheme = "Kanagawa (Gogh)"

return config
