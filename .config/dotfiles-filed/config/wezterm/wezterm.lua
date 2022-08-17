local wezterm = require 'wezterm'

return {
  font = wezterm.font 'JetBrains Mono',
  bold_brightens_ansi_colors = false,
  leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 },
  hide_tab_bar_if_only_one_tab = true,
  use_fancy_tab_bar = false,
  allow_win32_input_mode = true,
  enable_kitty_keyboard = false,
  enable_csi_u_key_encoding = true,
  color_scheme = "Srcery (Gogh)",
  scrollback_lines = 65000,
  enable_scroll_bar = false,
}

