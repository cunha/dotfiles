# systemd user configuration

You should check which systemd user units are running and whether we want to disable some of them.

Use `systemctl --user enable/disable/start/restart/stop <service>` to control a service.

Use `systemctl --user list-units --state=active` to get a list of active units

To block a unit, create a link overwriting the original unit to /dev/null.  To find the original unit, use `systemctl --user status` on the unit
