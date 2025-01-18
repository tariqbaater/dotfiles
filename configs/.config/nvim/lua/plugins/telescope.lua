-- plugins/telescope.lua:
return {
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.5",
        -- or                              , branch = '0.1.x',
        dependencies = { "nvim-lua/plenary.nvim" },
    },
    {
        "nvim-telescope/telescope-ui-select.nvim",
        config = function()
            require("telescope").setup({
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown(),
                    },
                },
            })
            require("telescope").load_extension("ui-select")
        end,
    },
    {
        "jvgrootveld/telescope-zoxide",
        config = function()
            require("telescope").load_extension("zoxide")
        end,
    },
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        config = function()
            require("telescope").load_extension("fzf")
        end,
    },

}
