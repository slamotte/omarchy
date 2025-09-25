run_logged $OMARCHY_INSTALL/post-install/pacman.sh

# Run custom install scripts after base install and pacman setup
source $OMARCHY_INSTALL/custom/all.sh

source $OMARCHY_INSTALL/post-install/finished.sh
