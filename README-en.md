# Createya MCP & API — World of AI without borders

**Slogan (RU):** Мир нейросетей без границ.

100+ AI models. No VPN. Ruble billing.

> **English keywords for discovery:** AI image generation, AI video generation, Flux 2, Flux Kontext, Kling Video O3, Runway Gen-4, Sora 2, Veo 3.1, Suno, Midjourney, Nano Banana 2, Higgsfield Soul, Seedance 2.0, Happy Horse, Grok Imagine, GPT Image 2.0, Recraft, Ideogram, ElevenLabs, MCP server, Claude MCP, Cursor MCP, Cline MCP, Windsurf MCP, Codex MCP, OpenCode MCP, ruble payment, no VPN AI, 152-FZ compliant.

**Primary documentation in Russian: [README.md](README.md)** — this is the authoritative version.

---

## What is Createya MCP

Createya is an AI-platform aggregating 100+ models (image, video, audio, text) under a single API key. This repository provides:

- 📦 **Plug-and-play configs** for Claude Desktop, Claude Code, Cursor, Cline, Windsurf, Codex, OpenCode
- 🎨 **Skill manifest** for Claude Code (auto-discoverable)
- 📚 **Examples** of image / video / REST integration
- 🔌 **MCP endpoint:** `https://api.createya.ai/mcp` (Streamable HTTP, MCP spec 2025-06-18)

## Why use Createya

| Problem | Solution |
|---|---|
| Geo-blocked AI services that need VPN | Direct access — no VPN required |
| Cannot pay with international cards | Ruble billing via local payment systems |
| Many providers, many keys | Single API key for 100+ models |
| 152-FZ data residency | All data stored locally, full compliance |
| B2B / legal entities | Bank transfer billing, contract + closing documents, VAT options |

## Quick start

1. Sign up at [createya.ai](https://createya.ai) — 100 free credits
2. Create API key at [createya.ai/settings/api-keys](https://createya.ai/settings/api-keys)
3. Pick your client config from [`configs/`](configs/) and replace `crya_sk_live_REPLACE_WITH_YOUR_KEY`
4. Restart your client → ask it: "Generate an image via Createya"

## What MCP tools are available

- `list_models` — full catalog with `parameters_schema`
- `run_model` — `{ model, input }` → image / video / audio / text
- `get_run_status` — poll async runs
- `get_balance` — workspace credits

## Pricing

- 100 free credits on signup
- Top-up plans available at [createya.ai](https://createya.ai)
- B2B: bank transfer, VAT options, white-label — contact support@createya.ai

## Documentation

- 🌐 Site: [createya.ai](https://createya.ai)
- 🤖 Bot: [@createya_bot](https://t.me/createya_bot)
- 📡 API docs: [createya.ai/api](https://createya.ai/api)
- 📚 Knowledge base: [createya.ai/knowledge](https://createya.ai/knowledge)
- 📧 Support: support@createya.ai

## License

[MIT](LICENSE) — fork it, build on top of it, no restrictions.
