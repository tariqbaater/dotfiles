return {
  "github/copilot.vim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp",
    "hrsh7th/vim-vsnip",
    "rafamadriz/friendly-snippets",
  },
  config = function()
    require("copilot").setup({
    })
    -- Enable Copilot for all file types
    vim.g.copilot_filetypes = {
      ["*"] = true,
    }

    -- Set the key mapping for accepting suggestions
    vim.api.nvim_set_keymap('i', '<C-l>', 'copilot#Accept("<CR>")', { expr = true, silent = true, noremap = true })

    -- Set the key mapping for cycling through suggestions
    vim.api.nvim_set_keymap('i', '<A-s>', 'copilot#Next()', { expr = true, silent = true, noremap = true })
    vim.api.nvim_set_keymap('i', '<A-a>', 'copilot#Previous()', { expr = true, silent = true, noremap = true })
    -- Set the key mapping for dismissing suggestions
    vim.api.nvim_set_keymap('i', '<A-x>', 'copilot#Dismiss()', { expr = true, silent = true, noremap = true })
  end,
}
