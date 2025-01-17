return {
  -- Treesitter Configuration
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- Ensure Markdown and HTML parsers are installed
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "markdown", "html" })

      -- Set filetype for .html.md.erb files to markdown
      vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
        pattern = "*.html.md.erb",
        callback = function()
          vim.bo.filetype = "markdown"
        end,
      })
    end,
  },

  -- LSP Configuration
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ruby_lsp = {
          -- Restrict Ruby LSP to .rb files only
          filetypes = { "ruby" },
        },
      },
    },
  },
}
