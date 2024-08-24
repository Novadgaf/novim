return {
  "williamboman/mason.nvim",
  config = function()
    require("mason").setup()
  end,
  dependencies = {
    {
      "stevearc/conform.nvim",
      config = function()
        require("conform").setup({
          formatters_by_ft = {
            c = { "clang_format" },
            cpp = { "clang_format" },
            javascript = { "prettier" },
            typescript = { "prettier" },
            json = { "prettier" },
            lua = { "stylua" },
            python = { "black" },
          },
        })
      end,
    },
    {
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      config = function()
        require("mason-tool-installer").setup({
          ensure_installed = {
            "prettier", -- JavaScript, TypeScript, JSON
            "stylua", -- Lua
            "clang-format", -- C, C++
            "black", -- Python
          },
          auto_update = true, -- Automatically update tools on startup
          run_on_start = true, -- Run the installer on startup
        })
      end,
    },
  },
}
