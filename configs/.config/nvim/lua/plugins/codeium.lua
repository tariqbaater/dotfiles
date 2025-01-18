return {

    {
        "Exafunction/codeium.vim",
        event = "BufEnter",
        config = function()
            -- Change '<C-g>' here to any keycode you like.
            vim.keymap.set("i", "<Tab>", function()
                return vim.fn["codeium#Accept"]()
            end, { expr = true })
            vim.keymap.set("i", "<A-a>", function()
                return vim.fn["codeium#CycleCompletions"](1)
            end, { expr = true })
            vim.keymap.set("i", "<A-c>", function()
                return vim.fn["codeium#CycleCompletions"](-1)
            end, { expr = true })
            vim.keymap.set("i", "<A-x>", function()
                return vim.fn["codeium#Clear"]()
            end, { expr = true })
            -- codeium chat codeium#Chat()
            vim.keymap.set("n", "<leader>i", function()
                return vim.fn["codeium#Chat"]()
            end, { expr = true }, { desc = "Codeium Chat" })
        end,
    },
    -- {
    --     "Exafunction/codeium.nvim",
    --     dependencies = {
    --         "nvim-lua/plenary.nvim",
    --         "hrsh7th/nvim-cmp",
    --     },
    --     config = function()
    --         require("codeium").setup({})
    --     end,
    -- },
}
