echo "Preparing to install Fedora from a minimal install"

echo "Installing Fedora groups"
sudo dnf group install admin-tools base-graphical dial-up fonts hardware-support multimedia networkmanager-submodules printing standard

echo "Installing Hyprland Packages for a SwayVM group like expirience"
sudo dnf copr enable tofik/nwg-shell
sudo dnf copr enable solopasha/hyprland

sudo dnf install hyprland hyprpaper hypridle hyprlock rofi-wayland swaync grim polkit slurp waybar wlsunset xdg-desktop-portal-wlr xorg-x11-server-Xwayland nwg-look hyprpanel hyprsunset

sudo dnf install pip
pip install pywal

echo "Installing SwayVM group addapted"
sudo dnf install nautilus blueman bolt fprintd-pam gnome-keyring-pam gnome-themes-extra gvfs gvfs-smb imv kanshi lxqt-policykit mpv pavucontrol pinentry-gnome3 playerctl pulseaudio-utils qt6-qtvirtualkeyboard qt6-qtmultimedia system-config-printer wev wl-clipboard wlr-randr xarchiver xdg-desktop-portal-gtk firefox glib2-devel

sudo dnf install gdm --setopt=install_weak_deps=False

echo "Install Ghostty and Starship"
sudo dnf copr enable pgdev/ghostty
sudo dnf install ghostty

sudo dnf copr enable atim/starship
sudo dnf install starship

sudo dnf remove kitty

echo "Install Tools"
sudo dnf install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc

sudo dnf install qalc fzf vlc inkscape flatpak texlive-scheme-full texlive-chktex okular libreoffice shotwell gimp stow cabextract xorg-x11-font-utils gvim
sudo rpm -i https://downloads.sourceforge.net/project/mscorefonts2/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm

echo "Install social"
sudo dnf install thunderbird discord

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrep
flatpak install flathub com.spotify.Client

echo "Install Others"

sudo dnf install gnome-system-monitor gnome-calendar

echo "Setup config files"
cd ~/.dotfiles2
stow hyprland/
stow terminal/

echo "Setup GDM"
cd ~/.gdm-themes/theme
sudo cp /usr/share/gnome-shell/gnome-shell-theme.gresource /usr/share/gnome-shell/gnome-shell-theme-original.gresource
sudo cp ./gnome-shell-theme.gresource /usr/share/gnome-shell

systemctl enable gdm.service
systemctl set-default graphical.target

echo "" >> ~/.bashrc
echo "# Starship" >> ~/.bashrc
echo 'eval "$(starship init bash)"' >> ~/.bashrc

echo "" >> ~/.bashrc
echo "# Vim" >> ~/.bashrc
echo "alias vim='vimx'" >> ~/.bashrc

echo "# Set up fzf key bindings and fuzzy completion" >> ~/.bashrc 
echo 'eval "$(fzf --bash)"' >> ~/.bashrc

