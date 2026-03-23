#!/usr/bin/env bash
# lib/detect.sh — hardware detection, runs once at startup
# shellcheck shell=bash

detect_hardware() {
  # CPU: parse vendor_id from /proc/cpuinfo
  local vendor cpuinfo_line
  cpuinfo_line="$(grep -m1 'vendor_id' /proc/cpuinfo 2>/dev/null)" || cpuinfo_line=''
  vendor="$(awk '{print $3}' <<< "${cpuinfo_line}")"
  case "${vendor}" in
    GenuineIntel) DETECTED_CPU="Intel"   ;;
    AuthenticAMD) DETECTED_CPU="AMD"     ;;
    *)            DETECTED_CPU="Unknown" ;;
  esac
  export DETECTED_CPU

  # GPU: parse lspci output for display controllers
  local gpu_info lspci_out
  lspci_out="$(lspci 2>/dev/null)" || lspci_out=''
  gpu_info="$(grep -iE 'vga|3d|display' <<< "${lspci_out}")" || gpu_info=''
  if echo "${gpu_info}" | grep -qi 'nvidia'; then
    DETECTED_GPU="NVIDIA"
  elif echo "${gpu_info}" | grep -qiE 'amd|radeon'; then
    DETECTED_GPU="AMD"
  elif echo "${gpu_info}" | grep -qi 'intel'; then
    DETECTED_GPU="Intel"
  else
    DETECTED_GPU="Unknown"
  fi
  # Detect multiple GPUs (e.g. Optimus laptop)
  local gpu_count
  gpu_count="$(echo "${gpu_info}" | grep -c '.')" || gpu_count=0
  if [[ "${gpu_count}" -gt 1 ]]; then
    DETECTED_GPU="Multiple (${DETECTED_GPU})"
  fi
  export DETECTED_GPU

  # Laptop detection: check for battery in /sys
  if compgen -G "/sys/class/power_supply/BAT*/present" > /dev/null 2>&1; then
    IS_LAPTOP=true
    SYSTEM_TYPE="laptop"
  else
    IS_LAPTOP=false
    SYSTEM_TYPE="desktop"
  fi
  export IS_LAPTOP SYSTEM_TYPE
  export DETECTED_INIT="systemd"
}
