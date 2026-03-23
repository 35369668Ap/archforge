#!/usr/bin/env bats
load 'setup'

setup() {
  export ARCHFORGE_TEST=true DRY_RUN=true YES_FLAG=true
  source "$ARCHFORGE_DIR/lib/core.sh"
  source "$ARCHFORGE_DIR/lib/packages.sh"
  source "$ARCHFORGE_DIR/lib/backup.sh"
  mock_reset
}

@test "dns module_info includes both wiki sources" {
  source "$ARCHFORGE_DIR/modules/03-security/dns.sh"
  module_info
  [[ "${MODULE_WIKI_SOURCE}" == *"domain-name-resolution"* ]]
  [[ "${MODULE_WIKI_SOURCE}" == *"dnssec"* ]]
}

@test "dns module_run exits 0 in dry-run+YES mode" {
  source "$ARCHFORGE_DIR/modules/03-security/dns.sh"
  run module_run
  [ "$status" -eq 0 ]
}

@test "dns _build_dns_config sets correct IPs for quad9" {
  source "$ARCHFORGE_DIR/modules/03-security/dns.sh"
  _build_dns_config "quad9"
  [[ "${DNS_PRIMARY}"  == "9.9.9.9 149.112.112.112" ]]
  [[ "${DNS_PRIMARY6}" == "2620:fe::fe 2620:fe::9" ]]
  [[ "${DNS_FALLBACK}" == "9.9.9.10 149.112.112.10" ]]
  [[ "${DNS_DNSSEC}"   == "yes" ]]
}

@test "dns _build_dns_config sets correct IPs for cloudflare" {
  source "$ARCHFORGE_DIR/modules/03-security/dns.sh"
  _build_dns_config "cloudflare"
  [[ "${DNS_PRIMARY}"  == "1.1.1.1 1.0.0.1" ]]
  [[ "${DNS_DNSSEC}"   == "allow-downgrade" ]]
}

@test "dns _build_dns_config sets correct IPs for adguard" {
  source "$ARCHFORGE_DIR/modules/03-security/dns.sh"
  _build_dns_config "adguard"
  [[ "${DNS_PRIMARY}"  == "94.140.14.14 94.140.15.15" ]]
}

@test "dns _select_dns_provider returns quad9 in YES_FLAG mode" {
  source "$ARCHFORGE_DIR/modules/03-security/dns.sh"
  result="$(_select_dns_provider)"
  [[ "${result}" == "quad9" ]]
}

@test "dns module_run in test mode completes without crash" {
  source "$ARCHFORGE_DIR/modules/03-security/dns.sh"
  module_run
  true
}
