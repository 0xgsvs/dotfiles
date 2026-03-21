local options = {
  preset = "helix",
  win = {
    border = "none",
  },
  spec = {
    { "<BS>", desc = "Decrement Selection", mode = "x" },
    { "<c-space>", desc = "Increment Selection", mode = { "x", "n" } },
    { "<leader>b", group = "Buffers" }, -- group
    { "<leader>g", group = "Git" }, -- group
    { "<leader>w", group = "Workspace" }, -- group
    { "<leader>c", group = "Code" }, -- group
    { "<leader>f", group = "Find" }, -- group
    { "<leader>s", group = "Search" }, -- group
    { "<leader>l", group = "Linter" }, -- group
    { "<leader>o", group = "Obsidian" }, -- group
    { "<leader>t", group = "Toggles and Trouble" }, -- group
  },
}

return options
