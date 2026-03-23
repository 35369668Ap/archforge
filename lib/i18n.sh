#!/usr/bin/env bash
# lib/i18n.sh — internationalization stub, English only
# Future: load LANG_FILE based on $LANG, look up keys in it.
# shellcheck shell=bash

# ARCHFORGE_DIR is set by the caller (archforge entrypoint or tests/setup.bash)
# shellcheck disable=SC2154
LANG_FILE="${ARCHFORGE_DIR}/i18n/en.sh"
export LANG_FILE

# Translation passthrough — replace with lookup when i18n is implemented
t() {
  echo "$1"
}
