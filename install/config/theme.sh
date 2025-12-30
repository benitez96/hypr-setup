# Set links for Nautilius action icons
sudo ln -snf /usr/share/icons/Adwaita/symbolic/actions/go-previous-symbolic.svg /usr/share/icons/Yaru/scalable/actions/go-previous-symbolic.svg
sudo ln -snf /usr/share/icons/Adwaita/symbolic/actions/go-next-symbolic.svg /usr/share/icons/Yaru/scalable/actions/go-next-symbolic.svg

# Setup theme links
mkdir -p ~/.config/hypr/themes
for f in $HYPR_SETUP_PATH/themes/*; do ln -nfs "$f" ~/.config/hypr/themes/; done

# Set initial theme
mkdir -p ~/.config/hypr/current
ln -snf ~/.config/hypr/themes/tokyo-night ~/.config/hypr/current/theme
ln -snf ~/.config/hypr/current/theme/backgrounds/1-scenery-pink-lakeside-sunset-lake-landscape-scenic-panorama-7680x3215-144.png ~/.config/hypr/current/background

mkdir -p ~/.config/btop/themes
ln -snf ~/.config/hypr/current/theme/btop.theme ~/.config/btop/themes/current.theme

mkdir -p ~/.config/mako
ln -snf ~/.config/hypr/current/theme/mako.ini ~/.config/mako/config
