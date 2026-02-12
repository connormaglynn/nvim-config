return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "mxsdev/nvim-dap-vscode-js",
      "mason-org/mason.nvim",
    },
    config = function()
      local dap = require("dap")

      local mason_debugger_entry = vim.fn.stdpath("data")
        .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js"

      dap.adapters["pwa-node"] = {
        type = "server",
        host = "127.0.0.1",
        port = "${port}",
        executable = {
          command = "node",
          args = { mason_debugger_entry, "${port}", "127.0.0.1" },
        },
      }

      dap.configurations.javascript = {
        {
          type = "pwa-node",
          request = "launch",
          name = "Launch current file (Node)",
          program = "${file}",
          cwd = "${workspaceFolder}",
          console = "internalConsole",
          stopOnEntry = true,
        },
      }

      -- Reuse for TypeScript.
      dap.configurations.typescript = dap.configurations.javascript
    end,
  },
}
