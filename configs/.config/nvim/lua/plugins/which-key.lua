return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
        -- your configuration comes here
        --     -- or leave it empty to use the default settings
        --         -- refer to the configuration section below
        --
    },
    keys = {
        {
            "<leader>?",
            function()
                require("which-key").show({ global = false })
            end,
            desc = "Buffer Local Keymaps (which-key)",
        },
    },

    config = function()
        local wk = require("which-key")

        wk.add({
            { "<leader>ll", "<cmd>Lazy load all<cr>",                                       desc = "Load plugins" },
            { "<leader>s",  "<cmd>w<cr>",                                                   desc = "Save" },
            { "<leader>q",  "<cmd>q<cr>",                                                   desc = "Quit" },
            { "<leader>Q",  "<cmd>qa!<cr>",                                                 desc = "Quit all" },
            { "<leader>e",  "<cmd>Oil --float<cr>",                                         desc = "Oil Nvim" },
            { "<leader>o",  "<cmd>Neotree focus<cr>",                                       desc = "Explorer focus" },
            { "<leader>c",  "<cmd>bd<cr>",                                                  desc = "Close buffer" },
            { "<leader>C",  "<cmd>bufdo bd!<cr>",                                           desc = "Close all buffers" },
            { "<leader>x",  "<cmd>BufferLinePickClose<cr>",                                 desc = "Pick Close buffer" },
            { "<leader>r",  "<cmd>w<cr>:sp | terminal python3 %<CR>",                       desc = "run python in a horizontal split" },
            { "<leader>j",  "<cmd>w<cr>:sp | terminal node %<CR>",                          desc = "run JS file in a horizontal split" },
            { "<leader>k",  "<cmd>w<cr>:sp | terminal cargo run % <CR>",                    desc = "Compile TS file" },
            { "<leader>h",  "<cmd>Alpha<CR>",                                               desc = "show dashboard" },
            { "<leader>gg", "<cmd>LazyGit<CR>",                                             desc = "open lazygit" },
            { "<leader>z",  "<cmd>lua require('telescope').extensions.notify.notify()<CR>", desc = "show notifications" },
            { "<leader>n",  "<cmd>enew<CR>",                                                desc = "new buffer" },
            { '"',          "<cmd>Telescope registers<CR>",                                 desc = "registers" },
            { "<leader>ww", "<C-w>w",                                                       desc = "focus next window" },
            { "<leader>ws", "<C-w>s",                                                       desc = "split window below" },
            { "<leader>wv", "<C-w>v",                                                       desc = "split window right" },
            { "<leader>wq", "<C-w>q",                                                       desc = "close window" },
            { "<leader>pm", "<cmd>Mason<CR>",                                               desc = "Mason" },
            { "<leader>pM", "<cmd>MasonUpdate<CR>",                                         desc = "MasonUpdate" },
            { "<leader>pa", "<cmd>Lazy update<CR>",                                         desc = "Update plugins" },
            { "<leader>ps", "<cmd>Lazy sync<CR>",                                           desc = "Sync plugins" },
            { "<leader>pU", "<cmd>Lazy check<CR>",                                          desc = "Check Update" },
            { "<leader>fa", "<cmd>Config <CR>",                                             desc = "Nvim config files" },
            { "<leader>fo", "<cmd>Telescope oldfiles<CR>",                                  desc = "open old files" },
            { "<leader>fc", "<cmd>Telescope commands<CR>",                                  desc = "commands" },
            { "<leader>fk", "<cmd>Telescope keymaps<CR>",                                   desc = "keymaps" },
            { "<leader>fh", "<cmd>Telescope help_tags<CR>",                                 desc = "help tags" },
            { "<leader>fd", "<cmd>Telescope diagnostics<CR>",                               desc = "diagnostics" },
            { "<leader>fg", "<cmd>Telescope live_grep<CR>",                                 desc = "live grep" },
            { "<leader>fb", "<cmd>Telescope buffers<CR>",                                   desc = "buffers" },
            { "<leader>fw", "<cmd>Telescope grep_string<CR>",                               desc = "grep string" },
            { "<leader>f/", "<cmd>Telescope current_buffer_fuzzy_find<CR>",                 desc = "fuzzy find in current buffer" },
            { "<leader>ff", "<cmd>Telescope find_files<CR>",                                desc = "find files" },
            { "<leader>fr", "<cmd>Telescope resume<CR>",                                    desc = "resume last search" },
            { "<leader>fm", "<cmd>Telescope marks<CR>",                                     desc = "marks" },
            { "<leader>ft", "<cmd>Telescope colorscheme<CR>",                               desc = "themes" },
            { "<leader>fz", "<cmd>Telescope zoxide list<CR>",                               desc = "zoxide" },
            { "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<CR>",                            desc = "rename" },
            { "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<CR>",                       desc = "code action" },
            { "<leader>ld", "<cmd>lua vim.diagnostic.open_float()<CR>",                     desc = "diagnostic" },
            { "<leader>lf", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>",            desc = "format" },
            { "<leader>lt", "<cmd>lua vim.lsp.buf.type_definition()<CR>",                   desc = "type definition" },
            { "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>",                    desc = "signature help" },
            { "<leader>lw", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>",              desc = "add workspace folder" },
            { "<leader>li", "<cmd>LspInfo<CR>",                                             desc = "lsp info" },
            { "<leader>d",  "<cmd>Noice dismiss<CR>",                                       desc = "dismiss notifications" },
            { "<leader>u",  "<cmd>UndotreeToggle<CR>",                                      desc = "undotree" },
            { "<leader>ic", "<cmd>Fitten toggle_chat<CR>",                                  desc = "Fitten chat [i]" },
            { "<leader>is", "<cmd>Fitten start_chat<CR>",                                   desc = "Start chat [s]" },
            { "<leader>th", "<cmd>split term://zsh<CR>",                                    desc = "horizontal terminal" },
            { "<leader>tv", "<cmd>vsplit term://zsh<CR>",                                   desc = "vertical terminal" },
            { "<leader>tf", "<cmd>FloatermToggle <CR>",                                     desc = "floating terminal" },
            { "<leader>D",  "<cmd>w<cr>:sp |terminal g++ % -o %:r && ./%:r<CR>",            desc = "compile and run c++" },
            { "<leader>m",  "<cmd>DBUIToggle<CR>",                                          desc = "Deploy DBUI" },
            { "<leader>y",  "<cmd>InspectTree<CR>",                                         desc = "Inspect tree" },
            { "<leader>o",  "<cmd>TSJToggle<CR>",                                           desc = "Toggle TSJ" }
        })
    end
}
