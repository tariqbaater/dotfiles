return {
  "nvim-lualine/lualine.nvim",
  lazy = false,
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    -- Helper: Pomodoro status display
    local function pomodoro_status()
      local ok, pomo = pcall(require, "pomo")
      if not ok then return " --:--" end
      local timer = pomo.get_first_to_finish()
      return timer and ("󰄉 " .. tostring(timer)) or " --:--"
    end

    -- Helper: Show active LSP client for current buffer
    local function lsp_client_name()
      local clients = vim.lsp.get_clients()
      local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
      for _, client in ipairs(clients) do
        if client.config.filetypes and vim.fn.index(client.config.filetypes, buf_ft) ~= -1 then
          return client.name
        end
      end
      return ""
    end

    -- Lualine sections for easier editing
    local lualine_c = {
      {
        require("noice").api.statusline.mode.get,
        cond = require("noice").api.statusline.mode.has,
        color = { fg = "#ff9e64" },
      },
      "filename",
    }

    local lualine_x = {
      { pomodoro_status, color = { fg = "#F26988" } },
      { lsp_client_name, color = { fg = "#2FBF77" }, icon = "" },
      "fileformat",
      "filetype",
    }

    local lualine_y = {
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
    }

    require("lualine").setup({
      options = {
        icons_enabled = true,
        theme = "auto",
        component_separators = { left = "", right = "" },
        section_separators = { left = '', right = '' },
        disabled_filetypes = { statusline = {}, winbar = {} },
        always_divide_middle = true,
        globalstatus = false,
        refresh = { statusline = 1000, tabline = 1000, winbar = 1000 },
      },
      sections = {
        lualine_a = { { 'mode', separator = { left = '' }, right_padding = 2 } },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = lualine_c,
        lualine_x = lualine_x,
        lualine_y = lualine_y,
        lualine_z = { { 'location', separator = { right = '' }, left_padding = 2 } },
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
