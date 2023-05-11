-- customize mason plugins
return {
  -- use mason-lspconfig to configure LSP installations
  {
    "williamboman/mason-lspconfig.nvim",
    -- overrides `require("mason-lspconfig").setup(...)`
    opts = {
      ensure_installed = { "gopls" },
    },
  },
  -- use mason-null-ls to configure Formatters/Linter installation for null-ls sources
  {
    "jay-babu/mason-null-ls.nvim",
    -- overrides `require("mason-null-ls").setup(...)`
    opts = {
      ensure_installed = { "gofumpt", "goimports", "golangci-lint", "gomodifytags", "impl" },
    },
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    -- overrides `require("mason-nvim-dap").setup(...)`
    opts = {
      ensure_installed = { "delve" },

      handlers = {
        delve = function(source_name)
          local dap = require "dap"

          dap.adapters.delve = {
            type = "server",
            port = "${port}",
            executable = {
              command = "dlv",
              args = {"dap", "-l", "127.0.0.1:${port}"}
            },
          }

          dap.configurations.go = {
            {
              type = "delve",
              name = "klikit serve",
              request = "launch",
              program = "${workspaceFolder}",
              args = {"serve"},
            },
            {
              type = "delve",
              name = "klikit worker",
              request = "launch",
              program = "${workspaceFolder}",
              args = {"worker"},
            },
          }
        end,
      },
    },
  },
}
