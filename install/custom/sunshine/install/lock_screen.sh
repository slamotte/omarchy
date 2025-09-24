echo "Configuring automatic screen lock after login..."
mkdir -p ~/.config/autostart/
tee ~/.config/autostart/lock-screen.desktop <<'EOF' > /dev/null
[Desktop Entry]
Type=Application
Name=Lock screen immediately after login
Exec=hyprlock
EOF
