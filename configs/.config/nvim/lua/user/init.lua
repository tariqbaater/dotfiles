-- This file is executed when nvim is launched.

-- Install lazy.nvim if it's not already installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end

-- Add lazy.nvim to runtimepath
vim.opt.rtp:prepend(lazypath)

vim.g.maplocalleader = "\\" -- Same for `maplocalleader`
vim.g.mapleader = " "       -- Make sure to set `mapleader` before lazy so your mappings are correct

require("lazy").setup("plugins", {
    ui = {
        icons = {
            cmd = "⌘",
            config = "🛠",
            event = "📅",
            ft = "📂",
            init = "⚙",
            keys = "🗝",
            plugin = "🔌",
            runtime = "💻",
            source = "📄",
            start = "🚀",
            task = "📌",
            lazy = "💤 ",
        },
        border = "rounded",
        throttle = 100,
        expand = "",
        collapse = "",
        preview = "󰏥",
        close = "",
        link = "",
        scroll_down = "↓",
        scroll_up = "↑",
    },
    performance = {
        rtp = {
            disabled_plugins = {
                "gzip",
                -- "matchit",
                -- "matchparen",
                "netrwPlugin",
                "tarPlugin",
                -- "tohtml",
                "tutor",
                "zipPlugin",
            },
        },
    },
    change_detection = {
        notify = true,
    },
    install = {
        colorscheme = { "catpuccin", "tokyonight", "habamax", "kanagawa" },

    },
    checker = {
        enabled = true,
        notify = false,
        frequency = 3600,
    }

})

require("notify").setup({
    background_colour = "#000000",
})
