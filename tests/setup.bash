#!/usr/bin/env bash
# Shared setup for all bats tests

export ARCHFORGE_DIR
ARCHFORGE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
export ARCHFORGE_TEST=true
export _BANNER_PRINTED=false
export DRY_RUN=false
export YES_FLAG=false
export SESSION_ID="2099-01-01_000000"
export LOG_FILE="/tmp/archforge-test-$$.log"
export BACKUP_BASE_DIR="/tmp/archforge-test-backups-$$"

# Mock state — FILE-BASED so values survive subshell boundaries (module_run runs in subshell)
# run_cmd() writes to MOCK_LOG_FILE; tests read it with: run cat "$MOCK_LOG_FILE"
export MOCK_LOG_FILE="/tmp/archforge-mock-$$.log"
export MOCK_BACKUP_LOG="/tmp/archforge-mock-backup-$$.log"
export MOCK_PKG_LOG="/tmp/archforge-mock-pkg-$$.log"
export MOCK_AUR_LOG="/tmp/archforge-mock-aur-$$.log"

mock_reset() {
  : > "${MOCK_LOG_FILE}"
  : > "${MOCK_BACKUP_LOG}"
  : > "${MOCK_PKG_LOG}"
  : > "${MOCK_AUR_LOG}"
}

# Helper: assert a string appears in the mock log
mock_ran() { grep -qF "$1" "${MOCK_LOG_FILE}"; }
mock_backed_up() { grep -qF "$1" "${MOCK_BACKUP_LOG}"; }
mock_installed() { grep -qF "$1" "${MOCK_PKG_LOG}"; }
mock_aur_installed() { grep -qF "$1" "${MOCK_AUR_LOG}"; }
