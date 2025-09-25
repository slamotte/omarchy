echo "Installing Sunshine from LizardByte repository..."

# Add LizardByte repo to user's pacman.conf AND template. Both are necessary because
# the template will overwrite /etc/pacman.conf later in post-install/pacman.sh.
pacman_conf_files=(/etc/pacman.conf ~/.local/share/omarchy/default/pacman/pacman.conf)
for pacman_conf in "${pacman_conf_files[@]}"; do
  if ! grep -q "^\[lizardbyte\]" $pacman_conf; then
    echo "Adding LizardByte repository to $pacman_conf..."
    cat <<'EOF' | sudo tee -a $pacman_conf

[lizardbyte]
SigLevel = Optional
Server = https://github.com/LizardByte/pacman-repo/releases/latest/download
EOF
  fi
done

echo "Installing Sunshine..."
sudo pacman -Sy sunshine --noconfirm

echo "Downloading Sunshine icon..."
curl --silent --output ~/.local/share/applications/icons/sunshine-config.png \
  https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/sunshine.png

echo "Creating desktop entry for Sunshine configuration UI..."
tee ~/.local/share/applications/sunshine-config.desktop <<'EOF' >/dev/null
[Desktop Entry]
Version=1.0
Name=Sunshine Config
Comment=Sunshine Configuration UI
Exec=omarchy-launch-webapp https://localhost:47990
Terminal=false
Type=Application
Icon=~/.local/share/applications/icons/sunshine-config.png
StartupNotify=true
EOF

echo "Enabling Sunshine to start on login..."
tee ~/.config/autostart/sunshine.desktop <<'EOF' >/dev/null
[Desktop Entry]
Type=Application
Name=Sunshine Autostart
Exec=sunshine
Terminal=false
Comment=Start Sunshine on login
EOF

# Notify user to configure Sunshine on first run by prepending a notification command to welcome.sh
echo "Adding notification to configure Sunshine on first run..."
sed -i '1inotify-send -u critical "☀️ Configure Sunshine" "Click here to configure Sunshine."' $OMARCHY_INSTALL/first-run/welcome.sh

# Add handler to mako notifications to open Sunshine config in browser
tee -a ~/.local/share/omarchy/default/mako/core.ini <<'EOF'

[summary~="Configure Sunshine"]
on-button-left=exec sh -c 'omarchy-notification-dismiss "Configure Sunshine"; omarchy-launch-browser https://localhost:47990'
EOF
