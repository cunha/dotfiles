local wezterm = require 'wezterm'
-- local unix_domains = {}
-- unix_domains = require 'unix'
local ssh_domains = {}
-- ssh_domains = require 'ssh'
local keys = require 'keys'


function get_appearance_color_scheme()
  if wezterm.gui then
    appearance = wezterm.gui.get_appearance()
    if not appearance:find 'Dark' then
      return "Catppuccin Latte"
    else
      return "Catppuccin Frappe"
    end
  end
  -- return "Cunha Noctis Azureus"
end


return {
  bold_brightens_ansi_colors = false,
  color_scheme = get_appearance_color_scheme(),
  cursor_blink_rate = 500,
  cursor_blink_ease_in = "Constant",
  cursor_blink_ease_out = "Constant",
  default_cursor_style = "BlinkingBlock",
  disable_default_key_bindings = true,
  enable_kitty_keyboard = true,
  enable_scroll_bar = false,
  -- font = wezterm.font 'JetBrains Mono' -- JetBrains Mono is the default
  font_size = 13,
  hide_tab_bar_if_only_one_tab = false,
  key_tables = keys.key_tables,
  keys = keys.keys,
  -- launch_menu = launch_menu,
  leader = { key = 'KeypadAdd', timeout_milliseconds = 1000 },
  tab_bar_at_bottom = true,
  tab_max_width = 32,
  term = "wezterm",
  scrollback_lines = 65000,
  ssh_domains = ssh_domains,
  -- unix_domains = unix_domains,
  use_fancy_tab_bar = false,
  -- debug_key_events = true,
  -- KeypadComma is raw:95
  -- KeypadDecimal is .
}
