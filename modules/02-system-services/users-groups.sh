#!/usr/bin/env bash
# modules/02-system-services/users-groups.sh
# shellcheck shell=bash
set -euo pipefail

# shellcheck source=../../lib/core.sh
# shellcheck disable=SC2154,SC1091
source "${ARCHFORGE_DIR}/lib/core.sh"

module_info() {
  MODULE_NAME="System: Users and Groups"
  MODULE_DESC="Add users to common system groups (wheel, audio, video, storage, etc.)"
  MODULE_REQUIRES_ROOT=true
  MODULE_HW_WARN=""
  MODULE_PACKAGES=""
  MODULE_AUR_PACKAGES=""
  MODULE_WIKI_SOURCE="aur-wiki-user-and-groups.txt"
  MODULE_DEPENDS=""
}

module_run() {
  module_info

  # ── Determine target user ──────────────────────────────────────────────────
  local target_user
  if confirm "Configure groups for current user (${USER})?" "y"; then
    target_user="${USER}"
  else
    read -r -p "Enter username: " target_user >&2
    if [[ -z "${target_user}" ]]; then
      log_error "No username provided."
      return 1
    fi
    if ! id "${target_user}" &>/dev/null; then
      log_error "User '${target_user}' not found on this system."
      return 1
    fi
  fi

  # ── Show current membership ────────────────────────────────────────────────
  local current_membership
  current_membership="$(id -Gn "${target_user}" 2>/dev/null || echo 'unknown')"
  log_info "Current groups for ${target_user}: ${current_membership}"

  # ── Group definitions: "groupname|confirm prompt" ─────────────────────────
  local -a group_entries=(
    "wheel|Add to wheel (sudo/su access)?"
    "audio|Add to audio (direct sound device access)?"
    "video|Add to video (GPU/framebuffer access)?"
    "storage|Add to storage (removable storage devices)?"
    "optical|Add to optical (CD/DVD drives)?"
    "scanner|Add to scanner (scanner access)?"
    "games|Add to games (game save file sharing)?"
    "lp|Add to lp (printer access/CUPS)?"
    "docker|__DOCKER__"
    "libvirt|Add to libvirt (manage VMs without sudo)?"
    "wireshark|Add to wireshark (capture packets without root)?"
    "realtime|Add to realtime (real-time audio, e.g. JACK)?"
  )

  local entry grp prompt current_groups
  for entry in "${group_entries[@]}"; do
    grp="${entry%%|*}"
    prompt="${entry#*|}"

    # Skip groups not present on this system
    if ! getent group "${grp}" &>/dev/null; then
      log_skip "Group '${grp}' not found — skipping"
      continue
    fi

    # Skip if user is already a member
    current_groups="$(id -Gn "${target_user}" 2>/dev/null || true)"
    if echo " ${current_groups} " | grep -q " ${grp} "; then
      log_skip "${target_user} already in ${grp}"
      continue
    fi

    # Special handling for docker: extra security warning
    if [[ "${grp}" == "docker" ]]; then
      log_warn "docker group grants root-equivalent access. Only add trusted users."
      if confirm "Add ${target_user} to docker (root-equivalent)?"; then
        run_cmd sudo usermod -aG "${grp}" "${target_user}"
      fi
      continue
    fi

    if confirm "${prompt}" "y"; then
      run_cmd sudo usermod -aG "${grp}" "${target_user}"
    fi
  done

  # ── Re-login reminder ──────────────────────────────────────────────────────
  log_info "Group changes take effect on next login."
  log_info "Or run: newgrp <groupname> to activate immediately in current shell."

  log_ok "Group configuration for ${target_user} complete."
}

[[ "${BASH_SOURCE[0]}" != "${0}" ]] || module_run
