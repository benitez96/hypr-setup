# Copy over Hypr Setup configs
mkdir -p ~/.config
cp -R $HYPR_SETUP_PATH/config/* ~/.config/

# Use default bashrc from Hypr Setup
cp $HYPR_SETUP_PATH/default/bashrc ~/.bashrc
