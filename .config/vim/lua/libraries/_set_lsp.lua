local M = {}

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
-- @param opts table
-- @usage opts.no_format boolean (default: false) Disable formatting on save
M.on_attach = function(client, bufnr, opts)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  require("which-key").add({
    name = "lsp",
    { "gD",        "<cmd>lua vim.lsp.buf.declaration()<CR>",                                desc = "Jumps to the declaration of the symbol under the cursor" },
    { "gd",        "<cmd>lua vim.lsp.buf.definition()<CR>",                                 desc = "Jumps to the definition of the symbol under the cursor" },
    { "K",         "<cmd>lua vim.lsp.buf.hover()<CR>",                                      desc = "Displays hover information about the symbol under the cursor in a floating window" },
    { "gi",        "<cmd>lua vim.lsp.buf.implementation()<CR>",                             desc = "Lists all the implementations for the symbol under the cursor in the quickfix window" },
    { "<C-k>",     "<cmd>lua vim.lsp.buf.signature_help()<CR>",                             desc = "Displays signature information about the symbol under the cursor in a floating window" },
    { "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>",                       desc = "Add the folder at path to the workspace folders" },
    { "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>",                    desc = "Remove the folder at path from the workspace folders" },
    { "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", desc = "List workspace folders" },
    { "<space>D",  "<cmd>lua vim.lsp.buf.type_definition()<CR>",                            desc = "Jumps to the definition of the type of the symbol under the cursor" },
    { "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>",                                     desc = "Rename old_fname to new_fname" },
    { "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>",                                desc = "Selects a code action available at the current cursor position" },
    { "gr",        "<cmd>lua vim.lsp.buf.references()<CR>",                                 desc = "Lists all the references to the symbol under the cursor in the quickfix window" },
    { "<space>f",  "<cmd>lua vim.lsp.buf.formatting()<CR>",                                 desc = "Formats the current buffer" },
  }, {
    buffer = 0,
  })

  -- if not opts.no_format and client.server_capabilities.documentFormattingProvider then
  if client.server_capabilities.documentFormattingProvider then
    vim.api.nvim_create_autocmd({ "BufWritePre" }, {
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format()
      end,
    })
  end

  require("illuminate").on_attach(client)
end

M.flags = {
  debounce_text_changes = 150,
}

-- M.capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
M.capabilities = require("cmp_nvim_lsp").default_capabilities()

return M
