#!/usr/bin/env bats
load 'setup'

setup() {
  source "$ARCHFORGE_DIR/lib/core.sh"
}

@test "log_ok outputs OK tag" {
  run log_ok "hello"
  [[ "$output" == *"OK"* ]]
  [[ "$output" == *"hello"* ]]
}

@test "log_error outputs ERROR tag" {
  run log_error "bad thing"
  [[ "$output" == *"ERROR"* ]]
}

@test "log_dry outputs DRYRUN tag" {
  run log_dry "would do X"
  [[ "$output" == *"DRYRUN"* ]]
}

@test "run_cmd executes in normal mode" {
  export DRY_RUN=false
  export ARCHFORGE_TEST=false
  run run_cmd echo "executed"
  [ "$status" -eq 0 ]
  [[ "$output" == *"executed"* ]]
}

@test "run_cmd skips execution in dry-run mode" {
  export DRY_RUN=true
  run run_cmd touch /tmp/archforge-should-not-exist-$$
  [ "$status" -eq 0 ]
  [ ! -f "/tmp/archforge-should-not-exist-$$" ]
  [[ "$output" == *"DRYRUN"* ]]
}

@test "run_cmd writes to MOCK_LOG_FILE in test mode" {
  export ARCHFORGE_TEST=true
  export DRY_RUN=false
  local tmp_log
  tmp_log="$(mktemp)"
  export MOCK_LOG_FILE="$tmp_log"
  run_cmd echo "mock-test-command"
  grep -qF "echo mock-test-command" "$tmp_log"
  rm -f "$tmp_log"
}

@test "confirm returns 0 when YES_FLAG is true" {
  export YES_FLAG=true
  run confirm "question?"
  [ "$status" -eq 0 ]
}

@test "confirm returns 0 when DRY_RUN is true" {
  export DRY_RUN=true
  run confirm "question?"
  [ "$status" -eq 0 ]
}
