# Start and configure Sunshine
echo "Starting Sunshine..."
sunshine > /dev/null 2>&1 &

echo "Waiting for Sunshine to start..."
sleep 10

local sunshine_url=$(grep "Configuration UI available" ~/.config/sunshine/sunshine.log | grep -oP "at \[\K.+(?=\])")
if [ -n "$sunshine_url" ]; then
  echo "Sunshine is running."
  echo
  echo "Press any key to launch the Sunshine configuration UI. While in there you should:"
  echo "1. Set a username and password for the web interface."
  echo "2. Register your remote Moonlight client."
  echo "3. Configure any other settings you want."
  echo
  echo "Return here to continue setup when complete."
  read -n 1 -s < /dev/tty
  omarchy-launch-webapp "$sunshine_url" > /dev/null 2>&1 &
  echo
  echo "Once you have finished configuring Sunshine, press any key to continue."
  read -n 1 -s < /dev/tty

  # Fetch icon for Sunshine configuration UI
  echo
  curl --silent --output ~/.local/share/applications/icons/sunshine-config.png \
    https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/sunshine.png

  # Add menu item for Sunshine configuration UI
  cat <<EOF > ~/.local/share/applications/sunshine-config.desktop
[Desktop Entry]
Version=1.0
Name=Sunshine Config
Comment=Sunshine Configuration UI
Exec=omarchy-launch-webapp $sunshine_url
Terminal=false
Type=Application
Icon=/home/steve/.local/share/applications/icons/sunshine-config.png
StartupNotify=true
EOF
else
  echo "Could not find the Sunshine configuration UI URL in the log file."
  echo "Press any key to continue."
  read -n 1 -s < /dev/tty
fi

# Enable Sunshine service
echo "Enabling Sunshine to start on login..."
cat <<EOF > ~/.config/autostart/sunshine.desktop
[Desktop Entry]
Type=Application
Name=Sunshine Autostart
Exec=sunshine
Terminal=false
Comment=Start Sunshine on login
EOF
