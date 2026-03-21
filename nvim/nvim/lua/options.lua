-- //========== options ==========//

local opt = vim.opt
local o = vim.o
local g = vim.g

------------------------------------ globals -----------------------------------------
g.autoformat = true
opt.shell = "/usr/sbin/fish"
----------------------------- options -----------------------------------------

if vim.fn.has "wsl" == 1 then
  vim.g.clipboard = {
    name = "WslClipboard",
    copy = {
      ["+"] = "clip.exe",
      ["*"] = "clip.exe",
    },
    paste = {
      ["+"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
      ["*"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
    },
    cache_enabled = 0,
  }
end

-- Lua
o.encoding = "utf-8"
o.fileencoding = "utf-8"

g.have_nerd_font = true

vim.diagnostic.enable(true)

o.clipboard = "unnamedplus"
o.termguicolors = true

o.breakindent = true
o.updatetime = 250

o.cursorline = true
o.cursorlineopt = "both" -- to enable cursorline!

o.laststatus = 3
o.showmode = false
o.splitkeep = "screen"

-- Indenting
o.expandtab = true
o.shiftwidth = 2
o.autoindent = true -- Automatically indent new lines
o.smartindent = true
o.tabstop = 2
o.softtabstop = 2
o.scrolloff = 28 -- Lines of context
o.winborder = "solid"
-- bold, double, none, rounded,shadow,single,solid

o.list = true
vim.opt.listchars = { tab = "| ", leadmultispace = "|   ", trail = "·", nbsp = "␣" }

opt.colorcolumn = "80,120"
vim.o.inccommand = "split"

opt.confirm = true -- Confirm to save changes before exiting modified buffer
opt.fillchars = { eob = "~" }
o.ignorecase = true
o.smartcase = true
o.mouse = "a"

-- Numbers
o.number = true
o.relativenumber = true
o.numberwidth = 2
o.ruler = false

-- disable nvim intro
-- opt.shortmess:append "sI"

o.signcolumn = "yes"
o.splitbelow = true
o.splitright = true
o.timeoutlen = 300
o.undofile = true

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
opt.whichwrap:append "<>[]hl"

-- disable some default providers
g.loaded_node_provider = 0
g.loaded_python3_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0

-- add binaries installed by mason.nvim to path
local is_windows = vim.fn.has "win32" ~= 0
local sep = is_windows and "\\" or "/"
local delim = is_windows and ";" or ":"
vim.env.PATH = table.concat({ vim.fn.stdpath "data", "mason", "bin" }, sep) .. delim .. vim.env.PATH
