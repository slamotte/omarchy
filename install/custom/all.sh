# Find and execute all custom installation scripts
for f in $(find "$OMARCHY_INSTALL/custom" -mindepth 2 -type f -name "all.sh"); do
  source "$f"
done
