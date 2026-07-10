# Integrations

**Last updated:** 2026-07-10

## External APIs

| API | Endpoint | Auth Method | Usage | Config Location |
|-----|----------|-------------|-------|-----------------|
| Obsidian Local Vault | iCloud Drive path | Filesystem (local) | Note creation, search, linking, templates | `lua/tariq/plugins/obsidian.lua` |
| Codeium AI | Neocodeium plugin | API key (via plugin) | AI code completion suggestions | `lua/tariq/plugins/neocodium.lua` |
| Prayer Times (Aladhan) | prayertime.nvim plugin | None (public API) | Islamic prayer time calculation for Riyadh | `lua/tariq/plugins/muslim.lua` |
| MCP Hub Servers | mcphub.nvim plugin | Plugin-managed | MCP (Model Context Protocol) server connections | `lua/tariq/plugins/mcp-hub.lua` |

### API Details

**Codeium (neocodeium):**
- Plugin: `monkoose/neocodeium`
- Triggered on `InsertEnter` event
- Sources: `sql`, `lua` filetypes enabled; no explicit API key config visible (sourced from environment or plugin defaults)
- Accept/cycle/clear keymaps: `<Tab>`, `<A-w>`, `<A-a>`, `<A-e>`, `<A-r>`, `<A-c>`

**Prayer Times (prayertime.nvim):**
- Plugin: `awesomegeek/prayertime.nvim`
- City: Riyadh, Coordinates: `24.6900, 46.7200`
- Calculation method: MWL (Method 4)
- Uses plenary.nvim for HTTP requests

**MCP Hub (mcphub.nvim):**
- Plugin: `ravitemer/mcphub.nvim`
- Requires global Node.js package: `mcp-hub` (installed via `npm install -g mcp-hub@latest` as build step)
- Features:
  - `auto_approve = true` — auto-approves MCP server prompts
  - `auto_toggle_mcp_servers = true` — LLMs start/stop MCP servers
  - Avante extension: `make_slash_commands = true` — `/slash` commands from MCP prompts
- Entry point: `<leader>pp` maps to `MCPHub`

## Databases

| Database | Engine | Purpose | Connection Config |
|----------|--------|---------|-------------------|
| Any SQL database | vim-dadbod + dadbod-ui | Database browsing and SQL execution | `lua/tariq/plugins/dadbod.lua` — no inline credentials (uses `DBUIToggle` command, credentials provided at runtime) |

**Note:** `vim-dadbod` is a generic database client. No database connections are hardcoded — credentials are expected to be configured at runtime via vim-dadbod's connection format (URL or separate config).

## Authentication Providers

| Provider | Protocol | Usage | Config |
|----------|----------|-------|--------|
| None detected | — | — | — |

**Note:** Codeium/Neocodeium handles its own authentication internally via its plugin (no explicit token in configuration). MCP Hub delegates authentication to individual MCP server configurations.

## Webhooks

| Webhook | Trigger | Destination | Config |
|---------|---------|-------------|--------|
| None detected | — | — | — |

## Third-Party Services

| Service | Purpose | Integration Point | Config |
|---------|---------|-------------------|--------|
| Obsidian (local vault) | Note-taking, knowledge management | `lua/tariq/plugins/obsidian.lua`, `lua/tariq/core/remap.lua` | Vault paths at `~/Library/Mobile Documents/iCloud~md~obsidian/Documents/Vault/` |
| lazygit | Git porcelain TUI | `lua/tariq/plugins/lazygit.lua` | External binary integration |
| zoxide | Smarter directory jumping | `lua/tariq/plugins/telescope.lua` | External binary via telescope-zoxide |
| fd | Fast file finding | `lua/tariq/plugins/which-key.lua` (`Telescope fd`) | External binary |
| ripgrep | Fast content searching | `lua/tariq/plugins/which-key.lua` (`Telescope live_grep`) | External binary |
| iCloud Drive | Obsidian vault sync (cloud) | `lua/tariq/plugins/obsidian.lua` | File path under `~/Library/Mobile Documents/iCloud~md~obsidian/` |
| Python 3 | Debugger adapter | `lua/tariq/plugins/nvim-dap.lua` | External interpreter: `dap_python.setup("python3")` |

### Obsidian Integration Detail

- **Workspaces:**
  - `personal`: `~/Library/Mobile Documents/iCloud~md~obsidian/Documents/Vault/personal`
  - `work`: `~/Library/Mobile Documents/iCloud~md~obsidian/Documents/Vault/work`
- **Template folder:** `~/Library/Mobile Documents/iCloud~md~obsidian/Documents/Vault/templates`
- **New notes location:** `inbox` subdirectory
- **Keymaps:**
  - `<leader>os` — ObsidianQuickSwitch
  - `<leader>og` — ObsidianSearch (grep)
  - `<leader>on` — ObsidianNewFromTemplate
  - `<leader>oT` — ObsidianTemplate
  - `<leader>ot` — ObsidianTags
  - `<leader>ol` — ObsidianLink
  - `<leader>of` — ObsidianFollowLink
  - `<leader>ov` — Telescope find_files in vault
  - `<leader>oz` — Telescope live_grep in vault
  - `<leader>oc` — `cd` to vault
  - `<leader>ok` — Move file to zettelkasten
  - `<leader>odd` — Delete file
- **Completion:** nvim-cmp integration enabled for Obsidian notes
- **Frontmatter:** Auto-generated with date, tags, and URL fields

### lazygit Integration Detail

- **Floating window:** scaled to 90%, rounded borders
- **Keymaps:**
  - `<leader>gg` — LazyGit
  - `<leader>gl` — LazyGitLog
  - `<leader>gf` — LazyGitFilterCurrentFile
- **Terminal size:** 36 lines when lazygit opens

### Environment Configuration

| Variable/Package | Location | Purpose |
|-----------------|----------|---------|
| Codeium API key | Set via neocodeium plugin (environment) | AI code completion |
| Node.js + npm | System | MCP Hub global install |
| mcp-hub (npm global) | Installed via `npm install -g mcp-hub@latest` | MCP server orchestrator |

## Code Runner Integrations

| Tool | Purpose | Config |
|------|---------|--------|
| cook.nvim | Run code in floating window | `lua/tariq/plugins/cook.lua` — runners for lua, js, php, sh |
| markdown-preview.nvim | Live markdown preview in browser | `lua/tariq/plugins/markdown.lua` — toggled via `<leader>vp` |
| vim-floaterm | Floating terminal | `lua/tariq/plugins/float-term.lua` — `<leader>tf` |

---

*Integrations audit: 2026-07-10*
