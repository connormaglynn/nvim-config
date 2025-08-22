-- ~/.config/nvim/lua/plugins/snacks.lua
return {
  "folke/snacks.nvim",
  opts = {
    telescope = {
      live_grep = {
        additional_args = function()
          print("📦 snacks live_grep config loaded!") -- logging to confirm
          return {
            "--hidden",
            "--glob",
            "!.git/*",
          }
        end,
      },
    },
  },
  config = true, -- 👈 forces Lazy to use and merge this
}
