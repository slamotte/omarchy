echo "Start of firewall.sh..." >> $OMARCHY_PATH/install/first-run.log

# Allow nothing in, everything out
sudo ufw default deny incoming
sudo ufw default allow outgoing

# Allow ports for LocalSend
sudo ufw allow 53317/udp
sudo ufw allow 53317/tcp

# Allow SSH in
sudo ufw allow 22/tcp

# Allow Docker containers to use DNS on host
sudo ufw allow in proto udp from 172.16.0.0/12 to 172.17.0.1 port 53 comment 'allow-docker-dns'

# Turn on the firewall
echo Enabling UFW firewall... >> $OMARCHY_PATH/install/first-run.log
sudo ufw enable >> $OMARCHY_PATH/install/first-run.log 2>&1

# Turn on Docker protections
echo Enabling UFW Docker protections... >> $OMARCHY_PATH/install/first-run.log
sudo ufw-docker install >> $OMARCHY_PATH/install/first-run.log 2>&1

echo Reloading ufw... >> $OMARCHY_PATH/install/first-run.log
sudo ufw reload >> $OMARCHY_PATH/install/first-run.log 2>&1

# Maybe restart everything?
echo Restarting ufw and Docker... >> $OMARCHY_PATH/install/first-run.log
sudo systemctl restart ufw docker >> $OMARCHY_PATH/install/first-run.log 2>&1

# Enable systemd service to start on boot
echo Enabling UFW with systemctl... >> $OMARCHY_PATH/install/first-run.log
sudo systemctl enable ufw >> $OMARCHY_PATH/install/first-run.log 2>&1

echo "End of firewall.sh..." >> $OMARCHY_PATH/install/first-run.log
