local wezterm = require 'wezterm'

local ssh_domains = {
  {
    name = 'zeus',
    -- ":port" on the end.
    remote_address = 'zeus',
    -- no_agent_auth = false
    username = 'cunha',
    remote_wezterm_path = "/home/cunha/bin/wezterm",
    -- If true, connect to this domain automatically at startup
    -- connect_automatically = true
    -- timeout = 60
    multiplexing = 'WezTerm',
  },
  {
    name = 'timbersaw',
    -- ":port" on the end.
    remote_address = 'timbersaw',
    -- no_agent_auth = false
    username = 'cunha',
    remote_wezterm_path = "/home/cunha/bin/wezterm",
    -- If true, connect to this domain automatically at startup
    -- connect_automatically = true
    -- timeout = 60
    multiplexing = 'WezTerm',
  },
}

local keys = {
    { key = 'c', mods = 'LEADER', action = 'ShowLauncher' },
}

return {
  -- JetBrains Mono is the default
  -- font = wezterm.font 'JetBrains Mono',
  bold_brightens_ansi_colors = false,
  color_scheme = "Cunha Noctis Azureus",
  cursor_blink_rate = 500,
  cursor_blink_ease_in = "Constant",
  cursor_blink_ease_out = "Constant",
  default_cursor_style = "BlinkingBlock",
  enable_kitty_keyboard = true,
  enable_scroll_bar = false,
  hide_tab_bar_if_only_one_tab = true,
  keys = keys,
  launch_menu = launch_menu,
  leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 },
  max_tab_width = 120,
  scrollback_lines = 65000,
  ssh_domains = ssh_domains,
  use_fancy_tab_bar = false,
}
