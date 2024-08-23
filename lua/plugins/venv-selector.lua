return {
  "linux-cultist/venv-selector.nvim",
  branch = "main", -- Use this branch for the new version
  cmd = "VenvSelect",
  enabled = function()
	  return require("lazy.core.config").plugins["telescope.nvim"] ~= nil
  end,
  opts = {
    settings = {
      options = {
        notify_user_on_venv_activation = true,
        pipenv_path = "/Users/connor.glynn/.local/share/virtualenvs",
      },
    },
  },
  --  Call config for python files and load the cached venv automatically
  ft = "python",
  keys = { { "<leader>cv", "<cmd>:VenvSelect<cr>", desc = "Select VirtualEnv", ft = "python" } },
}
