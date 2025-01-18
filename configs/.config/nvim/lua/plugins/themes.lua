return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        lazy = false, -- make sure we load this during startup if it is your main colorscheme
        priority = 1000,
        config = function()
            vim.cmd([[colorscheme catppuccin]]) -- prioritize catppuccin over other colorschemes
        end,
    },
    {
        "rebelot/kanagawa.nvim",
    },
    {
        "folke/tokyonight.nvim",
        lazy = false,    -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
    }


}
