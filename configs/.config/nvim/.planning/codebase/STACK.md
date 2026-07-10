# Stack — Neovim Configuration

**Last updated:** 2026-07-10

## Languages

| Language | Version | Location | Notes |
|----------|---------|----------|-------|
| Lua (LuaJIT) | Bundled with Neovim | `lua/`, `init.lua` | Primary config language, ~55 Lua files |
| Vimscript | Bundled with Neovim | Embedded in `commands.lua` (autocmds, `setlocal`) | Minimal usage, only inside Lua string commands |
| JSON | — | `lazy-lock.json`, `snippets/**/*.json` | Plugin lockfile and snippet definitions |
| Markdown | — | `after/lsp/info.md` | Documentation |

## Runtime

| Runtime | Version | Config file | Notes |
|---------|---------|-------------|-------|
| Neovim | >= 0.11 (uses `vim.lsp.config`) | `init.lua` | Entry point; not explicitly pinned — uses `lazy.nvim` which requires >= 0.9.5. The use of `vim.lsp.config("*", ...)` in `lua/tariq/plugins/lsp/lsp.lua` implies Neovim >= 0.11. |

## Package Management

| Tool | File | Notes |
|------|------|-------|
| lazy.nvim (folke/lazy.nvim) | `lua/tariq/lazy.lua` | Plugin manager, auto-clones from GitHub, lazy-loads plugins |
| lazy-lock.json | `lazy-lock.json` | Plugin commit lockfile (69 plugins pinned) |

## Core Frameworks & Libraries

| Category | Choice | Version | Location | Notes |
|----------|--------|---------|----------|-------|
| LSP Client | nvim-lspconfig | Latest | `lua/tariq/plugins/lsp/` | Configures LSP servers via `vim.lsp.config` |
| Parser | nvim-treesitter | Latest | `lua/tariq/plugins/treesitter.lua` | Syntax highlighting, textobjects, folding |
| Completion | nvim-cmp | Latest | `lua/tariq/plugins/nvim-cmp.lua` | Autocompletion engine with multiple sources |
| Snippets | LuaSnip + friendly-snippets | v2.* | `lua/tariq/plugins/nvim-cmp.lua` | Snippet engine + community snippet collection |
| Tool Installer | mason.nvim + mason-lspconfig | Latest | `lua/tariq/plugins/lsp/mason.lua` | Installs LSP servers, linters, formatters |
| Statusline | lualine.nvim | Latest | `lua/tariq/plugins/lualine.lua` | Custom statusline with pomodoro, LSP, mason, lazy status |
| UI/UX | noice.nvim + nvim-notify | Latest | `lua/tariq/plugins/noice.lua` | UI overhaul for cmdline, messages, notifications |
| Start Screen | alpha-nvim | Latest | `lua/tariq/plugins/alpha.lua` | Custom dashboard with ASCII art header |
| Colorscheme | catppuccin (mocha) | Latest | `lua/tariq/plugins/themes.lua` | Default colorscheme with integrations |
| AI Codeium | neocodeium | Latest | `lua/tariq/plugins/neocodium.lua` | AI code completion inline |
| MCP Hub | mcphub.nvim | Latest | `lua/tariq/plugins/mcp-hub.lua` | MCP server integration (requires Node.js) |
| Git | gitsigns.nvim + lazygit.nvim | Latest | `lua/tariq/plugins/gitsigns.lua`, `lua/tariq/plugins/lazygit.lua` | Git decorations + git TUI |
| Debugging | nvim-dap + nvim-dap-python | Latest | `lua/tariq/plugins/nvim-dap.lua` | Python debugger adapter + UI |
| Obsidian | obsidian.nvim | Latest | `lua/tariq/plugins/obsidian.lua` | Obsidian vault integration |
| Database | vim-dadbod + dadbod-ui | Latest | `lua/tariq/plugins/dadbod.lua` | Database client |
| File Explorer | oil.nvim | Latest | `lua/tariq/plugins/oil.lua` | File browser as buffer editor |
| Telescope | telescope.nvim | 0.1.7 | `lua/tariq/plugins/telescope.lua` | Fuzzy finder (fzf-native, zoxide, ui-select extensions) |
| Folding | nvim-ufo + promise-async | Latest | `lua/tariq/plugins/nvim-ufo.lua` | LSP-aware code folding |

