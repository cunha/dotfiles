# Configuring screens before firing X:
if xrandr --query | grep -Ee "^DP-1-2[^ ]* connected" > /dev/null ; then
	xrandr --output eDP-1 --dpi 144 auto
	xrandr --output DP-1-2 --above eDP-1 --dpi 144 --auto
	export GDK_DPI_SCALE=1.5
elif xrandr --query | grep -Ee "^DP-2[^ ]* connected" > /dev/null ; then
xrandr --dpi 144 --output eDP-1 --pos 640x2160 --auto --output DP-2 --pos 0x0 --auto
	export GDK_DPI_SCALE=1.5
# elif xrandr --query | grep -Ee "^HDMI-1[^ ]* connected" > /dev/null ; then
# 	xrandr --output eDP-1 --auto
# 	sleep 1s
# 	xrandr --output HDMI-1 --above eDP-1 --auto
# 	sleep 1s
# 	xrandr --dpi 96
# 	export GDK_DPI_SCALE=1.5
else
	xrandr --dpi 144
	export GDK_DPI_SCALE=1.5
fi

# export TZ='America/New_York'
# export TZ='America/Los_Angeles'
export TZ='America/Sao_Paulo'
# export TZ='Europe/Berlin'
# export TZ='Australia/Sydney'
# export TZ='Asia/Singapore'

# to get proper cedilla in ibus, install ibus-table-compose
export GTK_IM_MODULE=xim
export XMODIFIERS="@im=none"

export XDG_CONFIG_HOME=/home/cunha/.config/
export ELECTRON_TRASH=trash-cli
# export CHROMIUM_FLAGS="--enable-remote-extensions"

# This is complemented by an entry in .ssh/config that auto-adds our RSA keys
# to the forked SSH-agent
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,ssh,secrets)
export SSH_AUTH_SOCK

setxkbmap -layout us -option shift:both_capslock -option ctrl:nocaps
# xcape -t 200 -e "Control_L=Escape"
# xcape -t 200 -e "Control_R=Escape"

# These are no longer necessary as /etc/X11/Xsession.options includes
# allow-user-resources, and we include the color scheme from .Xresources:
# xrdb ~/.Xresources
# xrdb -merge ~/.config/solarized-dark.Xresources

xset -b
xsetroot -mod 2 2 -fg black -bg midnightblue

exec i3 -V >> ~/.cache/i3.log 2>&1
# exec gnome-session
# startkde
