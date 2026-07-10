# Architecture

**Last updated:** 2026-07-10

## Architectural Pattern

**Plugin-centric modular monolith** — a flat, import-based Lua configuration that delegates all non-trivial functionality to lazy-loaded Neovim plugins. The user's own code is minimal and focused on wiring: bootstrap, base settings, keybindings, and declarative plugin specs.

The configuration follows a **three-layer bootstrap chain**:

```
init.lua
  └── tariq.lazy      (plugin manager bootstrap + spec import)
  └── tariq.core      (options, remaps, commands)
       └── tariq.lsp  (global LSP diagnostic config)
```

## System Layers

### 1. Entry / Bootstrap Layer
- **Location:** `init.lua`
- **Purpose:** Minimal entry point. Requires three modules in fixed order: plugin loader, core config, LSP diagnostics.
- **Key files:**
  - `init.lua` — 3-line bootstrap (`require("tariq.lazy")`, `require("tariq.core")`, `require("tariq.lsp")`)

### 2. Plugin Manager Layer
- **Location:** `lua/tariq/lazy.lua`
- **Purpose:** Bootstraps `lazy.nvim` if not installed, sets `mapleader`/`maplocalleader`, then calls `require("lazy").setup()` with specs imported from the `tariq.plugins` and `tariq.plugins.lsp` namespaces.
- **Key files:**
  - `lua/tariq/lazy.lua` — lazy.nvim bootstrap and setup

### 3. Core Configuration Layer
- **Location:** `lua/tariq/core/`
- **Purpose:** Base Neovim settings that don't belong to any plugin. Sub-divided into three concerns:
  - **Options** (`options.lua`) — `vim.opt` and `vim.g` settings (tabs, search, UI, performance)
  - **Remaps** (`remap.lua`) — global keymaps using `vim.api.nvim_set_keymap` and `vim.keymap.set`
  - **Commands** (`commands.lua`) — user commands (`:ToggleDiagnostics`, `:Config`), autocommands (yank highlight, trailing whitespace, terminal settings, formating on save, fold settings)
- **Key files:**
  - `lua/tariq/core/init.lua` — aggregates options, remap, commands
  - `lua/tariq/core/options.lua` — `vim.opt` configuration (89 lines)
  - `lua/tariq/core/remap.lua` — global keymaps (164 lines)
  - `lua/tariq/core/commands.lua` — user commands and autocommands (173 lines)

### 4. LSP Diagnostic Layer
- **Location:** `lua/tariq/lsp.lua`
- **Purpose:** Global LSP diagnostic sign configuration (icon-based severity signs for error/warn/info/hint).
- **Key files:**
  - `lua/tariq/lsp.lua` — diagnostic config (12 lines)

### 5. Plugin Spec Layer
- **Location:** `lua/tariq/plugins/`
- **Purpose:** One file per plugin (or group of related plugins). Each file returns a lazy.nvim spec table defining the plugin source, dependencies, lazy-loading triggers, configuration, and keymaps. Loaded automatically by lazy.nvim's `{ import = "tariq.plugins" }` mechanism.
- **Sub-layer — LSP plugins:** `lua/tariq/plugins/lsp/` contains mason.lua (Mason + mason-lspconfig + mason-tool-installer) and lsp.lua (cmp-nvim-lsp capabilities).
- **Key files:** 39+ files in `lua/tariq/plugins/` plus 2 in `lua/tariq/plugins/lsp/`

### 6. After / Filetype Layer
- **Location:** `after/`
- **Purpose:** Neovim's `after/` directory for filetype-specific or overridden configs. Currently contains only a placeholder `after/lsp/info.md`.
- **Key files:**
  - `after/lsp/info.md` — placeholder documentation

## Data Flow

### Startup Sequence

```
1. Neovim reads init.lua
2. init.lua requires tariq.lazy
   ├── Bootstrap lazy.nvim (git clone if missing)
   ├── Set mapleader / maplocalleader
   ├── lazy.setup() with specs from tariq.plugins + tariq.plugins.lsp
   │   ├── Each plugin file configures its own lazy-loading triggers
   │   └── High-priority plugins (themes: lazy=false, priority=1000) load immediately
   └── lazy.nvim downloads/updates plugins declared in specs
3. init.lua requires tariq.core
   ├── tariq.core.options  → sets vim.opt / vim.g
   ├── tariq.core.remap    → registers global keymaps
   └── tariq.core.commands → registers :commands and autocommands
4. init.lua requires tariq.lsp
   └── vim.diagnostic.config() with icon-based severity signs
```

### Plugin Loading (lazy.nvim)

```
User Action                     Lazy Trigger          Plugin(s) Loaded
─────────────────────────────────────────────────────────────────────
Startup                         `lazy=false`          catppuccin, lualine, easymotion,
                                                       auto-session, Comment.nvim
Insert mode                     `event=InsertEnter`   nvim-cmp, neocodeium
Open file                       `event=BufReadPre`    cmp-nvim-lsp, lazydev
Read file                       `event=bufreadpost`   nvim-treesitter
VeryLazy idle                   `event=VeryLazy`       gitsigns, which-key, nvim-surround,
                                                       noice, venn.nvim
Command :LazyGit                `cmd=LazyGit`          lazygit.nvim
Command :Oil                    `cmd=Oil`              oil.nvim
Command :Cook                   `cmd=Cook`             cook.nvim
Command :MarkdownPreviewToggle  `cmd=...`              markdown-preview.nvim
Filetype markdown               `ft=markdown`          obsidian.nvim
```

