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
Icon=/home/steve/.local/share/applications/icons/sunshine-config.png
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
