# Testing

**Last updated:** 2026-07-10

## Testing Framework

| Framework | Version | Config File | Notes |
|-----------|---------|-------------|-------|
| None detected | N/A | N/A | No test framework is configured for the Neovim configuration itself |

This project is a **Neovim configuration** (`init.lua` + plugin specs), not a development project with a test suite. There are:

- No `jest.config.*`, `vitest.config.*`, or `plenary.nvim` test configuration files
- No test runner setup scripts
- No `*.test.lua` or `*.spec.lua` files in the repository
- No `Makefile` or `package.json` with test commands

## Snippet-Based Testing Support

While no tests exist for the config itself, the **snippet collection** at `snippets/python/unittest.json` provides LuaSnip snippets for Python `unittest` assertions. These are for use when editing Python test files within Neovim, not for testing the configuration.

| Snippet Prefix | Expands To | File |
|----------------|------------|------|
| `ase` | `self.assertEqual(expected, actual)` | `snippets/python/unittest.json` |
| `asne` | `self.assertNotEqual(expected, actual)` | `snippets/python/unittest.json` |
| `asr` | `self.assertRaises(exception, callable, args)` | `snippets/python/unittest.json` |
| `ast` | `self.assertTrue(actual)` | `snippets/python/unittest.json` |
| `asf` | `self.assertFalse(actual)` | `snippets/python/unittest.json` |
| `asi` | `self.assertIs(expected, actual)` | `snippets/python/unittest.json` |
| `asint` | `self.assertIsNot(expected, actual)` | `snippets/python/unittest.json` |
| New Test Class | `class Test...(unittest.TestCase)` with boilerplate | `snippets/python/unittest.json` |

## Plugin-Related Testing Capability

The configuration itself does not run tests, but it enables testing workflows through:

1. **DAP Integration** (`plugins/nvim-dap.lua`): Debugger support for Python via `nvim-dap-python`, with which-key keymaps for breakpoints, continue, step over/into/out
2. **Terminal Integration** (`core/commands.lua`): Split terminals with `term://zsh` for running test commands in-session
3. **Neovim Plugin Development** (not used here): `plenary.nvim` is included as a dependency for several plugins and provides `plenary.test_harness`, but it is not used to test this configuration

## Mocking Strategy

No mocking strategy is in place. This is a configuration-only project — there is no application logic that would require mocking.

## Coverage

| Metric | Value | Target |
|--------|-------|--------|
| Test files | 0 | N/A |
| Test runner | None | N/A |
| Coverage tool | None | N/A |

## Test Patterns

Not applicable — no test patterns exist in this codebase.

---

*Testing analysis: 2026-07-10*
