# Run custom install scripts after base install
source $OMARCHY_INSTALL/custom/all.sh

# Stock post-install steps
run_logged $OMARCHY_INSTALL/post-install/pacman.sh
source $OMARCHY_INSTALL/post-install/finished.sh
