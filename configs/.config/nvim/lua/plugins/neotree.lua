return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
        },
        config = function()
            require("neo-tree").setup({
                source_selector = {
                    winbar = true,
                    statusline = false
                },
                window = {
                    mappings = {
                        -- fuzzy find files with telescope
                        -- ["D"] = "fuzzy_finder_directory",

                        ["P"] = { "toggle_preview", config = { use_image_nvim = true } },
                        ["l"] = "open",
                        ["h"] = "close_node",
                    },
                },
            })
        end,

    },
}
