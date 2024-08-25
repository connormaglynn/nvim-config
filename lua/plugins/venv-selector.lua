return {
  "linux-cultist/venv-selector.nvim",
  branch = "regexp",
  -- cmd = "VenvSelect",
  -- enabled = function()
  --  return require("lazy.core.config").plugins["telescope.nvim"] ~= nil
  -- end,
  opts = {
    settings = {
      options = {
        notify_user_on_venv_activation = true,
        pipenv_path = "/Users/connor.glynn/.local/share/virtualenvs",
        pipenv_auto_detection = true, -- Automatically detect Pipenv files
        auto_activate = true, -- Automatically activate the Pipenv environment
      },
    },
  },
  --  Call config for python files and load the cached venv automatically
  ft = "python",
  keys = { { "<leader>cv", "<cmd>:VenvSelect<cr>", desc = "Select VirtualEnv", ft = "python" } },
}
