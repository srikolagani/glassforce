#!/usr/bin/env bash
# Runs the swift-testing suite. On Command Line Tools-only setups (no Xcode), SwiftPM can
# intermittently fail to find the TestingMacros plugin on clean builds; pass it explicitly.
set -euo pipefail
cd "$(dirname "$0")/.."

ARGS=()
if ! xcode-select -p 2>/dev/null | grep -q "Xcode"; then
  PLUGINS="/Library/Developer/CommandLineTools/usr/lib/swift/host/plugins/testing"
  [ -d "$PLUGINS" ] && ARGS+=(-Xswiftc -plugin-path -Xswiftc "$PLUGINS")
fi
# Some Swift 6.2 multi-target runs return zero when an earlier Testing target
# failed but the last target passed. Preserve the process status AND fail on the
# runner's explicit failure summary, rather than publishing a false green.
LOG="$(mktemp "${TMPDIR:-/tmp}/glassforce-tests.XXXXXX")"
trap 'rm -f "$LOG"' EXIT
set +e
swift test ${ARGS[@]+"${ARGS[@]}"} "$@" 2>&1 | tee "$LOG"
STATUS=${PIPESTATUS[0]}
set -e
if [[ "$STATUS" -ne 0 ]]; then exit "$STATUS"; fi
if grep -Eq 'Some test targets reported failures:|[✘✗] Test run .*failed|Executed .* with [1-9][0-9]* failures' "$LOG"; then
  echo "error: Swift test reported failing tests despite exit status 0." >&2
  exit 1
fi
