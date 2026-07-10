# Concerns

**Last updated:** 2026-07-10

## Technical Debt

| Issue | Location | Severity | Impact | Effort to Fix |
|-------|----------|----------|--------|---------------|
| Key mapping conflict: `<C-h>` mapped twice in normal mode — window navigation overridden by harpoon | `lua/tariq/core/remap.lua:98,130` | High | `<C-h>` window-left navigation breaks silently; second mapping (harpoon nav_next) takes precedence since it's defined later | Low — remove or unbind the duplicate |
| Key mapping `<C-h>` conflict between remap.lua and oil.lua | `lua/tariq/core/remap.lua:98` vs `lua/tariq/plugins/oil.lua:62` | Medium | In oil buffers, `<C-h>` intended for horizontal split could conflict with global window navigation mapping | Low |
| `<C-e>` overrides Neovim built-in scroll-down behavior | `lua/tariq/core/remap.lua:118` | Low | User loses default `<C-e>` scroll-down in normal mode (remapped to harpoon toggle) | Low |
| `<C-p>` overrides Neovim built-in command-line history completion | `lua/tariq/core/remap.lua:124` | Low | User loses default `<C-p>` in command mode for cycling through command history | Low |
| `<Tab>` mapped to both neocodeium.accept() and nvim-cmp default Tab behavior | `lua/tariq/plugins/neocodium.lua:14` | High | Tab could either accept neocodeium suggestions or navigate nvim-cmp snippets depending on focus; creates unpredictable behavior in insert mode | Medium — add fallback logic or use distinct keys |
| Broken copilot source reference in nvim-cmp config (plugin file is `.bk`) | `lua/tariq/plugins/nvim-cmp.lua:56` + `lua/tariq/plugins/copilot.lua.bk` | Medium | nvim-cmp configuration references `{ name = "copilot" }` as a source but the actual plugin config is disabled (`.bk` backup file); could cause errors or warnings during completion | Low — remove the source or restore the plugin |
| Stale backup files committed to repo | `lua/tariq/plugins/avante.lua.bk`, `lua/tariq/plugins/copilot.lua.bk` | Low | Clutters the plugin directory; no `.gitignore` exists so these get committed | Low — remove `.bk` files and add a `.gitignore` |
| Fold settings are contradictory across multiple files | `lua/tariq/core/options.lua:67`, `lua/tariq/core/commands.lua:103-105`, `lua/tariq/plugins/nvim-ufo.lua:16-18` | Medium | `options.lua` sets `foldmethod = "marker"` globally; `commands.lua` BufRead autocmd overrides to `foldmethod = "expr"` with treesitter; nvim-ufo sets its own foldlevel/foldenable. Unpredictable folding behavior depending on load order and file type. | Medium — consolidate fold config into nvim-ufo only, remove from options.lua and commands.lua |
| Heavy use of `vim.cmd([[...]])` instead of Lua API | `lua/tariq/core/commands.lua:27-28,47,57-72,82-83,93,103-105,140,151` | Low | 25+ `vim.cmd` calls that could be replaced with `vim.opt`, `vim.bo`, `vim.api.nvim_set_option_value`, `vim.keymap.set`; not a bug but perpetuates legacy Vimscript patterns in a Lua-first config | Medium |
| `conform.nvim` uses `black` with deprecated `--fast` flag | `lua/tariq/plugins/formatting.lua:7` | Low | `black --fast` was the default since Black 22.1 and the flag was removed in later versions; likely a no-op on modern black but could error on older versions | Low |
| `pyright` and `ruff` LSP servers both configured for Python | `lua/tariq/plugins/lsp/mason.lua:7-8` | Medium | Having both `pyright` and `ruff` installed can cause duplicate diagnostics or conflicts for Python files; no explicit LSP config to manage which takes precedence | Low — select one primary Python LSP or configure properly |
| Empty file committed to repo | `snippets/lua.lua` | Low | Zero-line file serves no purpose | Low — remove it |
| LSP server configuration is split across 3+ files | `lua/tariq/lsp.lua`, `lua/tariq/plugins/lsp/lsp.lua`, `lua/tariq/plugins/lsp/mason.lua`, `lua/tariq/plugins/lsp/` | Medium | LSP config is fragmented: diagnostic icons in one file, capability setup in another, server installation in another. No centralized `on_attach` or individual server configs exist. Hard to reason about LSP behavior. | Medium — consolidate into a single LSP module |
| `lualine` calls `require("noice").api.statusline.mode.get` eagerly at config time | `lua/tariq/plugins/lualine.lua:29` | Low | Requires noice at config time even though noice uses `event = "VeryLazy"`; `pcall` not used so if noice load order changes this could break the statusline | Low |
| No `.gitignore` file | Project root | Low | Backup files (`.bk`), editor swap files, and other artifacts could accidentally be committed | Low |

