# Find and execute all custom installation scripts
echo "CUSTOM_PATH is set to: $CUSTOM_PATH" >> $CUSTOM_LOGS
echo "Searching for custom first-run scripts in $CUSTOM_PATH..." >> $CUSTOM_LOGS
echo "CWD is $(pwd)" >> $CUSTOM_LOGS
echo "Expecting to find the following files:" >> $CUSTOM_LOGS
find "$CUSTOM_PATH" -mindepth 2 -type f -name "first-run.sh" >> $CUSTOM_LOGS 2>&1
echo "----------------------------------------------" >> $CUSTOM_LOGS
for f in $(find "$CUSTOM_PATH" -mindepth 2 -type f -name "first-run.sh"); do
  echo "Executing custom first-run script: $f" >> $CUSTOM_LOGS
  source "$f"
  echo "Finished custom first-run script: $f" >> $CUSTOM_LOGS
done
