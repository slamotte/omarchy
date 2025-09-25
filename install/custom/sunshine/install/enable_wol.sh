echo "Enabling Wake-on-LAN for the active network interface..."
interface=$(ip -j -d link | jq -r '.[] | {ifname, operstate, address} | select(.operstate == "UP")')
if [ -n "$interface" ]; then
  interface_name=$(echo "$interface" | jq -r '.ifname')
  sudo ethtool -s "$interface_name" wol g
  mac_address=$(echo "$interface" | jq -r '.address')
  cat <<EOF | sudo tee /etc/systemd/network/10-wol.link >/dev/null
[Match]
MACAddress=$mac_address

[Link]
WakeOnLan=magic
EOF
    echo "- Wake-on-LAN enabled for interface $interface_name with MAC address $mac_address"
else
    echo "- No suitable network interface found"
fi
