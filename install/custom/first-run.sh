# Find and execute all custom installation scripts
for f in $(find "$CUSTOM_PATH" -mindepth 2 -type f -name "first-run.sh"); do
  source "$f"
done
