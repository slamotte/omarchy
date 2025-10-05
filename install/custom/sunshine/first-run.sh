echo "Before UFW status:" >> $CUSTOM_LOGS
sudo ufw status verbose >> $CUSTOM_LOGS 2>&1
echo "----------------------------------------------" >> $CUSTOM_LOGS
echo "Adding Sunshine profile to UFW..." >> $CUSTOM_LOGS
sudo ufw app update Sunshine >> $CUSTOM_LOGS 2>&1
echo "----------------------------------------------" >> $CUSTOM_LOGS
echo "Allowing Sunshine in UFW..." >> $CUSTOM_LOGS
sudo ufw allow Sunshine >> $CUSTOM_LOGS 2>&1
echo "----------------------------------------------" >> $CUSTOM_LOGS
echo "After UFW status:" >> $CUSTOM_LOGS
sudo ufw status verbose >> $CUSTOM_LOGS 2>&1
