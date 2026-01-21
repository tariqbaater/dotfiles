return {
    "lewis6991/gitsigns.nvim",
    config = function()
        require("gitsigns").setup()
    end,
    event = "VeryLazy",
    dependencies = "nvim-lua/plenary.nvim",
    opts = {
        signs = {
            add = { text = "▎" },
            change = { text = "▎" },
            delete = { text = "" },
            topdelete = { text = "" },
            changedelete = { text = "▎" },
            untracked = { text = "▎" },
        },
    },
    keys = {
        { "<leader>gj", "<cmd>Gitsigns next_hunk<cr>",       desc = "Next Hunk" },
        { "<leader>gk", "<cmd>Gitsigns prev_hunk<cr>",       desc = "Prev Hunk" },
        { "<leader>gs", "<cmd>Gitsigns stage_hunk<cr>",      desc = "Stage Hunk" },
        { "<leader>gu", "<cmd>Gitsigns undo_stage_hunk<cr>", desc = "Undo Stage Hunk" },
        { "<leader>gr", "<cmd>Gitsigns reset_hunk<cr>",      desc = "Reset Hunk" },
        { "<leader>gp", "<cmd>Gitsigns preview_hunk<cr>",    desc = "Preview Hunk" },
        { "<leader>gb", "<cmd>Gitsigns blame_line<cr>",      desc = "Blame Line" },
    },
    cmd = { "Gitsigns toggle_signs", "Gitsigns toggle_numhl", "Gitsigns toggle_linehl", "Gitsigns toggle_deleted" },
    init = function()
        vim.keymap.set("n", "]h", "<cmd>Gitsigns next_hunk<cr>", { desc = "Next Hunk" })
        vim.keymap.set("n", "[h", "<cmd>Gitsigns prev_hunk<cr>", { desc = "Prev Hunk" })
    end,
}
