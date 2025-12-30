# Show installation environment variables
gum log --level info "Installation Environment:"

env | grep -E "^(HYPR_SETUP_CHROOT_INSTALL|HYPR_SETUP_ONLINE_INSTALL|HYPR_SETUP_USER_NAME|HYPR_SETUP_USER_EMAIL|USER|HOME|HYPR_SETUP_REPO|HYPR_SETUP_REF|HYPR_SETUP_PATH)=" | sort | while IFS= read -r var; do
  gum log --level info "  $var"
done
