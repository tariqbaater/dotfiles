return {
	"iamcco/markdown-preview.nvim",
	cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
	ft = { "markdown", "obsidian" },
	build = function()
		vim.fn["mkdp#util#install"]()
	end,
}
