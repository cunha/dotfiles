return {
  {
    name = "timbersaw",
    socket_path = "Users/cunha/.local/share/wezterm/timbersaw.sock",
    proxy_command = { "ssh", "-T", "-A", "timbersaw", "wezterm", "cli", "proxy" },
    local_echo_threshold_ms = 50000,
  },
  {
    name = "zeus",
    socket_path = "Users/cunha/.local/share/wezterm/zeus.sock",
    proxy_command = { "ssh", "-T", "-A", "zeus", "wezterm", "cli", "proxy" },
    local_echo_threshold_ms = 50000,
  },
}
