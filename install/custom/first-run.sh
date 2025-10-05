# Find and execute all custom installation scripts
for f in $(find "$OMARCHY_INSTALL/custom" -mindepth 2 -type f -name "first-run.sh"); do
  echo "Executing custom first-run script: $f" >> $CUSTOM_LOGS
  source "$f"
  echo "Finished custom first-run script: $f" >> $CUSTOM_LOGS
done