## Known Bugs

| Bug | Location | Severity | Status |
|-----|----------|----------|--------|
| `<C-h>` mapping in normal mode is overridden — intended window-left navigation never fires | `lua/tariq/core/remap.lua:98,130` | High | Open |
| `Neocodeium` Tab accept competes with `nvim-cmp` Tab behavior, creating unpredictable insert-mode completions | `lua/tariq/plugins/neocodium.lua:14` | High | Open |
| `nvim-cmp` references a `copilot` source that is not installed — the plugin config is disabled (`.bk` file) | `lua/tariq/plugins/nvim-cmp.lua:56` | Medium | Open |
| `lualine_status()` uses `require("noice")` with no `pcall` guard; if noice fails to load, statusline section errors | `lua/tariq/plugins/lualine.lua:29` | Low | Open |

## Security Considerations

**No direct security vulnerabilities detected.** This is a local Neovim editor configuration — it does not expose network services, handle external user input, or store credentials.

**Minor concerns:**
- **Hardcoded user paths** in multiple files leak the local username (`tariq`) and filesystem structure. Not a security issue per se, but makes the config non-portable and means absolute paths are visible if this config is shared.
  - Files: `lua/tariq/core/remap.lua:24,31,38,52`, `lua/tariq/plugins/obsidian.lua:24,28,63`
- **`mcphub.nvim` with `auto_approve = true`** (`lua/tariq/plugins/mcp-hub.lua:14`): Automatically approves all MCP server prompt requests. MCP servers can execute arbitrary commands. This reduces the user's ability to audit what each prompt does.
- **No `.gitignore`**: If environment-specific files or test files with sensitive data are ever added to this directory, they would be committed.

## Performance Concerns

- **Multiple plugins with `lazy = false`** increases Neovim startup time:
  - `catppuccin/nvim` (themes.lua) — priority 1000
  - `Comment.nvim` (nvim-comment.lua)
  - `easymotion/vim-easymotion` (easymotion.lua)
  - `auto-session` (autosession.lua)
  - `prayertime.nvim` (muslim.lua) — priority 1000
- **`lualine` refresh rate**: `refresh = { statusline = 1000 }` means the statusline re-evaluates every 1 second; the `pomodoro_status()` and `lsp_client_name()` functions run on every refresh
- **Format on save with conform.nvim** (`lua/tariq/core/commands.lua:129-134`): Every `BufWritePre` calls `conform.format()` which may invoke external formatters (prettierd, black, stylua). This can be slow for large files.
- **Treesitter `auto_install = true`**: Automatically installs parsers for unknown file types on first open, causing a brief freeze.
- **Source lua files on save** (`lua/tariq/core/commands.lua:137-143`): Every lua file write sources the entire file — unnecessary for non-config files and can cause errors if non-Neovim lua files contain syntax that Neovim can't evaluate.

## Fragile Areas

| Area | Files | Risk |
|------|-------|------|
| **Lazy loading bootstrap** | `lua/tariq/lazy.lua:3` | Uses `vim.uv or vim.loop` fallback; `vim.loop` was deprecated in 0.10 and completely removed in newer Neovim versions. Works now but will break on future Neovim updates. |
| **Hardcoded Obsidian vault paths** | `lua/tariq/core/remap.lua:24,31,38,52`, `lua/tariq/plugins/obsidian.lua:24,28,63` | Six references to `/Users/tariq/Library/Mobile Documents/iCloud~md~obsidian/Documents/Vault/` with escaped spaces. Extremely fragile — breaks if username changes, vault is relocated, or config is shared. Path casing is inconsistent (`library` vs `Library` in different files). |
| **LSP ecosystem (no individual server config)** | `lua/tariq/plugins/lsp/mason.lua` + `lua/tariq/plugins/lsp/lsp.lua` | 10 LSP servers installed but no `on_attach`, no keymap integration, no per-server settings. Servers like `eslint`, `ruff`, and `pyright` typically need custom setup. Silent failures or suboptimal behavior likely. |
| **Auto-session with `suppressed_dirs`** | `lua/tariq/plugins/autosession.lua:9` | Suppresses `~/`, `~/Projects`, `~/Downloads`, and `/` — if the user opens a file outside these, auto-session may behave unexpectedly |
| **`<Tab>` key overload** | `lua/tariq/plugins/neocodium.lua:14` | Tab is mapped in nvim-cmp (snippet navigation) and neocodeium (accept completion). These will conflict in insert mode. |
| **vim-floaterm (unmaintained)** | `lua/tariq/plugins/float-term.lua` | `voldikss/vim-floaterm` has not been actively maintained; may break with newer Neovim versions |
| **Markdown preview build step** | `lua/tariq/plugins/markdown.lua:5-7` | Uses `mkdp#util#install()` on build — requires node.js and npm to be available at plugin install time; if missing, the plugin silently fails |
| **LSP rename via `<leader>lr`** | `lua/tariq/plugins/which-key.lua:84` | Uses `vim.lsp.buf.rename()` which blocks the UI and doesn't use the Neovim 0.10+ `vim.lsp.buf.rename({ title = "..." })` API | 

