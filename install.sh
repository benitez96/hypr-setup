#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -eEo pipefail

export HYPR_SETUP_PATH="$HOME/.local/share/hypr"
export HYPR_SETUP_INSTALL="$HYPR_SETUP_PATH/install"
export HYPR_SETUP_INSTALL_LOG_FILE="/var/log/setup-install.log"
export PATH="$HYPR_SETUP_PATH/bin:$PATH"

# Install
source "$HYPR_SETUP_INSTALL/helpers/all.sh"
source "$HYPR_SETUP_INSTALL/preflight/all.sh"
source "$HYPR_SETUP_INSTALL/packaging/all.sh"
source "$HYPR_SETUP_INSTALL/config/all.sh"
source "$HYPR_SETUP_INSTALL/login/all.sh"
source "$HYPR_SETUP_INSTALL/post-install/all.sh"
