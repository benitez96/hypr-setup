# Copy over Hypr Setup configs
mkdir -p ~/.config
cp -R $HYPR_SETUP_PATH/config/* ~/.config/

# ...except the Hyprland ones: those are symlinked back to the repo so there is
# a single copy of them and edits stay in git
$HYPR_SETUP_PATH/bin/link-hypr-config

# Use default bashrc from Hypr Setup
cp $HYPR_SETUP_PATH/default/bashrc ~/.bashrc
