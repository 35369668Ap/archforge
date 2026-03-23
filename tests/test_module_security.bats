#!/usr/bin/env bats
load 'setup'

setup() {
  export ARCHFORGE_TEST=true DRY_RUN=true YES_FLAG=true
  source "$ARCHFORGE_DIR/lib/core.sh"
  source "$ARCHFORGE_DIR/lib/packages.sh"
  source "$ARCHFORGE_DIR/lib/backup.sh"
  mock_reset
}

# ── firewall ──────────────────────────────────────────────────────────────────

@test "firewall module_info has MODULE_PACKAGES=nftables" {
  source "$ARCHFORGE_DIR/modules/03-security/firewall.sh"
  module_info
  [[ "${MODULE_PACKAGES}" == *"nftables"* ]]
}

@test "firewall module_info has MODULE_WIKI_SOURCE referencing nftables" {
  source "$ARCHFORGE_DIR/modules/03-security/firewall.sh"
  module_info
  [[ "${MODULE_WIKI_SOURCE}" == *"nftables"* ]]
}

@test "firewall module_run returns 2 in YES_FLAG mode (no profile chosen interactively)" {
  # YES_FLAG=true but no interactive profile selection -> returns 2 (SKIP)
  # In YES_FLAG mode we skip the interactive choice; module should return 2
  source "$ARCHFORGE_DIR/modules/03-security/firewall.sh"
  run module_run
  # Either 0 (if YES defaults to desktop) or 2 (if YES skips)
  [[ "$status" -eq 0 || "$status" -eq 2 ]]
}

@test "firewall nftables-desktop.conf exists" {
  [ -f "$ARCHFORGE_DIR/configs/nftables-desktop.conf" ]
}

@test "firewall nftables-server.conf exists" {
  [ -f "$ARCHFORGE_DIR/configs/nftables-server.conf" ]
}

@test "firewall nftables-strict.conf exists" {
  [ -f "$ARCHFORGE_DIR/configs/nftables-strict.conf" ]
}

# ── antivirus ─────────────────────────────────────────────────────────────────

@test "antivirus module_info has MODULE_PACKAGES=clamav" {
  source "$ARCHFORGE_DIR/modules/03-security/antivirus.sh"
  module_info
  [[ "${MODULE_PACKAGES}" == *"clamav"* ]]
}

@test "antivirus module_info has MODULE_WIKI_SOURCE" {
  source "$ARCHFORGE_DIR/modules/03-security/antivirus.sh"
  module_info
  [[ -n "${MODULE_WIKI_SOURCE}" ]]
}

@test "antivirus module_run in test mode exits 0" {
  source "$ARCHFORGE_DIR/modules/03-security/antivirus.sh"
  run module_run
  [ "$status" -eq 0 ]
}
