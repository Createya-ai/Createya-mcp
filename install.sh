#!/usr/bin/env bash
# Createya — universal installer for skills + MCP server.
#
# Detects which AI CLI agents are installed (Claude Code, opencode, Codex,
# Cursor, OpenClaw) and copies all skills from this repo to the right place
# for each. Auto-discovers skills/ directory contents — no hardcoded list,
# add a new skill = drop a directory with SKILL.md and it picks up next run.
#
# Usage:
#   curl -fsSL https://api.createya.ai/install | bash -s -- crya_sk_YOUR_KEY
#   curl -fsSL https://api.createya.ai/install | bash -s -- --list
#   curl -fsSL https://api.createya.ai/install | bash -s -- crya_sk_YOUR_KEY --skills creative-director
#
# API key argument is optional (without it, MCP is registered without auth and
# will fall back to OAuth on first use). Format: crya_sk_<32hex>.

set -euo pipefail

REPO_URL="https://github.com/Createya-ai/createya-mcp"
REPO_TAG="${CREATEYA_MCP_TAG:-main}"
MCP_URL="https://api.createya.ai/mcp"

# ── Args ─────────────────────────────────────────────────────────────────────
API_KEY=""
SKILL_FILTER=""
LIST_ONLY=false

while [[ $# -gt 0 ]]; do
  case "$1" in
    --list)   LIST_ONLY=true; shift ;;
    --skills) SKILL_FILTER="$2"; shift 2 ;;
    --skills=*) SKILL_FILTER="${1#--skills=}"; shift ;;
    -h|--help)
      sed -n '1,18p' "$0"
      exit 0 ;;
    -*)
      echo "Unknown flag: $1" >&2; exit 2 ;;
    *)
      API_KEY="$1"; shift ;;
  esac
done

echo "═══════════════════════════════════════════════════════"
echo "║  Createya — skills + MCP installer                  ║"
echo "═══════════════════════════════════════════════════════"
echo ""

command -v git >/dev/null 2>&1 || { echo "✗ git is required"; exit 1; }

TEMP_DIR=$(mktemp -d)
trap 'rm -rf ${TEMP_DIR}' EXIT

echo "↓ Fetching createya-mcp (${REPO_TAG})..."
git clone --depth 1 --branch "${REPO_TAG}" "${REPO_URL}" "${TEMP_DIR}/createya-mcp" 2>/dev/null

# ── Discover available skills (any directory under skills/ with SKILL.md) ────
declare -a ALL_SKILLS=()
for d in "${TEMP_DIR}/createya-mcp/skills/"*/; do
  [[ -f "${d}SKILL.md" ]] || continue
  ALL_SKILLS+=("$(basename "$d")")
done

if [[ "${LIST_ONLY}" == true ]]; then
  echo ""
  echo "Available skills in ${REPO_URL} (${REPO_TAG}):"
  for s in "${ALL_SKILLS[@]}"; do
    desc=$(awk '/^description:/{sub(/^description: */,""); print; exit}' "${TEMP_DIR}/createya-mcp/skills/${s}/SKILL.md" | head -c 100)
    printf "  • %-22s %s\n" "${s}" "${desc}…"
  done
  echo ""
  exit 0
fi

# Apply --skills filter if given (CSV → array)
declare -a SKILLS=()
if [[ -n "${SKILL_FILTER}" ]]; then
  IFS=',' read -ra FILTER <<< "${SKILL_FILTER}"
  for want in "${FILTER[@]}"; do
    found=false
    for have in "${ALL_SKILLS[@]}"; do
      [[ "$have" == "$want" ]] && { SKILLS+=("$want"); found=true; break; }
    done
    [[ "$found" == false ]] && echo "  ⚠ skill '${want}' not found in repo, skipping"
  done
else
  SKILLS=("${ALL_SKILLS[@]}")
fi

