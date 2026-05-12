# OpenAI Codex plugin

Createya can be installed in Codex as a plugin marketplace. The plugin package is stored in this repository at `plugins/createya-mcp/`.

## Install in Codex Desktop

1. Open Codex → Plugins → Add marketplace.
2. In **Source**, paste:

   ```text
   Createya-ai/Createya-mcp
   ```

3. Leave **Git ref** unchanged.
4. Leave **Selective paths** empty.
5. Click **Add marketplace**.
6. Find **Createya**, click **Install**, and complete authorization.

## Install from terminal

```bash
codex plugin marketplace add Createya-ai/Createya-mcp
```

Then open Codex → Plugins, find **Createya**, click **Install**, and complete authorization.

After install, Codex gets:

- Createya plugin card with the Createya icon
- MCP server configuration for `https://api.createya.ai/mcp`
- bundled skills: `createya`, `creative-director`, `createya-batch`, `character-sheet`

## Creative Director workspace

Codex installs the plugin and authorizes the MCP server, but it does not run
project-local shell scripts at plugin install time. The Creative Director skill
creates its per-project workspace on first use inside the current project.

When you ask Codex to use Creative Director in a project, the skill checks for
`createya/.assets-path`. If it is missing, the skill runs the bundled setup
script automatically in the current project root. The setup creates:

```text
createya/
  .assets-path
  .assets-index.json
  assets/
    models/
    products/
    locations/
    aesthetics/
    brand/
  characters/
  sessions/
logs/createya-api.jsonl
MASTER_CONTEXT.md
```

Use these folders for references:

- `createya/assets/models/` — people, faces, body references
- `createya/assets/products/` — product photos
- `createya/assets/locations/` — location references
- `createya/assets/aesthetics/` — moodboards and visual references
- `createya/assets/brand/` — logos, fonts, brand files

Manual setup, if needed:

```bash
SETUP_SCRIPT="$(find "$HOME/.codex/plugins/cache" "$HOME/.agents/skills" "$HOME/.claude/skills" \
  -path '*/creative-director/scripts/setup.sh' -type f 2>/dev/null | head -n 1)"
bash "$SETUP_SCRIPT"
```

The setup is idempotent, so it is safe to run again.

## Update

```bash
codex plugin marketplace upgrade createya-ai
```

Restart Codex after upgrading if the plugin list or skills do not refresh immediately.

## Local development

From a local clone:

```bash
codex plugin marketplace add /path/to/Createya-mcp
```

For testing an unmerged branch from GitHub:

```bash
codex plugin marketplace add Createya-ai/Createya-mcp --ref feature/codex-plugin-packaging
```

## Repository layout

- `.agents/plugins/marketplace.json` — marketplace entry that makes Createya appear in Codex Plugins UI
- `plugins/createya-mcp/.codex-plugin/plugin.json` — plugin name, icon, color, prompts, and metadata
- `plugins/createya-mcp/.mcp.json` — MCP server endpoint and OAuth scopes
- `plugins/createya-mcp/skills/` — skills bundled into the plugin

## Editing skills or assets

Root `skills/` and `assets/` are the source of truth. After editing them, sync the plugin copy:

```bash
scripts/sync-codex-plugin.sh
```

CI runs `scripts/sync-codex-plugin.sh --check` so stale plugin copies cannot be merged.

## OAuth behavior

Codex uses MCP dynamic client registration. Createya's OAuth registration endpoint must return `client_id=codex` when Codex registers with `client_name=Codex`; then the authorize page shows Codex branding and creates a Codex-scoped connected app key.
