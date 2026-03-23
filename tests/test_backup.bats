#!/usr/bin/env bats
load 'setup'

setup() {
  source "$ARCHFORGE_DIR/lib/core.sh"
  source "$ARCHFORGE_DIR/lib/backup.sh"
  export SESSION_ID="2099-01-01_120000"
  export BACKUP_BASE_DIR="/tmp/archforge-bats-backup-$$"
  mkdir -p "$BACKUP_BASE_DIR"
  # Create a test file to back up
  echo "original content" > /tmp/archforge-test-file-$$
}

teardown() {
  rm -rf "$BACKUP_BASE_DIR" /tmp/archforge-test-file-$$ /tmp/archforge-restore-src-$$
}

@test "backup_file copies regular file to session backup dir" {
  backup_file "/tmp/archforge-test-file-$$"
  local dest="${BACKUP_BASE_DIR}/${SESSION_ID}/tmp/archforge-test-file-$$"
  [ -f "$dest" ]
  run cat "$dest"
  [[ "$output" == "original content" ]]
}

@test "backup_file writes FILE entry to session.manifest" {
  backup_file "/tmp/archforge-test-file-$$"
  local manifest="${BACKUP_BASE_DIR}/${SESSION_ID}/session.manifest"
  [ -f "$manifest" ]
  run grep "TYPE=file" "$manifest"
  [ "$status" -eq 0 ]
}

@test "backup_file records MODE in manifest" {
  backup_file "/tmp/archforge-test-file-$$"
  local manifest="${BACKUP_BASE_DIR}/${SESSION_ID}/session.manifest"
  run grep "MODE=" "$manifest"
  [ "$status" -eq 0 ]
}

@test "backup_file handles symlink without dereferencing" {
  ln -sf /tmp/archforge-test-file-$$ /tmp/archforge-test-link-$$
  backup_file "/tmp/archforge-test-link-$$"
  local manifest="${BACKUP_BASE_DIR}/${SESSION_ID}/session.manifest"
  run grep "TYPE=symlink" "$manifest"
  [ "$status" -eq 0 ]
  rm -f /tmp/archforge-test-link-$$
}

@test "backup_file skips non-existent file with warning" {
  run backup_file "/tmp/does-not-exist-archforge-test-$$"
  [ "$status" -eq 0 ]
}

@test "backup_file records path in MOCK_BACKUP_LOG in test mode" {
  mock_reset
  backup_file "/tmp/archforge-test-file-$$"
  mock_backed_up "/tmp/archforge-test-file-$$"
}

@test "record_attr writes ATTR entry to manifest" {
  record_attr "/tmp/archforge-test-file-$$"
  local manifest="${BACKUP_BASE_DIR}/${SESSION_ID}/session.manifest"
  run grep "ATTR_PATH=/tmp/archforge-test-file-$$" "$manifest"
  [ "$status" -eq 0 ]
}

@test "list_sessions prints 'No backup sessions found' when base dir missing" {
  export BACKUP_BASE_DIR="/tmp/no-such-dir-archforge-$$"
  run list_sessions
  [ "$status" -eq 0 ]
  [[ "$output" == *"No backup sessions found"* ]]
}

@test "_restore_full restores a backed-up file" {
  # Set up: backup a real file
  echo "original content" > /tmp/archforge-restore-src-$$
  backup_file "/tmp/archforge-restore-src-$$"

  # Modify the source file
  echo "modified content" > /tmp/archforge-restore-src-$$

  # Restore it (disable test mode so run_cmd actually executes)
  export YES_FLAG=true
  export ARCHFORGE_TEST=false
  local session_dir="${BACKUP_BASE_DIR}/${SESSION_ID}"
  local manifest="${session_dir}/session.manifest"
  _restore_full "${session_dir}" "${manifest}"
  export ARCHFORGE_TEST=true

  # Verify original content restored
  run cat /tmp/archforge-restore-src-$$
  [ "$status" -eq 0 ]
  [[ "$output" == "original content" ]]

  # Cleanup
  rm -f /tmp/archforge-restore-src-$$
}
