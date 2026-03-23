#!/usr/bin/env bats
load 'setup'

setup() {
  export ARCHFORGE_TEST=true DRY_RUN=false
  # shellcheck disable=SC1091
  source "${ARCHFORGE_DIR}/lib/core.sh"
  # shellcheck disable=SC1091
  source "${ARCHFORGE_DIR}/lib/packages.sh"
  # shellcheck disable=SC1091
  source "${ARCHFORGE_DIR}/lib/backup.sh"
  # shellcheck disable=SC1091
  source "${ARCHFORGE_DIR}/modules/07-optimization/ssd.sh"
  mock_reset
}

@test "ssd _add_noatime_to_fstab idempotent when noatime already present" {
  local tmp; tmp="$(mktemp)"
  echo "UUID=abc / ext4 defaults,noatime 0 1" > "${tmp}"
  _add_noatime_to_fstab "${tmp}"
  run grep -c "noatime" "${tmp}"
  [ "${output}" -eq 1 ]
  rm "${tmp}"
}

@test "ssd _add_noatime_to_fstab adds noatime to defaults" {
  local tmp; tmp="$(mktemp)"
  echo "UUID=abc / ext4 defaults 0 1" > "${tmp}"
  _add_noatime_to_fstab "${tmp}"
  run grep "noatime" "${tmp}"
  [ "${status}" -eq 0 ]
  rm "${tmp}"
}

@test "ssd _add_noatime_to_fstab handles UUID device format" {
  local tmp; tmp="$(mktemp)"
  echo "UUID=1234-5678 / ext4 defaults 0 1" > "${tmp}"
  _add_noatime_to_fstab "${tmp}"
  run grep "noatime" "${tmp}"
  [ "${status}" -eq 0 ]
  rm "${tmp}"
}

@test "ssd _add_noatime_to_fstab does not modify non-root mounts" {
  local tmp; tmp="$(mktemp)"
  echo "UUID=abc /home ext4 defaults 0 2" > "${tmp}"
  _add_noatime_to_fstab "${tmp}"
  run grep "noatime" "${tmp}"
  [ "${status}" -ne 0 ]
  rm "${tmp}"
}
