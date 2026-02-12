-- Install the wrapper and Mason, but do not build vscode-js-debug from source.
-- Best practice: use Mason prebuilt binaries to avoid node-gyp issues.
-- References:
-- - nvim-dap-vscode-js: https://github.com/mxsdev/nvim-dap-vscode-js
-- - Mason: https://github.com/mason-org/mason.nvim

return {
  {
    "mxsdev/nvim-dap-vscode-js",
    dependencies = {
      "mfussenegger/nvim-dap",
      "mason-org/mason.nvim",
    },
  },
}
