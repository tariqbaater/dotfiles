# Conventions

**Last updated:** 2026-07-10

## Code Style

The codebase is entirely Lua, formatted with **StyLua** using 2-space indentation and spaces (no tabs), as defined in `.stylua.toml`:

```toml
indent_type = "Spaces"
indent_width = 2
```

The `.luarc.json` globally registers the `vim` global to suppress diagnostics:

```json
{
    "diagnostics.globals": ["vim"]
}
```

**Formatting runners** are configured via `lua/tariq/plugins/formatting.lua` using `conform.nvim`:

| Filetype | Formatter |
|----------|-----------|
| Lua | `stylua` |
| Python | `isort`, `black` |
| JavaScript/TypeScript | `prettierd` |
| HTML/CSS/JSON/Markdown | `prettierd` |

Format-on-save is enabled in `lua/tariq/core/commands.lua` (line 129):

```lua
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function(args)
    require("conform").format({ bufnr = args.buf })
  end,
})
```

## Naming Conventions

| Element | Convention | Example |
|---------|------------|---------|
| Files | snake_case | `lazy.lua`, `which-key.lua`, `todo-comments.lua`, `gx-extended.lua`, `autosession.lua` |
| Directories | snake_case | `tariq/core/`, `tariq/plugins/lsp/`, `after/lsp/` |
| Variables | camelCase or snake_case | `lazypath`, `buf_ft`, `auto_approve`, `lazyrepo` |
| Functions | snake_case | `pomodoro_status()`, `lsp_client_name()` |
| Modules | PascalCase (via require) | `require("telescope")`, `require("oil")` |
| Keymap descriptions | Sentence case | `"Toggle Breakpoint"`, `"Increment number"` |

## Plugin Configuration Pattern

Every plugin follows the lazy.nvim spec pattern in `lua/tariq/plugins/*.lua`:

```lua
return {
  "plugin-author/plugin-name",
  version = "*",          -- optional, pin version
  lazy = false,           -- or event/cmd/keys for lazy loading
  event = "VeryLazy",     -- lazy-loading trigger
  cmd = { "CmdName" },    -- command-based loading
  keys = {                -- key-based loading
    { "<leader>xx", "<cmd>Action<cr>", desc = "Description" },
  },
  dependencies = { "other/plugin" },
  opts = {                -- preferred over config when no imperative setup needed
    -- plugin options
  },
  config = function()     -- imperative setup when opts isn't enough
    require("plugin").setup({ ... })
  end,
  build = "...",          -- post-install build step
}
```

**Three tiers of plugin definition:**

1. **Minimal** — `return { "plugin/name" }` — no config needed, uses defaults (e.g., `autopairs.lua`, `undotree.lua`, `visual-multi.lua`)
2. **Opts-only** — `opts = {}` — lazy.nvim passes opts to the plugin's `config()` automatically (e.g., `todo-comments.lua`, `formatting.lua`, `autosession.lua`)
3. **Full config** — `config = function() ... end` — imperative setup with `require()`, keymaps, and custom logic (e.g., `lualine.lua`, `alpha.lua`, `nvim-dap.lua`, `neocodium.lua`)

## Module Structure

**Entry point:** `init.lua` — requires three core modules only:

```lua
require("tariq.lazy")    -- bootstrap lazy.nvim and define plugin specs
require("tariq.core")    -- options, keymaps, commands/autocmds
require("tariq.lsp")     -- LSP diagnostic configuration
```

**Core modules** (`lua/tariq/core/`):

```
core/init.lua        → requires options, remap, commands
core/options.lua     → vim.opt and vim.g settings
core/remap.lua       → vim.keymap.set and vim.api.nvim_set_keymap calls
core/commands.lua    → vim.api.nvim_create_user_command and vim.api.nvim_create_autocmd
```

**Plugin specs** are auto-imported via lazy.nvim:
- `tariq.plugins` — all files in `lua/tariq/plugins/*.lua`
- `tariq.plugins.lsp` — files in `lua/tariq/plugins/lsp/*.lua`

