-- //========== keymaps ==========//

local map = vim.keymap.set

vim.keymap.set("n", "<leader>gn", function()
  require("gitsigns").next_hunk()
end, { desc = "Next Hunk" })

vim.keymap.set("n", "<leader>gp", function()
  require("gitsigns").prev_hunk()
end, { desc = "Prev Hunk" })

-- oil
local last_oil_dir = nil

-- Save dir whenever oil buffer is left for ANY reason (enter key, <C-n>, :q, etc.)
vim.api.nvim_create_autocmd("BufLeave", {
  pattern = "oil://*",
  callback = function()
    last_oil_dir = require("oil").get_current_dir()
  end,
})

map("n", "<C-n>", function()
  local oil = require "oil"
  if vim.bo.filetype == "oil" then
    oil.close()
  else
    oil.open(last_oil_dir)
  end
end)

-- telescope
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "telescope help page" })
map("n", "<leader>fm", "<cmd>Telescope marks<CR>", { desc = "telescope find marks" })
map("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", { desc = "telescope find oldfiles" })
map("n", "<leader>sg", "<cmd>Telescope live_grep<CR>", { desc = "telescope live grep" })
map("n", "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<CR>", { desc = "telescope find in current buffer" })
map("n", "<leader>sk", "<cmd>Telescope keymaps<CR>", { desc = "telescope search keymaps" })
map(
  "n",
  "<leader>fa",
  "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>",
  { desc = "telescope find all files" }
)
map(
  "n",
  "<leader>e",
  "<cmd>Telescope find_files follow=true no_ignore=false hidden=false<CR>",
  { desc = "telescope find all files" }
)

-- Redo keymap
map("n", "U", "<C-r>", { desc = "Redo" })

-- Swap v and V for visual modes
map("n", "<A-v>", "V", { noremap = true })

-- copy entire file
map("n", "<C-c>", "<cmd>:%y<CR>", { noremap = true })

-- comment
map("n", "<leader>;", "gcc", { desc = "comment toggle", remap = true })
map("v", "<leader>;", "gc", { desc = "comment toggle", remap = true })

-- pairing of brackets
map({ "n", "x", "s" }, "<a-e>", "%", { noremap = true, silent = true })

-- enter the command mode
map("n", ";s", "/", { desc = "Search inside the file" })
map("n", ";", ":", { desc = "CMD enter command mode" })
map("n", ";;", ":! ", { desc = "CMD enter command mode" })

-- shortcut for escape
map({ "i", "c" }, "jk", "<cmd>noh<CR><ESC>")
map({ "n", "i", "c" }, "<ESC>", "<cmd>noh<CR><ESC>")

-- terminal
map("t", "jk", "<C-\\><C-N>", { desc = "terminal escape terminal mode" })
map("t", "<ESC>", "<C-\\><C-N>", { desc = "terminal escape terminal mode" })

-- write and exit commands
map({ "n", "v" }, ";e", "<cmd> wqa <cr>")
map({ "n", "v" }, ";n", "<cmd> qa! <cr>")

-- move to beginning and end of line in normal and insert mode
map({ "n", "v", "o" }, "<S-h>", "^", { desc = "move beginning of line" })
map({ "n", "v", "o" }, "<S-l>", "g_", { desc = "move end of line" })

--remap of arrow keys
map({ "i" }, "<A-h>", "<Left>", { desc = "move left" })
map({ "i" }, "<A-l>", "<Right>", { desc = "move right" })
map({ "i" }, "<A-j>", "<Down>", { desc = "move down" })
map({ "i" }, "<A-k>", "<Up>", { desc = "move up" })

--navigating windows
map("n", "<A-h>", "<C-w>h", { desc = "switch window left" })
map("n", "<A-l>", "<C-w>l", { desc = "switch window right" })
map("n", "<A-k>", "<c-w>k", { desc = "switch window up" })
map("n", "<A-j>", "<C-w>j", { desc = "switch window down" })

-- Buffer navigation
map("n", "<tab>", ":bnext<CR>", { desc = "Buffer goto next" })
map("n", "<S-tab>", ":bprev<CR>", { desc = "Buffer goto prev" })

-- Delete current buffer
map("n", "<leader>bd", ":bdelete<CR>", { desc = "[B]uffer [D]elete" })

-- Delete all buffers except current
map("n", "<leader>bo", function()
  local current = vim.api.nvim_get_current_buf()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if buf ~= current and vim.api.nvim_buf_is_loaded(buf) then
      vim.api.nvim_buf_delete(buf, { force = false })
    end
  end
end, { desc = "Delete other buffers" })

-- Auto-save session on exit
vim.api.nvim_create_autocmd("VimLeavePre", {
  callback = function()
    vim.cmd("mksession! " .. vim.fn.stdpath "data" .. "/last-session.vim")
  end,
})

-- Restore last session keymap
vim.keymap.set("n", "<leader>q", function()
  local session = vim.fn.stdpath "data" .. "/last-session.vim"
  if vim.fn.filereadable(session) == 1 then
    vim.cmd("source " .. session)
  else
    vim.notify("No session found", vim.log.levels.WARN)
  end
end, { desc = "Restore Last Session" })
