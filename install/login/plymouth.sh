if [ "$(plymouth-set-default-theme)" != "hypr" ]; then
  sudo mkdir -p /usr/share/plymouth/themes/hypr
  sudo cp "$HYPR_SETUP_PATH/default/plymouth"/* /usr/share/plymouth/themes/hypr/
  sudo plymouth-set-default-theme hypr
fi
