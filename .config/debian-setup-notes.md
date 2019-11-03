# Debian Setup Notes

## TODO

* Migrate as much as possible into Ansible

## Install and configure packages

### Base utilities and configurations

```{bash}
apt-get install aptitude
aptitude update
aptitude install sudo tmux zsh vim-nox sudo apt-file ncurses-term ranger git
aptitude install --without-recommends vcsh myrepos
usermod -aG sudo cunha
```

Then copy our SSH key over and follow instructions on [GitHub/dotmr][1] to
configure our stuff:

```{bash}
ssh-add
vcsh init mr
vcsh mr remote add origin git@github.com:cunha/dotmr.git
vcsh mr pull origin master
vcsh mr branch --set-upstream-to=origin/master master
mr update
```

 [1]: https://github.com/cunha/dotmr

### Xorg

```{bash}
aptitude install xserver-xorg nodm i3 i3status i3bar xinit
aptitude install --without-recommends suckless-tools dunst
aptitude install firefox-esr chromium rxvt-unicode-256color
aptitude install xclip xdotool
aptitude install --without-recommends evince
aptitude install --without-recommends redshift
```

#### Fix touchpad scrolling

Enable natural scrolling:

```{bash}
cp .config/xord.conf.d/40-libinput.conf /usr/share/X11/xord.conf.d
```

#### Disable `ssh-agent` in X sessions

We start `gnome-keyring` instead from `.xsession`.  Comment out
`use-ssh-agent` inside `/etc/X11/Xsession.options`.

#### Keyboard configuration

Keyboard configuration is mostly stock, and is mostly in `.xsession` and
`.XCompose`. To fix acute+c on IBus, you may need to install
`ibus-table-compose` (we don't need this as we currently set GTK's input
method to `xim`).

#### Install fonts

```{bash}
aptitude install fonts-roboto msttcorefonts
```

#### Configure default browser

```{bash}
update-alternatives --config gnome-www-browser
xdg-settings set default-web-browser firefox-esr.desktop
```

### Networking

We include `network-manager-gnome` to get `nm-applet`, which is among the few
that can do WPA2-Enterprise.

```{bash}
aptitude install --without-recommends network-manager network-manager-gnome
```

### Install basic sound and bluetooth utilities

```{bash}
aptitude install pulseaudio pulseaudio-module-bluetooth blueman
aptitude install moc mplayer
```

We use `ncpamixer`, but we need to compile it by hand. It currently
(20190728) does not work properly with ncursesw6 ([issue][4]).

```{bash}
git clone https://github.com/fulhax/ncpamixer.git
aptitude install libpulse-dev cmake g++ make
USE_WIDE=1 make
```

 [4]: https://github.com/fulhax/ncpamixer/issues/29

### Install removable media manager

We launch `udiskie` from `.xsession` because we use the tray icon, it does work
on the command line too.

```{bash}
aptitude install --without-recommends udisks2 udiskie
```

### LaTeX

```{bash}
aptitude install --without-recommends texlive-base \
    texlive-bibtex-extra \
    texlive-extra-utils \
    texlive-fonts-extra \
    texlive-fonts-recommended \
    texlive-lang-english \
    texlive-lang-portuguese \
    texlive-latex-extra \
    texlive-latex-base \
    texlive-latex-recommended \
    texlive-science \
    texlive-generic-extra \
    texlive-generic-recommended \
    fonts-droid-fallback \
    ghostscript \
    lmodern \
    prosper \
    tex-gyre \
    latexmk
```

### Configure backports repository

* Add `buster-backports` to `/etc/apt/sources.list`

## Others

### PEERING

* aptitude install openvpn/bird
* systemctl disable openvpn/bird

Configure which repositories you want pulled to the new machine
removing links from .config/mr/config.d. In particular, check
whether you want dotxfiles.git.

Pull all tracked repositories: mr update. This will fail if you have
some of the files that will be pulled in your home directory. Simply
delete the files and repeat mr update.

### Install ansible

See [installation instructions][2].

 [2]: http://docs.ansible.com/ansible/latest/intro_installation.html#latest-releases-via-apt-debian

### Install docker

See [installation instructions][3].

 [3]: https://docs.docker.com/install/linux/docker-ce/debian/

### Insync

* insync-headless zsh completion provided by .config/zsh/compdef/_insync
* insync-headless used to install itself to the user's crontab,
  insync (gui) does not as of July 2019.

### Lenovo throttling fix

Disable secure boot in BIOS.

```
sudo apt install git build-essential python3-dev libdbus-glib-1-dev \
    libgirepository1.0-dev libcairo2-dev python3-venv python3-wheel
git clone https://github.com/erpalma/lenovo-throttling-fix.git
sudo ./lenovo-throttling-fix/install.sh
```



Pending lenovo throttling fix
