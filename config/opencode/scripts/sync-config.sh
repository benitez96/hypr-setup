#!/usr/bin/env bash
set -euo pipefail

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
user_config_dir="${HOME}/.config/opencode"

mkdir -p "${user_config_dir}"

rsync -av --delete \
  "${repo_dir}/opencode.json" "${user_config_dir}/"

rsync -av --delete \
  "${repo_dir}/skills/" "${user_config_dir}/skills/"

printf "Synced config + skills from %s -> %s\n" "${repo_dir}" "${user_config_dir}"
