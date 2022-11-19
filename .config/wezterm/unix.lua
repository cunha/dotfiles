return {
  {
    name = "zeusproxy",
    proxy_command = { "ssh", "-T", "-A", "zeus", "wezterm", "cli", "proxy" },
  },
}
