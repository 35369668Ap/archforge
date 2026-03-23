#!/usr/bin/env bash
# modules/07-optimization/sensors.sh
# shellcheck shell=bash
set -euo pipefail

# shellcheck source=../../lib/core.sh
# shellcheck disable=SC2154,SC1091
source "${ARCHFORGE_DIR}/lib/core.sh"
# shellcheck source=../../lib/packages.sh
# shellcheck disable=SC1091
source "${ARCHFORGE_DIR}/lib/packages.sh"

module_info() {
  MODULE_NAME="Optimization: Hardware sensors"
  MODULE_DESC="Install lm_sensors, detect chips, optionally configure fancontrol"
  MODULE_REQUIRES_ROOT=true
  MODULE_HW_WARN="Hardware-specific — results vary by system"
  MODULE_PACKAGES="lm_sensors"
  MODULE_AUR_PACKAGES=""
  MODULE_WIKI_SOURCE="aur-wiki-lm-sensors.txt aur-wiki-fan-speed-control.txt"
  MODULE_DEPENDS=""
}

module_run() {
  module_info

  pacman_install lm_sensors
  log_info "Scanning hardware sensors (this may take a moment)..."
  if [[ "${DRY_RUN:-false}" == "true" || "${ARCHFORGE_TEST:-false}" == "true" ]]; then
    run_cmd sudo sensors-detect --auto
  else
    local detect_log
    detect_log="$(mktemp)"
    trap 'rm -f "${detect_log}"' RETURN
    sudo sensors-detect --auto 2>&1 | tee "${detect_log}" > /dev/null || true
    local found_lines
    found_lines="$(grep -E '(^Driver|Loaded|Handled by driver|Found [A-Z])' "${detect_log}" || true)"
    if [[ -n "${found_lines}" ]]; then
      log_info "Detected:"
      echo "${found_lines}"
    else
      log_info "No new sensor modules detected."
    fi
  fi
  log_info "Current sensor readings:"
  sensors 2>/dev/null || log_warn "sensors command failed — reboot may be required first"

  if confirm "Configure fancontrol for fan speed management?" "y"; then
    log_info "fancontrol is included with lm_sensors — no additional package needed."
    log_warn "Run 'sudo pwmconfig' manually to configure fan curves after reboot."
  fi
  log_ok "Sensors configured."
}

[[ "${BASH_SOURCE[0]}" != "${0}" ]] || module_run
