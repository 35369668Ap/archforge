#!/usr/bin/env bats
load 'setup'

setup() {
  source "$ARCHFORGE_DIR/lib/core.sh"
  source "$ARCHFORGE_DIR/lib/detect.sh"
}

@test "detect_hardware sets DETECTED_CPU to Intel or AMD or Unknown" {
  detect_hardware
  [[ "$DETECTED_CPU" == "Intel" || "$DETECTED_CPU" == "AMD" || "$DETECTED_CPU" == "Unknown" ]]
}

@test "detect_hardware sets DETECTED_GPU to non-empty string" {
  detect_hardware
  [[ -n "$DETECTED_GPU" ]]
}

@test "detect_hardware sets SYSTEM_TYPE to laptop or desktop" {
  detect_hardware
  [[ "$SYSTEM_TYPE" == "laptop" || "$SYSTEM_TYPE" == "desktop" ]]
}

@test "detect_hardware sets IS_LAPTOP to true or false" {
  detect_hardware
  [[ "$IS_LAPTOP" == "true" || "$IS_LAPTOP" == "false" ]]
}

@test "detect_hardware sets DETECTED_INIT to systemd" {
  detect_hardware
  [[ "$DETECTED_INIT" == "systemd" ]]
}
