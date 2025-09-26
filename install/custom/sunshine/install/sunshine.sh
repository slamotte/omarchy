echo "Installing Sunshine from LizardByte repository..."

# Add LizardByte repo to pacman.conf
if ! grep -q "^\[lizardbyte\]" /etc/pacman.conf; then
  echo "Adding LizardByte repository to pacman.conf..."
  cat <<'EOF' | sudo tee -a /etc/pacman.conf

[lizardbyte]
SigLevel = Optional
Server = https://github.com/LizardByte/pacman-repo/releases/latest/download
EOF
fi

echo "Installing Sunshine..."
sudo pacman -Sy sunshine --noconfirm

# Register a UFW application profile for Sunshine.
# This will be applied on the first boot as part of first-run.
# See https://docs.lizardbyte.dev/projects/sunshine/latest/md_docs_2configuration.html#port
sudo cp $OMARCHY_INSTALL/custom/sunshine/install/ufw-sunshine /etc/ufw/applications.d/ufw-sunshine

echo "Downloading Sunshine icon..."
icon_file=$(readlink -f ~/.local/share/applications/icons/sunshine-config.png)
curl --silent --output $icon_file https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/sunshine.png

echo "Creating desktop entry for Sunshine configuration UI..."
tee ~/.local/share/applications/sunshine-config.desktop <<EOF >/dev/null
[Desktop Entry]
Version=1.0
Name=Sunshine Config
Comment=Sunshine Configuration UI
Exec=omarchy-launch-webapp https://localhost:47990
Terminal=false
Type=Application
Icon=$icon_file
StartupNotify=true
EOF

echo "Enabling Sunshine to start on login..."
tee ~/.config/autostart/sunshine.desktop <<'EOF' >/dev/null
[Desktop Entry]
Name=Sunshine Autostart
Comment=Start Sunshine on login
Exec=bash -c "sleep 10s && sunshine"
Terminal=false
Type=Application
EOF

# Notify user to configure Sunshine on first run by prepending a notification command to welcome.sh
echo "Adding notification to configure Sunshine on first run..."
sed -i '1inotify-send -u critical "☀️ Configure Sunshine" "Click here to configure Sunshine."' $OMARCHY_INSTALL/first-run/welcome.sh

# Add handler to mako notifications to open Sunshine config in browser
tee -a ~/.local/share/omarchy/default/mako/core.ini <<'EOF'

[summary~="Configure Sunshine"]
on-button-left=exec sh -c 'omarchy-notification-dismiss "Configure Sunshine"; omarchy-launch-browser https://localhost:47990'
EOF
