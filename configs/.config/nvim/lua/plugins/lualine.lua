return {
    "nvim-lualine/lualine.nvim",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        -- check if pomodoro is inactive
        local function pomodoro_status()
            local ok, pomo = pcall(require, "pomo")
            if not ok then
                return " --:--"
            end

            local timer = pomo.get_first_to_finish()
            if timer == nil then
                return " --:--"
            end

            return "󰄉 " .. tostring(timer)
        end

        -- check for LSP clients active
        local function lspClients()
            local message = ""
            local clients = vim.lsp.get_active_clients()
            local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
            if next(clients) == nil then
                return message
            end
            for _, client in ipairs(clients) do
                if client.config.filetypes ~= nil and vim.fn.index(client.config.filetypes, buf_ft) ~= -1 then
                    message = client.name
                    break
                end
            end
            return message
        end

        -- Lualine setup
        require("lualine").setup({
            options = {
                icons_enabled = true,
                theme = "auto",
                component_separators = { left = "", right = "" },
                section_separators = { left = '', right = '' },
                -- section_separators = { left = "", right = "" },
                disabled_filetypes = {
                    statusline = {},
                    winbar = {},
                },
                ignore_focus = {},
                always_divide_middle = true,
                globalstatus = false,
                refresh = {
                    statusline = 1000,
                    tabline = 1000,
                    winbar = 1000,
                },
            },
            sections = {
                lualine_a = { { 'mode', separator = { left = '' }, right_padding = 2 } },
                lualine_b = { "branch", "diff", "diagnostics" },
                lualine_c = { {
                    require("noice").api.statusline.mode.get,
                    cond = require("noice").api.statusline.mode.has,
                    color = { fg = "#ff9e64" },
                }, "filename" },
                lualine_x = { { pomodoro_status, color = { fg = "#F26988" } }, { lspClients, color = { fg = "#2FBF77" }, icon = "" }, "fileformat", "filetype" },
                lualine_y = {
                    {
                        require("lazy.status").updates,
                        cond = require("lazy.status").has_updates,
                        color = { fg = "#FF9E64" },
                    },
                    {
                        require("mason").status,
                        cond = require("mason").has_pending_updates,
                        color = { fg = "#FF9E64" },
                    }
                },
                lualine_z = { { 'location', separator = { right = '' }, left_padding = 2 }, },
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { "filename" },
                lualine_x = { "location" },
                lualine_y = {},
                lualine_z = {},
            },
            tabline = {},
            winbar = {},
            inactive_winbar = {},
            extensions = {},
        })
    end,
}
