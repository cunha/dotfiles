return {
  {
    name = "timbersaw",
    socket_path = "Users/cunha/.local/share/wezterm/timbersaw.sock",
    proxy_command = { "ssh", "-T", "-A", "timbersaw", "wezterm", "cli", "proxy" },
    local_echo_threshold_ms = 50000,
  },
  {
    name = "slardar",
    socket_path = "Users/cunha/.local/share/wezterm/slardar.sock",
    proxy_command = { "ssh", "-T", "-A", "slardar", "wezterm", "cli", "proxy" },
    local_echo_threshold_ms = 50000,
  },
  {
    name = "rubick",
    socket_path = "Users/cunha/.local/share/wezterm/rubick.sock",
    proxy_command = { "ssh", "-T", "-A", "rubick", "wezterm", "cli", "proxy" },
    local_echo_threshold_ms = 50000,
  },
}