if (( ${#SKILLS[@]} == 0 )); then
  echo "✗ No skills selected. Run with --list to see what's available."
  exit 1
fi

echo "→ Skills to install: ${SKILLS[*]}"
echo ""

# ── Helper: copy one skill into target dir, idempotent (rm + cp) ─────────────
install_skill() {
  local skill="$1" target="$2"
  # SC2115: ${var:?} fails the script if either var is empty/unset, preventing
  # an accidental `rm -rf "/<skill>"` (would nuke the filesystem) or
  # `rm -rf "<target>/"` (target deleted whole).
  rm -rf "${target:?}/${skill:?}"
  mkdir -p "${target}"
  cp -R "${TEMP_DIR}/createya-mcp/skills/${skill}" "${target}/"
}

register_codex_mcp() {
  local config_dir="${HOME}/.codex"
  local config_file="${config_dir}/config.toml"
  local tmp_file

  mkdir -p "${config_dir}"
  touch "${config_file}"
  tmp_file="$(mktemp)"

  # Replace any previous Createya config, including the old nested
  # [mcp_servers.createya.headers] format that newer Codex builds ignore.
  awk '
    /^\[mcp_servers\.createya(\.|])/{skip=1; next}
    /^\[/{skip=0}
    !skip{print}
  ' "${config_file}" > "${tmp_file}"

  {
    cat "${tmp_file}"
    printf '\n[mcp_servers.createya]\n'
    printf 'url = "%s"\n' "${MCP_URL}"
    if [[ -n "${API_KEY}" ]]; then
      printf 'http_headers = { Authorization = "Bearer %s" }\n' "${API_KEY}"
    fi
    printf 'enabled = true\n'
  } > "${config_file}"

  chmod 600 "${config_file}" 2>/dev/null || true
  rm -f "${tmp_file}"
}

INSTALLED=()
MCP_REGISTERED=false

# ── Detect agents ────────────────────────────────────────────────────────────
HAS_CLAUDE=false
HAS_AGENTS=false           # any tool that reads ~/.agents/skills/ (Codex, Cursor, OpenClaw, opencode per agentskills.io)
HAS_CODEX=false
HAS_CURSOR_LEGACY=false    # Cursor 2.x also reads ~/.cursor/skills/
HAS_OPENCLAW_LEGACY=false  # some OpenClaw builds expect ~/.openclaw/skills/

[[ -d "${HOME}/.claude" ]] || command -v claude >/dev/null 2>&1 && HAS_CLAUDE=true

if [[ -d "${HOME}/.agents" ]] \
   || command -v codex >/dev/null 2>&1 \
   || command -v cursor >/dev/null 2>&1 \
   || command -v openclaw >/dev/null 2>&1 \
   || command -v opencode >/dev/null 2>&1 \
   || [[ -d "${HOME}/.codex" ]] \
   || [[ -d "${HOME}/.cursor" ]] \
   || [[ -d "${HOME}/.openclaw" ]] \
   || [[ -d "${HOME}/.config/opencode" ]]; then
  HAS_AGENTS=true
fi

[[ -d "${HOME}/.cursor" ]]   && HAS_CURSOR_LEGACY=true
[[ -d "${HOME}/.openclaw" ]] && HAS_OPENCLAW_LEGACY=true
if [[ -d "${HOME}/.codex" ]] || command -v codex >/dev/null 2>&1; then
  HAS_CODEX=true
fi

# ── Claude Code ──────────────────────────────────────────────────────────────
if [[ "${HAS_CLAUDE}" == true ]]; then
  echo "→ Claude Code detected — installing into ~/.claude/skills/"
  for skill in "${SKILLS[@]}"; do
    install_skill "$skill" "${HOME}/.claude/skills"
  done
  INSTALLED+=("Claude Code: ~/.claude/skills/{$(IFS=,; echo "${SKILLS[*]}")}")

  if command -v claude >/dev/null 2>&1; then
    if [[ -n "${API_KEY}" ]]; then
      echo "→ Registering MCP server with your API key..."
      claude mcp add createya "${MCP_URL}" \
        --transport http \
        --header "Authorization: Bearer ${API_KEY}" \
        --scope user 2>/dev/null \
        && MCP_REGISTERED=true \
        || echo "  ⚠ MCP registration failed — run manually (see below)"
    else
      echo "→ Registering MCP server (no auth — OAuth on first use)..."
      claude mcp add createya "${MCP_URL}" \
        --transport http \
        --scope user 2>/dev/null \
        && MCP_REGISTERED=true \
        || echo "  ⚠ MCP registration failed — run manually (see below)"
    fi
    [[ "${MCP_REGISTERED}" == true ]] && INSTALLED+=("MCP: createya → ${MCP_URL}")
  fi
fi

# ── Universal ~/.agents/skills/ — Codex CLI / Cursor / OpenClaw / opencode ───
# Per agentskills.io standard, all four tools read ~/.agents/skills/<name>/SKILL.md.
if [[ "${HAS_AGENTS}" == true ]]; then
  echo "→ Non-Claude agent detected — installing into ~/.agents/skills/"
  for skill in "${SKILLS[@]}"; do
    install_skill "$skill" "${HOME}/.agents/skills"
  done
  INSTALLED+=("Codex/Cursor/OpenClaw/opencode: ~/.agents/skills/{$(IFS=,; echo "${SKILLS[*]}")}")

  # Drop AGENTS.md at user level for Codex CLI (top-of-context file).
  if [[ "${HAS_CODEX}" == true ]]; then
    mkdir -p "${HOME}/.codex"
    cp "${TEMP_DIR}/createya-mcp/AGENTS.md" "${HOME}/.codex/AGENTS.md" 2>/dev/null \
      || cp "${TEMP_DIR}/createya-mcp/AGENTS.md" "${HOME}/.agents/AGENTS.md" 2>/dev/null || true
    echo "→ Codex detected — registering MCP in ~/.codex/config.toml"
    register_codex_mcp
    MCP_REGISTERED=true
    INSTALLED+=("Codex MCP: createya → ${MCP_URL}")
  fi
fi

# Cursor 2.x legacy fallback — also looks in ~/.cursor/skills/. Mirror there
# so the skill is picked up regardless of whether the user has a fresh Cursor
# (reads ~/.agents/) or older one (reads ~/.cursor/).
if [[ "${HAS_CURSOR_LEGACY}" == true ]]; then
  for skill in "${SKILLS[@]}"; do
    install_skill "$skill" "${HOME}/.cursor/skills"
  done
  INSTALLED+=("Cursor (legacy path): ~/.cursor/skills/")
fi

# OpenClaw legacy fallback (~/.openclaw/skills/, official path).
if [[ "${HAS_OPENCLAW_LEGACY}" == true ]]; then
  for skill in "${SKILLS[@]}"; do
    install_skill "$skill" "${HOME}/.openclaw/skills"
  done
  INSTALLED+=("OpenClaw (native path): ~/.openclaw/skills/")
fi

# opencode also reads ~/.claude/skills/ — already covered if HAS_CLAUDE=true.

# ── Summary ──────────────────────────────────────────────────────────────────
echo ""
if (( ${#INSTALLED[@]} == 0 )); then
  echo "⚠ No supported agent detected."
  echo "  Supported: Claude Code, opencode, Codex CLI, Cursor, OpenClaw."
  echo "  Connect MCP manually — see configs/ in the repo."
  echo ""
  exit 0
fi

echo "✓ Installed:"
for line in "${INSTALLED[@]}"; do
  echo "   • $line"
done
echo ""

# ── Bootstrap project workspace (creative/ folders) ──────────────────────────
# The createya-batch and creative-director skills expect a project-local
# `creative/` workspace for refs / etalons / output. Create the layout on first
# install so agents have somewhere to place generated assets without guessing.
# Idempotent — only creates missing dirs, never touches existing content.
if [[ -w "$(pwd)" ]]; then
  CREATIVE_DIRS=("creative" "creative/refs" "creative/etalon" "creative/output")
  CREATED_ANY=false
  for d in "${CREATIVE_DIRS[@]}"; do
    if [[ ! -d "$d" ]]; then
      mkdir -p "$d" 2>/dev/null && CREATED_ANY=true
    fi
  done
  if [[ "${CREATED_ANY}" == true ]]; then
    # Drop a tiny README so the convention is discoverable and the folders
    # aren't an opaque mystery in the user's repo.
    if [[ ! -f "creative/README.md" ]]; then
      cat > creative/README.md <<'MDEOF'
# creative/ — Createya workspace

Standard layout used by the `createya-batch` and `creative-director` skills.

- `refs/`   — drop reference / source images here (skills read these as inputs)
- `etalon/` — locked "perfect" frames for consistency across variations
- `output/` — generated results, one folder per task (`YYYY-MM-DD-<task>/`)
  - each task folder has a `manifest.json` recording prompts, models, credits, run IDs
MDEOF
    fi
    echo "✓ Bootstrapped project workspace:"
    echo "   creative/{refs,etalon,output}/"
    echo ""
  fi
fi

if [[ "${MCP_REGISTERED}" == false ]] && [[ "${HAS_CLAUDE}" == true ]]; then
  echo "  To register the MCP server in Claude Code manually:"
  echo ""
  if [[ -n "${API_KEY}" ]]; then
    echo "  claude mcp add createya ${MCP_URL} \\"
    echo "    --transport http --header \"Authorization: Bearer crya_sk_...\" --scope user"
  else
    echo "  claude mcp add createya ${MCP_URL} \\"
    echo "    --transport http --header \"Authorization: Bearer crya_sk_...\" --scope user"
    echo ""
    echo "  Get your key: https://createya.ai/settings/api-keys"
  fi
  echo ""
fi

if [[ -z "${API_KEY}" ]] && [[ "${MCP_REGISTERED}" == true ]]; then
  echo "  ⚠ MCP registered without an API key (will OAuth on first call, or add manually):"
  echo "    claude mcp remove createya && \\"
  echo "    claude mcp add createya ${MCP_URL} \\"
  echo "      --transport http --header \"Authorization: Bearer crya_sk_...\" --scope user"
  echo ""
fi

echo "  Restart your AI agent so it picks up the new skills + MCP."
echo ""
echo "  Try in chat:"
echo "    «Generate a product photo of a yellow hoodie for e-commerce»"
echo "    «Make a lookbook shoot, 6 outfits on an AI model»"
echo ""
echo "  📚 Docs: https://createya.ai/api"
echo "  📦 Repo: ${REPO_URL}"
echo "  💬 Support: support@createya.ai"
echo ""
