#!/usr/bin/env bash
set -Eeuo pipefail

need() { command -v "$1" >/dev/null 2>&1 || { echo "Missing dependency: $1" >&2; exit 1; }; }
need suricata

CFG="${CFG:-configs/suricata.yaml}"

if [[ ! -f "$CFG" ]]; then
  echo "Missing config: $CFG" >&2
  exit 1
fi

# Suricata -T needs a writable log directory, even for syntax-only validation.
# The caller may supply LOG_DIR; GitHub Actions provides RUNNER_TEMP.
LOG_DIR="${LOG_DIR:-${RUNNER_TEMP:-${TMPDIR:-/tmp}}}"
[[ -d "$LOG_DIR" && -w "$LOG_DIR" ]] || {
  echo "Missing or unwritable validation log directory: $LOG_DIR" >&2
  exit 1
}

suricata -T -c "$CFG" -S /dev/null -l "$LOG_DIR" >/dev/null
echo "Suricata config validation ok (syntax only, not detection coverage)."
