return {
  "ravitemer/mcphub.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  build = "npm install -g mcp-hub@latest", -- Installs `mcp-hub` node binary globally
  config = function()
    require("mcphub").setup({
      extensions = {
        avante = {
          make_slash_commands = true, -- make /slash commands from MCP server prompts
        }
      },
      auto_approve = true,            -- automatically approve MCP server prompts
      auto_toggle_mcp_servers = true, -- Let LLMs start and stop MCP servers automatically
    })
  end
}