## Improvement Opportunities

| Opportunity | Location | Impact | Effort |
|-------------|----------|--------|--------|
| Consolidate all fold-related settings into nvim-ufo config only | `lua/tariq/core/options.lua:67`, `commands.lua:97-107`, `nvim-ufo.lua` | Medium — fixes unpredictable folding | Medium |
| Resolve `<C-h>` key conflict — decide if harpoon or window nav wins | `lua/tariq/core/remap.lua:98,130` | High — restores broken window navigation | Low |
| Fix neocodeium/nvim-cmp Tab conflict with conditional accept | `lua/tariq/plugins/neocodium.lua:14` | High — fixes unreliable completions | Medium |
| Remove `copilot` source from nvim-cmp or restore copilot plugin | `lua/tariq/plugins/nvim-cmp.lua:56` | Medium — prevents completion errors | Low |
| Replace hardcoded Obsidian paths with environment variable or config | `remap.lua:24,31,38,52`, `obsidian.lua:24,28,63` | Medium — makes config portable | Medium |
| Add `.gitignore` to the config directory | `/Users/tariq/.dotfiles/configs/.config/nvim/` | Low — prevents stale files from being committed | Low |
| Remove stale `.bk` backup files | `lua/tariq/plugins/avante.lua.bk`, `lua/tariq/plugins/copilot.lua.bk` | Low — cleans up repo | Low |
| Add `pcall` guard on noice require in lualine | `lua/tariq/plugins/lualine.lua:29` | Medium — prevents statusline breakage | Low |
| Consolidate LSP config into one file with per-server settings | `lua/tariq/plugins/lsp/*.lua`, `lua/tariq/lsp.lua` | Medium — enables reliable LSP behavior | Medium |
| Replace `vim.cmd` calls with Lua equivalents in commands.lua | `lua/tariq/core/commands.lua` | Low — modernization, no functional change | Medium |
| Remove empty `snippets/lua.lua` file | `snippets/lua.lua` | Low — cleanup | Low |
| Review `auto_approve = true` in mcphub config | `lua/tariq/plugins/mcp-hub.lua:14` | Medium — security posture improvement | Low |

## Dependencies & Version Drift

| Dependency | Current | Latest Known | Drift | Notes |
|------------|---------|-------------|-------|-------|
| **Neovim** (implicit) | Requires ≥ 0.10 (`vim.uv`) | 0.11+ | Unknown | `vim.loop` fallback in `lazy.lua:3` indicates compatibility with 0.9.x |
| **lazy.nvim** | `306a055` (locked) | Rolling | Unknown | Locked to a specific commit via lazy-lock.json |
| **telescope.nvim** | tagged `0.1.7` | `0.1.8+` | Minor | Pinned to a specific tag in `telescope.lua:5` — may miss bugfixes |
| **catppuccin/nvim** | `05e8787` (locked) | Rolling | Unknown | Locked via lazy-lock.json |
| **nvim-treesitter** | `cf12346` (locked) | Rolling | Unknown | Locked via lazy-lock.json; `auto_install = true` means new parsers auto-install but existing parser versions are pinned |
| **vim-floaterm** | `bb4ba79` (locked) | Rolling | Unmaintained | Last activity: project appears dormant. Risk of Neovim API breakage. |
| **All others** | Locked via `lazy-lock.json` | Rolling | Varies | Lazy-lock.json pins all 69 plugins to specific commits; `checker.enabled = true` in lazy.lua will notify of updates but not auto-install |

---

*Concerns audit: 2026-07-10*
