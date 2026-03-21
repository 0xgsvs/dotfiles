local M = {}
local map = vim.keymap.set

-- export on_attach & capabilities
M.on_attach = function(_, bufnr)
  local function opts(desc)
    return { buffer = bufnr, desc = "LSP " .. desc }
  end

  map("n", "<leader>ca", vim.lsp.buf.code_action, opts "Code Actions")
  map("n", "gD", vim.lsp.buf.declaration, opts "Go to declaration")
  map("n", "gd", vim.lsp.buf.definition, opts "Go to definition")
  map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts "Add workspace folder")
  map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts "Remove workspace folder")

  map("n", "<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, opts "List workspace folders")

  map("n", "<leader>D", vim.lsp.buf.type_definition, opts "Go to type definition")
  map("n", "<leader>cr", vim.lsp.buf.rename, opts "Rename")

  -- diagnostics
  map("n", "gn", function()
    vim.diagnostic.jump { count = 1 }
  end, { desc = "Jump to next diagnostic" })
  map("n", "gp", function()
    vim.diagnostic.jump { count = -1 }
  end, { desc = "Go to previous diagnostic" })

  vim.api.nvim_create_autocmd("DiagnosticChanged", {
    callback = function()
      vim.diagnostic.setloclist { open = false }
      vim.diagnostic.setqflist { open = false }
    end,
  })

  map("n", "<leader>ds", vim.diagnostic.setloclist, { desc = "LSP diagnostic loclist" })
  map("n", "<leader>dS", function()
    vim.diagnostic.setqflist()
  end, { desc = "LSP diagnostics (all buffers)" })
end

-- disable semanticTokens
M.on_init = function(client, _)
  if client:supports_method "textDocument/semanticTokens" then
    client.server_capabilities.semanticTokensProvider = nil
  end
end

M.capabilities = function()
  local ok, blink = pcall(require, "blink.cmp")
  if ok then
    return blink.get_lsp_capabilities()
  end
  return vim.lsp.protocol.make_client_capabilities()
end

vim.diagnostic.config {
  virtual_text = true,
  underline = true,
  float = { border = "single" },
}

vim.lsp.config("rust_analyzer", {})
vim.lsp.config("ts_ls", {})
vim.lsp.config("zls", {})
vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      workspace = {
        library = {
          vim.fn.expand "$VIMRUNTIME/lua",
          vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy",
          "${3rd}/luv/library",
        },
      },
    },
  },
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    M.on_attach(client, args.buf)
  end,
})

vim.lsp.config("*", { capabilities = M.capabilities(), on_init = M.on_init })

local servers = { "rust_analyzer", "lua_ls", "ts_ls", "zls" }

vim.lsp.enable(servers)
