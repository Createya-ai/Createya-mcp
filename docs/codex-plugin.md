# OpenAI Codex plugin

Createya can be installed in Codex as a plugin marketplace. The plugin package is stored in this repository at `plugins/createya-mcp/`.

## Install for users

```bash
codex plugin marketplace add Createya-ai/Createya-mcp
```

Then open Codex → Plugins, find **Createya**, click **Install**, and complete authorization.

After install, Codex gets:

- Createya plugin card with the Createya icon
- MCP server configuration for `https://api.createya.ai/mcp`
- bundled skills: `createya`, `creative-director`, `createya-batch`, `character-sheet`

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
