# Find and execute all custom installation scripts
echo "OMARCHY_INSTALL is set to: $OMARCHY_INSTALL" >> $CUSTOM_LOGS
echo "Searching for custom first-run scripts in $OMARCHY_INSTALL/custom/..." >> $CUSTOM_LOGS
echo "Critically, CWD is $(pwd)" >> $CUSTOM_LOGS
echo "Expecting to find the following files:" >> $CUSTOM_LOGS
find "$OMARCHY_INSTALL/custom" -mindepth 2 -type f -name "first-run.sh" >> $CUSTOM_LOGS 2>&1
echo "----------------------------------------------" >> $CUSTOM_LOG
for f in $(find "$OMARCHY_INSTALL/custom" -mindepth 2 -type f -name "first-run.sh"); do
  echo "Executing custom first-run script: $f" >> $CUSTOM_LOGS
  source "$f"
  echo "Finished custom first-run script: $f" >> $CUSTOM_LOGS
done
