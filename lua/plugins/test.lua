return {
  "nvim-neotest/neotest",
  dependencies = {
    "neotest-python",
  },
  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-python")({
          dap = { justMyCode = false },
          args = { "--log-level", "DEBUG" },
          runner = "pytest",
        }),
      },
    })
  end,
}
