return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "antoinemadec/FixCursorHold.nvim", -- Required for Neotest
    "nvim-neotest/neotest-python", -- Python adapter for Neotest
  },
  opts = function()
    return {
      adapters = {
        require("neotest-python")({
          dap = { justMyCode = false },
          args = { "--log-level", "DEBUG" },
          runner = "pytest",
        }),
      },
    }
  end,
  config = function(_, opts)
    require("neotest").setup(opts)
  end,
}