### Keybinding Resolution

```
Core remaps (tariq.core.remap)
  └── Global nvim_set_keymap / vim.keymap.set calls

Plugin keymaps (in plugin specs)
  ├── keys = { ... }  → lazy.nvim `keys` trigger (registers on key press)
  └── config() blocks → full keymap setup on plugin load

which-key.nvim
  └── wk.add({...})   → registers descriptive entries for leader-based keymaps
```

## Key Abstractions

| Abstraction | Location | Purpose |
|-------------|----------|---------|
| **Plugin Spec** | `lua/tariq/plugins/*.lua` | A Lua module returning a lazy.nvim spec table. Single-file encapsulation of a plugin's source, dependencies, configuration, and keymaps. |
| **Core Config Module** | `lua/tariq/core/init.lua` | Aggregate that requires options, remap, and commands in sequence. Single import point for setup. |
| **lazy.nvim Import** | `lua/tariq/lazy.lua` (lines 28-29) | `{ import = "tariq.plugins" }` — lazy.nvim auto-discovers all modules under the namespace and registers them as plugin specs. |
| **Autocommand Group** | `lua/tariq/core/commands.lua` | Named augroups (`persist_undo`, `highlight_yank`, `strip_trailing_whitespace`, etc.) encapsulating related event handlers. |

## Entry Points

| Entry Point | Path | Purpose |
|-------------|------|---------|
| `init.lua` | `init.lua` | Neovim entry point. 3 require() calls bootstrap the entire config. |
| `tariq.lazy` | `lua/tariq/lazy.lua` | Bootstraps `lazy.nvim` and declares plugin specs. Beginning of all plugin configuration. |
| `tariq.core.options` | `lua/tariq/core/options.lua` | All `vim.opt` and `vim.g` global settings. |
| `tariq.core.remap` | `lua/tariq/core/remap.lua` | All global keymaps not associated with a specific plugin. |
| `tariq.core.commands` | `lua/tariq/core/commands.lua` | All `:UserCommand` definitions and `autocmd` registrations. |

## Module Boundaries

| Module | Public API | Internal Details |
|--------|------------|------------------|
| **tariq.plugins** | auto-discovered by lazy.nvim import | 39 individual spec files; each is a top-level return of a lazy.nvim spec table |
| **tariq.plugins.lsp** | auto-discovered by lazy.nvim import (`tariq.plugins.lsp`) | 2 spec files: `mason.lua` (Mason + LSP installers) and `lsp.lua` (cmp-nvim-lsp + capabilities) |
| **tariq.core** | `require("tariq.core")` aggregates options, remap, commands | 3 sub-modules that are NOT individually required from init.lua; only the aggregate is |
| **after/lsp** | Placeholder directory for user LSP overrides | Contains only `info.md` — currently unused |

## Key Design Decisions

1. **Lua-only configuration** — Zero Vimscript. All configuration, keymaps, and autocommands are expressed in Lua via `vim.opt`, `vim.api.nvim_set_keymap`, and `vim.api.nvim_create_autocmd`. This ensures a single language paradigm and access to Neovim's Lua APIs.

2. **Plugin-centric architecture** — The vast majority of functionality is delegated to plugins. The user's own code (~350 lines total across 4 core files) handles only wiring and integration. Plugin configuration lives in isolated files, one per plugin.

3. **lazy.nvim import-based spec loading** — Rather than manually requiring each plugin file, `lazy.nvim` auto-discovers specs via the `{ import = "tariq.plugins" }` pattern. This keeps `lazy.lua` minimal and makes adding a new plugin as simple as creating a new file in the plugins directory.

4. **lazy.nvim lazy-loading on every axis** — Plugins use fine-grained lazy-loading triggers: `event`, `cmd`, `keys`, `ft`, and `VeryLazy`. This minimizes startup impact (only the theme and essential UI plugins load at startup).

5. **No barrel exports** — Plugin spec files are discovered by lazy.nvim's import mechanism rather than requiring explicit barrel files or `init.lua` aggregators.

## Error Handling

**Strategy:** Minimal explicit error handling. Relies on lazy.nvim's error reporting for plugin loading failures.

**Patterns:**
- `pcall()` used in `lualine.lua` for optional helper modules (pomodoro status check)
- No custom error handlers in core code
- Diagnostic display configured in `tariq/lsp.lua` but actual LSP error handling delegated to plugins

## Cross-Cutting Concerns

**Logging:** Not configured (Neovim's built-in messaging used). `Noice.nvim` provides UI enhancement for messages.

**Validation:** No custom validation logic. Plugin configurations provide schema validation via their own `opts` tables.

**State Persistence:** Handled by `auto-session.nvim` (session saving/restoring).

---

*Architecture analysis: 2026-07-10*
