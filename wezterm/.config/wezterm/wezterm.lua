local wezterm = require('wezterm')
local config = wezterm.config_builder()

config.default_prog = { "fish" }

-- Without disabling Wayland the terminal will just crash at startup
config.enable_wayland = true
config.front_end = "WebGpu"

config.window_close_confirmation = "NeverPrompt"

config.color_scheme_dirs = { wezterm.config_dir .. 'colors' }
config.color_scheme = 'theme'

config.font = wezterm.font_with_fallback {
  'JetBrains Mono',
  'Symbols Nerd Font',
}

config.font_size = 16
config.hide_tab_bar_if_only_one_tab = true

config.window_padding = {
  left = "2cell",
  right = "2cell",
  top = "1cell",
  bottom = "1cell",
}

return config
