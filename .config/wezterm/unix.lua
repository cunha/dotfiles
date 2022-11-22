return {
  {
    name = "ip2as",
    socket_path = "~/.local/share/wezterm/ip2as.sock",
  },
  {
    name = "peering",
    socket_path = "~/.local/share/wezterm/peering.sock",
  },
  {
    name = "zeusproxy",
    proxy_command = { "ssh", "-T", "-A", "zeus", "wezterm", "cli", "proxy" },
  },
}
