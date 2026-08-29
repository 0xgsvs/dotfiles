local opts = {
  snippets = { preset = "luasnip" },
  cmdline = {
    enabled = true,
  },
  appearance = { nerd_font_variant = "normal" },
  fuzzy = {
    implementation = "prefer_rust_with_warning",

    sorts = {
      "exact",
      "score",
      "sort_text",
    },
  },

  signature = { enabled = false, window = { border = "single", show_documentation = false } },
  sources = { default = { "lsp", "snippets", "buffer", "path" } },

  keymap = {
    preset = "default",
    ["<CR>"] = { "accept", "fallback" },
    ["<C-b>"] = { "scroll_documentation_up", "fallback" },
    ["<C-f>"] = { "scroll_documentation_down", "fallback" },
    ["<C-e>"] = { "hide_documentation", "show_documentation" },
    ["<Tab>"] = {},
    ["<S-Tab>"] = {},
    ["<C-space>"] = { "hide", "show" },
  },

  completion = {
    ghost_text = { enabled = false },
    documentation = {
      auto_show = false,
      auto_show_delay_ms = 0,
      window = { border = "none" },
    },
    accept = { auto_brackets = { enabled = true } },
    list = {
      selection = {
        preselect = false,
        auto_insert = true,
      },
    },
    menu = {
      auto_show = true,
    },
  },
}

return opts
