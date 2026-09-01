return {
    'stevearc/oil.nvim',
    cmd = "Oil",
    keys = {
        { "-", function() require("oil").open_float() end, desc = "Open Oil File Explorer" },
    },
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {},
    dependencies = { { "echasnovski/mini.icons", opts = {} } },

    config = function()
        require('oil').setup({
            float = {
                enable = true,
                padding = 2,
                max_width = 150,
                max_height = 200,
                border = "rounded",
                win_options = {
                    winblend = 0,
                },
                get_win_title = nil,
                preview_split = "auto",
                override = function(conf)
                    return conf
                end,
            },
            preview = {
                max_width = 0.9,
                min_width = { 40, 0.4 },
                width = nil,
                max_height = 0.9,
                min_height = { 5, 0.1 },
                height = nil,
                border = "rounded",
                win_options = {
                    winblend = 0,
                },
                update_on_cursor_moved = true,
            },
            keymaps = {
                ["<bs>"] = { "actions.parent" },
                ["h"] = { "actions.parent" },
                ["<CR>"] = "actions.select",
                ["l"] = "actions.select",
                ["g?"] = "actions.show_help",
                ["<C-s>"] = { "actions.select", opts = { vertical = true }, desc = "Open the entry in a vertical split" },
                ["<C-h>"] = { "actions.select", opts = { horizontal = true }, desc = "Open the entry in a horizontal split" },
                ["<C-t>"] = { "actions.select", opts = { tab = true }, desc = "Open the entry in new tab" },
                ["P"] = "actions.preview",
                ["<C-c>"] = "actions.close",
                ["<C-l>"] = "actions.refresh",
                ["_"] = "actions.open_cwd",
                ["`"] = "actions.cd",
                ["~"] = { "actions.cd", opts = { scope = "tab" }, desc = ":tcd to the current oil directory" },
                ["gs"] = "actions.change_sort",
                ["gx"] = "actions.open_external",
                ["g."] = "actions.toggle_hidden",
                ["g\\"] = "actions.toggle_trash",
            },
            default_file_explorer = true,
            delete_to_trash = true,
            skip_confirm_for_simple_edits = true,
            view_options = {
                show_hidden = true,
                natural_order = true,
                is_always_hidden = function(name, _)
                    return name == '..'
                end,
            },
            win_options = {
                wrap = true,
            }
        })
    end
}
