local wezterm = require 'wezterm'

local ssh_domains = {
  {
    name = 'zeus',
    -- ":port" on the end.
    remote_address = '200.19.156.22',
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
    remote_address = 'timbersaw.winet.dcc.ufmg.br',
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
  font = wezterm.font 'JetBrains Mono',
  bold_brightens_ansi_colors = false,
  launch_menu = launch_menu,
  default_prog = { 'wsl.exe', '--cd', '~', '--distribution', 'Debian' },
  leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 },
  keys = keys,
  hide_tab_bar_if_only_one_tab = true,
  use_fancy_tab_bar = false,
  allow_win32_input_mode = false,
  enable_kitty_keyboard = true,
  color_scheme = "Srcery (Gogh)",
  scrollback_lines = 65000,
  enable_scroll_bar = false,
  ssh_domains = ssh_domains,
}