## Keymap Definition Styles

Two styles coexist:

**Style 1 — `vim.api.nvim_set_keymap` (older, used in `remap.lua`):**

```lua
local map = vim.api.nvim_set_keymap
map("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true, desc = "makes file executable" })
```

**Style 2 — `vim.keymap.set` (newer, used in `commands.lua`, `nvim-dap.lua`, `neocodium.lua`):**

```lua
vim.keymap.set("n", "<leader>db", function()
  dap.toggle_breakpoint()
end, { noremap = true, silent = true })
```

**Mapping conventions:**
- Every mapping includes a `desc` field for which-key integration
- `noremap = true, silent = true` are standard on `nvim_set_keymap` calls
- Key-based loading for plugins that provide their own mappings (e.g., `gitsigns.lua`)

## Autocommand Pattern

Autocommands are consistently grouped with named augroups in `commands.lua`:

```lua
vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("strip_trailing_whitespace", {}),
  desc = "Remove trailing whitespace on save",
  pattern = "*",
  callback = function()
    vim.cmd([[%s/\s\+$//e]])
  end,
})
```

**Pattern:** `group` is always created inline via `nvim_create_augroup`, and every autocommand includes a `desc` field.

## Error Handling

**Bootstrap errors (lazy.nvim):**
```lua
if vim.v.shell_error ~= 0 then
  vim.api.nvim_echo({
    { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
    { out, "WarningMsg" },
    { "\nPress any key to exit..." },
  }, true, {})
  vim.fn.getchar()
  os.exit(1)
end
```

**Graceful degradation with pcall:**
```lua
local function pomodoro_status()
  local ok, pomo = pcall(require, "pomo")
  if not ok then return "..." end
  -- ...
end
```

**Conditional existence checks:**
- `vim.uv.fs_stat(lazypath)` / `vim.loop.fs_stat(lazypath)` before cloning
- `cond` fields on lualine components to suppress when unavailable

## Logging & Observability

- **No logging framework** — the configuration relies on Neovim's UI for feedback
- **Notifications:** Handled by `noice.nvim` (message history UI) and `nvim-notify` (as fallback)
- **User feedback:** Uses `print()` in custom commands and `vim.notify` via noice
- **Plugin updates:** Displayed in the statusline via `lazy.status`
- **Diagnostics:** Toggleable via the `ToggleDiagnostics` user command
- **Observability plugins:** `gitsigns.nvim` for inline git blame/signs, `todo-comments.nvim` for tracking TODOs/FIXMEs

## Configuration Management

**User commands:**
```lua
vim.api.nvim_create_user_command("Config", function()
  vim.cmd([[cd ~/.config/nvim]])
  vim.cmd("Telescope find_files")
end, {})
```

**Autosourcing:** Lua files are sourced on save (`BufWritePost *.lua`) for rapid iteration.

**Session persistence:** Managed by `auto-session.nvim` (`plugins/autosession.lua`).

**Editor options** are set in `core/options.lua` using `vim.opt` consistently:
```lua
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
```

## Anti-Patterns to Avoid

1. **Mixed keymap APIs** — Prefer `vim.keymap.set` over `vim.api.nvim_set_keymap` for new code
2. **Duplicate fold settings** — `foldcolumn` and `foldlevel` are set in both `options.lua` and `nvim-ufo.lua`; avoid duplicating
3. **Hardcoded paths** — `remap.lua` uses absolute paths for Obsidian vault (`/Users/tariq/library/Mobile Documents/iCloud~md~obsidian/Documents/Vault`); these are user-specific and should be parameterized if shared
4. **Commented-out code** — Several files contain commented-out alternatives (e.g., `remap.lua` lines 63-68, `commands.lua` lines 119-126); keep config clean
5. **Inline vim.cmd strings** — Some autocommands in `commands.lua` chain many `vim.cmd([[setlocal ...]])` calls rather than using `vim.opt`/`vim.bo` directly

---

*Convention analysis: 2026-07-10*
