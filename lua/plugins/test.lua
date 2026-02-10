return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "antoinemadec/FixCursorHold.nvim", -- Required for Neotest
    "nvim-neotest/neotest-python", -- Python adapter for Neotest
    "haydenmeade/neotest-jest",
  },
  opts = function()
    return {
      adapters = {
        require("neotest-python")({
          dap = { justMyCode = false },
          args = { "--log-level", "DEBUG" },
          runner = "pytest",
        }),
        require("neotest-jest")({
          jestCommand = "npm test --",
          jestArguments = function(defaultArguments, context)
            return defaultArguments
          end,
          env = { CI = true },
          cwd = function(path)
            return vim.fn.getcwd()
          end,
          isTestFile = require("neotest-jest.jest-util").defaultIsTestFile,
        }),
      },
    }
  end,
  config = function(_, opts)
    require("neotest").setup(opts)
  end,
}
