return {
	"MeanderingProgrammer/render-markdown.nvim",
	dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.nvim" },
	cmd = { "RenderMarkdown", "RenderMarkdownToggle" },
	ft = { "markdown", "meow" },
	---@module 'render-markdown'
	---@type render.md.UserConfig
	opts = {},
}
