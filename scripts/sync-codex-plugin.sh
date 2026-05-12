#!/usr/bin/env bash
# Sync root skills/assets into the Codex plugin package.
#
# Source of truth:
#   skills/
#   assets/
#
# Generated package copy:
#   plugins/createya-mcp/skills/
#   plugins/createya-mcp/assets/

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PLUGIN_ROOT="${ROOT}/plugins/createya-mcp"

check_sync() {
  local fail=0

  if ! diff -ruN --exclude='.DS_Store' "${ROOT}/skills" "${PLUGIN_ROOT}/skills"; then
    fail=1
  fi

  if ! diff -ruN --exclude='.DS_Store' "${ROOT}/assets" "${PLUGIN_ROOT}/assets"; then
    fail=1
  fi

  if [[ "${fail}" -ne 0 ]]; then
    echo ""
    echo "Codex plugin package is out of sync."
    echo "Run: scripts/sync-codex-plugin.sh"
    exit 1
  fi

  echo "Codex plugin package is in sync."
}

case "${1:-}" in
  --check)
    check_sync
    ;;
  "")
    rm -rf "${PLUGIN_ROOT}/skills" "${PLUGIN_ROOT}/assets"
    mkdir -p "${PLUGIN_ROOT}"
    cp -R "${ROOT}/skills" "${PLUGIN_ROOT}/skills"
    cp -R "${ROOT}/assets" "${PLUGIN_ROOT}/assets"
    echo "Synced skills/ and assets/ into plugins/createya-mcp/."
    ;;
  *)
    echo "Usage: scripts/sync-codex-plugin.sh [--check]" >&2
    exit 2
    ;;
esac
