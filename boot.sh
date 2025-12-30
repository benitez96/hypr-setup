#!/bin/bash

# Set install mode to online since boot.sh is used for curl installations
export HYPR_SETUP_ONLINE_INSTALL=true

ansi_art=' 
 ██╗  ██╗██╗   ██╗██████╗ ██████╗ 
 ██║  ██║╚██╗ ██╔╝██╔══██╗██╔══██╗
 ███████║ ╚████╔╝ ██████╔╝██████╔╝
 ██╔══██║  ╚██╔╝  ██╔═══╝ ██╔══██╗
 ██║  ██║   ██║   ██║     ██║  ██║
 ╚═╝  ╚═╝   ╚═╝   ╚═╝     ╚═╝  ╚═╝
                                   
     ███████╗███████╗████████╗██╗   ██╗██████╗ 
     ██╔════╝██╔════╝╚══██╔══╝██║   ██║██╔══██╗
     ███████╗█████╗     ██║   ██║   ██║██████╔╝
     ╚════██║██╔══╝     ██║   ██║   ██║██╔═══╝ 
     ███████║███████╗   ██║   ╚██████╔╝██║     
     ╚══════╝╚══════╝   ╚═╝    ╚═════╝ ╚═╝     '

clear
echo -e "\n$ansi_art\n"

sudo pacman -Syu --noconfirm --needed git

# Use custom repo if specified via environment variable or argument
# Format: user/repo or full URL
if [[ -n "$1" ]]; then
  HYPR_SETUP_REPO="$1"
elif [[ -z "$HYPR_SETUP_REPO" ]]; then
  echo -e "\e[31mError: Repository not specified\e[0m"
  echo -e "Usage: $0 [user/repo]"
  echo -e "   or: HYPR_SETUP_REPO=user/repo $0"
  echo -e "   or: curl -sSL https://raw.githubusercontent.com/USER/REPO/main/boot.sh | bash -s USER/REPO"
  exit 1
fi

# Handle full URLs or user/repo format
if [[ "$HYPR_SETUP_REPO" == http* ]]; then
  REPO_URL="$HYPR_SETUP_REPO"
else
  REPO_URL="https://github.com/${HYPR_SETUP_REPO}.git"
fi

echo -e "\nCloning Hypr Setup from: $REPO_URL"
rm -rf ~/.local/share/hypr/
git clone "$REPO_URL" ~/.local/share/hypr >/dev/null

# Always use main branch
cd ~/.local/share/hypr
git checkout main >/dev/null 2>&1 || git checkout master >/dev/null 2>&1
cd -

echo -e "\nInstallation starting..."
source ~/.local/share/hypr/install.sh

