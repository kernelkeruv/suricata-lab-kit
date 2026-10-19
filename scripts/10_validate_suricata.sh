#!/usr/bin/env bash
set -euo pipefail

need() { command -v "$1" >/dev/null 2>&1 || { echo "Missing dependency: $1" >&2; exit 1; }; }
need suricata

CFG="${CFG:-configs/suricata.yaml}"

if [[ ! -f "$CFG" ]]; then
  echo "Missing config: $CFG" >&2
  exit 1
fi

suricata -T -c "$CFG" -S /dev/null >/dev/null
echo "Suricata config validation ok."
