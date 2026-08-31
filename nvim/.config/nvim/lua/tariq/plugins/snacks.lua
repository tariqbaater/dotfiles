return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		dashboard = {
			enabled = true,
			preset = {
				header = [[
 ██████████       ██       ███████     ██     ███████
░░░░░██░░░       ████     ░██░░░░██   ░██    ██░░░░░██
    ░██         ██░░██    ░██   ░██   ░██   ██     ░░██
    ░██        ██  ░░██   ░███████    ░██  ░██      ░██
    ░██       ██████████  ░██░░░██    ░██  ░██    ██░██
    ░██      ░██░░░░░░██  ░██  ░░██   ░██  ░░██  ░░ ██
    ░██      ░██     ░██  ░██   ░░██  ░██   ░░███████ ██
    ░░       ░░      ░░   ░░     ░░   ░░     ░░░░░░░ ░░
        ]],
			},
		},
		bigfile = { enabled = true },
		indent = { enabled = true },
		quickfile = { enabled = true },
		scroll = { enabled = true },
		statuscolumn = { enabled = true },
		lazygit = { enabled = true },
	},
}
