source $HYPR_SETUP_INSTALL/preflight/guard.sh
source $HYPR_SETUP_INSTALL/preflight/begin.sh
run_logged $HYPR_SETUP_INSTALL/preflight/show-env.sh
run_logged $HYPR_SETUP_INSTALL/preflight/pacman.sh
run_logged $HYPR_SETUP_INSTALL/preflight/first-run-mode.sh
run_logged $HYPR_SETUP_INSTALL/preflight/disable-mkinitcpio.sh
