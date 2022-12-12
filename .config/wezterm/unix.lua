return {
  {
    name = "timbersaw-peering",
    socket_path = "Users/cunha/.local/share/wezterm/timbersaw-peering.sock",
    proxy_command = { "ssh", "-T", "-A", "timbersaw", "wezterm", "cli", "proxy" },
    local_echo_threshold_ms = 50000,
  },
}
