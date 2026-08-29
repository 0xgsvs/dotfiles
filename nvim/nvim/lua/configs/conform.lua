local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    nix = { "treefmt" },
  },

  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },

  lsp_format = {
    async = true,
    timeout_ms = 1000,
  },

  formatters = {
    treefmt = {
      cwd = require("conform.util").root_file { "treefmt.toml", ".treefmt.toml", "flake.nix" },
    },
  },
}

return options
