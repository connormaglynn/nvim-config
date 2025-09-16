return {
  "linux-cultist/venv-selector.nvim",
  dependencies = {
    "neovim/nvim-lspconfig",
    "mfussenegger/nvim-dap",
    "mfussenegger/nvim-dap-python",
    { "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } },
  },
  lazy = false,
  opts = {
    notify_user_on_venv_activation = true,
    auto_activate = true,
    name = ".venv",
    pipenv_path = vim.fn.expand("~/.local/share/virtualenvs"),
    pipenv_auto_detection = true,
  },
  keys = {
    { ",v", "<cmd>VenvSelect<cr>", desc = "Select Python venv" },
    { ",c", "<cmd>VenvSelectCached<cr>", desc = "Use cached Python venv" },
  },
}
