#!/usr/bin/env bash
# Shell sample: variables, functions, conditions, loops
set -euo pipefail

APP_NAME="sample-app"
readonly MAX_RETRY=3
declare -a FILES=("a.txt" "b.txt" 'c.txt')

log() {
  local level="$1"
  shift
  echo "[$(date +%H:%M:%S)] [$level] $*"
}

check_deps() {
  for cmd in git bun cargo; do
    if ! command -v "$cmd" &>/dev/null; then
      log ERROR "Command $cmd not found"
      return 1
    fi
  done
}

main() {
  log INFO "Starting ${APP_NAME}..."
  check_deps || exit 1

  local count=0
  while [[ $count -lt $MAX_RETRY ]]; do
    count=$((count + 1))
    if curl -fsSL "https://example.com/health" -o /dev/null; then
      log INFO "Healthy after $count attempts"
      break
    fi
    sleep 2
  done

  for f in "${FILES[@]}"; do
    [[ -f "$f" ]] && cat "$f" | grep -E '^[0-9]+' | sort -u >> output.log
  done
}

main "$@"
