#!/usr/bin/env bash
# modules/06-input/libinput.sh
# shellcheck shell=bash
set -euo pipefail

# shellcheck disable=SC2154,SC1091
source "${ARCHFORGE_DIR}/lib/core.sh"
# shellcheck disable=SC1091
source "${ARCHFORGE_DIR}/lib/backup.sh"

module_info() {
  MODULE_NAME="Input: libinput (touchpad/mouse)"
  MODULE_DESC="Configure tap-to-click, natural scroll, acceleration, TrackPoint"
  MODULE_REQUIRES_ROOT=true
  MODULE_HW_WARN=""
  MODULE_PACKAGES=""
  MODULE_AUR_PACKAGES=""
  MODULE_WIKI_SOURCE="aur-wiki-libinput.txt aur-wiki-TrackPoint.txt aur-wiki-mouse-buttons.txt"
  MODULE_DEPENDS=""
}

module_run() {
  module_info

  local conf_file="/etc/X11/xorg.conf.d/40-libinput.conf"
  backup_file "${conf_file}"

  local tap natural_scroll accel_profile="adaptive"
  if confirm "Enable tap-to-click?" "y"; then tap="true"; else tap="false"; fi
  if confirm "Enable natural scrolling?" "y"; then natural_scroll="true"; else natural_scroll="false"; fi

  echo "Acceleration profile: [1] adaptive (default)  [2] flat"
  local ap_choice
  read -r -p "Choice [1]: " ap_choice
  [[ "${ap_choice:-1}" == "2" ]] && accel_profile="flat"

  local tmp
  tmp="$(mktemp)"
  trap 'rm -f "${tmp}"' RETURN

  run_cmd sudo mkdir -p "$(dirname "${conf_file}")"

  cat > "${tmp}" <<EOF
Section "InputClass"
    Identifier "libinput touchpad"
    MatchIsTouchpad "on"
    Driver "libinput"
    Option "Tapping" "${tap}"
    Option "NaturalScrolling" "${natural_scroll}"
    Option "AccelProfile" "${accel_profile}"
EndSection
EOF

  # ThinkPad TrackPoint
  if grep -qi thinkpad /sys/devices/virtual/dmi/id/product_name 2>/dev/null; then
    log_info "ThinkPad detected — configuring TrackPoint"
    cat >> "${tmp}" <<'EOF'

Section "InputClass"
    Identifier "libinput TrackPoint"
    MatchIsPointer "on"
    MatchProduct "TrackPoint"
    Driver "libinput"
    # AccelSpeed not set: wiki sources do not document a recommended value for TrackPoint.
    # Adjust manually if needed, e.g.: Option "AccelSpeed" "0.5"
EndSection
EOF
  fi

  run_cmd sudo cp "${tmp}" "${conf_file}"
  log_ok "libinput configured."
  log_info "Xorg config written to /etc/X11/xorg.conf.d/40-libinput.conf"
  log_info "If using Wayland (Hyprland/Sway), input is configured per-compositor — see your compositor's input settings instead of this file"
}

[[ "${BASH_SOURCE[0]}" != "${0}" ]] || module_run
