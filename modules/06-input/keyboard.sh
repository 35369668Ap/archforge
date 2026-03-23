#!/usr/bin/env bash
# modules/06-input/keyboard.sh
# shellcheck shell=bash
set -euo pipefail

# shellcheck disable=SC2154,SC1091
source "${ARCHFORGE_DIR}/lib/core.sh"

module_info() {
  MODULE_NAME="Input: Keyboard layout"
  MODULE_DESC="Set console keymap and X11 keyboard layout via localectl"
  MODULE_REQUIRES_ROOT=true
  MODULE_HW_WARN=""
  MODULE_PACKAGES=""
  MODULE_AUR_PACKAGES=""
  MODULE_WIKI_SOURCE="aur-wiki-xorg-keyboard-configuration.txt aur-wiki-linux-console-keyboard-configuration.txt"
  MODULE_DEPENDS=""
}

module_run() {
  module_info

  log_info "Current keyboard config:"
  localectl status 2>/dev/null || true

  local keymap
  if command -v fzf &>/dev/null; then
    keymap="$(localectl list-keymaps 2>/dev/null | fzf --prompt='Console keymap: ')"
  else
    read -r -p "Console keymap (e.g. us, es, de — blank to skip): " keymap
  fi

  if [[ -n "${keymap}" ]]; then
    run_cmd sudo localectl set-keymap "${keymap}"
  fi

  local x11_layout x11_variant
  read -r -p "X11 layout (e.g. us, es, de — blank to skip): " x11_layout
  if [[ -n "${x11_layout}" ]]; then
    read -r -p "X11 variant (blank for default): " x11_variant
    if [[ -n "${x11_variant}" ]]; then
      run_cmd sudo localectl set-x11-keymap "${x11_layout}" "" "${x11_variant}"
    else
      run_cmd sudo localectl set-x11-keymap "${x11_layout}"
    fi
  fi
  log_ok "Keyboard configured."
}

[[ "${BASH_SOURCE[0]}" != "${0}" ]] || module_run
