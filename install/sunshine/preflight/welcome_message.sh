welcome_message() {
  step "Disclaimer and Warning"

  local width=$((TERM_WIDTH - PADDING_LEFT * 2 - 2))

  local welcome=$(gum style --border normal --margin "0" --padding "1" --align center --width $width --border-foreground "#0a0" --foreground "#0a0" <<'EOF'
Welcome to the Omarchy-Sunrise installer!

This install is identical to the official Omarchy installer, except that it enables foolproof remote access to your machine using the Moonrise client. Perfect for remote development.
EOF
  )

  local warning=$(gum style --border normal --margin "0" --padding "1" --align center --width $width --border-foreground "#ff0" --foreground "#ff0" <<'EOF'
CAVEAT EMPTOR

Unlike the official Omarchy setup, this one does NOT support disk encryption! This is because remote unlocking of encrypted disks is not yet supported. As such, your data will be stored UNENCRYPTED on disk, and could be read if someone gains physical access to it.

If this concerns you, please exit now and use the official Omarchy installer instead.
EOF
  )

  gum style --align center "$(gum join --align center --vertical "$welcome" "$warning")"

  if ! gum confirm "Proceed with installation?" --affirmative 'I accept the risks, let''s go!' --negative 'HARD NO I did not sign up for this!' --default=false; then
    abort
  fi
}

welcome_message