## Build & Dev Tooling

| Tool | Config | Notes |
|------|--------|-------|
| stylua | `.stylua.toml` | Lua formatter (2-space indent, spaces) |
| prettierd | `conform.nvim` config | Universal formatter for JS/TS/HTML/CSS/JSON/Markdown |
| isort + black | `conform.nvim` config | Python formatters |
| eslint_d | mason-tool-installer | JS linter (installed but not in conform formatters list) |
| pylint | mason-tool-installer | Python linter (installed but not in conform formatters list) |
| npm | global install for mcp-hub | `npm install -g mcp-hub@latest` required |
| Make | telescope-fzf-native build | C compilation for native fzf |
| make install_jsregexp | LuaSnip build | Optional JS regex for LuaSnip |

## Configuration

| File | Purpose |
|------|---------|
| `init.lua` | Entry point — loads lazy, core, and LSP modules |
| `.luarc.json` | Lua LSP diagnostic config (declares `vim` global) |
| `.stylua.toml` | Lua formatting rules (2-space indent) |
| `lazy-lock.json` | Plugin version lock (69 plugins pinned by commit) |
| `lua/tariq/lazy.lua` | lazy.nvim bootstrap + plugin spec loading |
| `lua/tariq/core/options.lua` | General Neovim options and performance settings |
| `lua/tariq/core/remap.lua` | Key mappings (~100 mappings) |
| `lua/tariq/core/commands.lua` | Autocommands and user commands |
| `lua/tariq/lsp.lua` | Diagnostic sign configuration |
| `lua/tariq/plugins/lsp/mason.lua` | Mason LSP/formatter/linter tool list |
| `snippets/` | Custom LuaJSON snippets + Python snippets |

## Dependencies

### Core Dependencies

| Dependency | Version | Purpose |
|------------|---------|---------|
| Neovim | >= 0.11 | Text editor runtime |
| Git | System-provided | Plugin cloning, lazygit integration |
| Node.js + npm | System-provided | MCP Hub global install (`mcp-hub`) |
| lazygit | External binary | Git TUI integration |
| zoxide | External binary | Smart directory navigation |
| fd | External binary | `Telescope fd` find command |
| Python 3 | External binary | DAP Python debugger (`python3`), Python formatting |
| ripgrep | External binary | `Telescope live_grep` backend |
| bash/zsh | System shell | Terminal integration, code runner |

### Plugin Dependencies (69 managed by lazy.nvim)

| Plugin | Locked Commit | Purpose |
|--------|---------------|---------|
| plenary.nvim | 74b06c6 | Utility library (dependency of many plugins) |
| nvim-web-devicons | dad7138 | File type icons (lualine, bufferline) |
| mini.icons | 98faae3 | Lightweight icons alternative (oil.nvim) |
| nui.nvim | de74099 | UI component library (noice.nvim) |
| promise-async | 119e896 | Async primitives (nvim-ufo) |
| nvim-nio | 21f5324 | Async IO (nvim-dap-ui) |

### External Tools Referenced

| Tool | Usage | Config Location |
|------|-------|-----------------|
| lazygit | Git TUI | `lua/tariq/plugins/lazygit.lua` |
| zoxide | Smart directory navigation | `lua/tariq/plugins/telescope.lua` (telescope-zoxide) |
| python3 | Python DAP | `lua/tariq/plugins/nvim-dap.lua` — `dap_python.setup("python3")` |
| node | MCP Hub | `lua/tariq/plugins/mcp-hub.lua` — compiled build step |
| fzf | Telescope native sorter | `lua/tariq/plugins/telescope.lua` — telescope-fzf-native |
| Obsidian app | Vault location references | `lua/tariq/plugins/obsidian.lua`, `lua/tariq/core/remap.lua` |

---

*Stack analysis: 2026-07-10*
