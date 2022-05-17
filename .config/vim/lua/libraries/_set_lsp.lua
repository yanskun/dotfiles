local M = {}

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
M.on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  require('which-key').register({
    name = 'lsp',
    ['gD'] = { '<cmd>lua vim.lsp.buf.declaration()<CR>' },
    ['gd'] = { '<cmd>lua vim.lsp.buf.definition()<CR>' },
    ['K'] = { '<cmd>lua vim.lsp.buf.hover()<CR>' },
    ['gi'] = { '<cmd>lua vim.lsp.buf.implementation()<CR>' },
    ['<C-k>'] = { '<cmd>lua vim.lsp.buf.signature_help()<CR>' },
    ['<space>wa'] = { '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>' },
    ['<space>wr'] = { '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>' },
    ['<space>wl'] = { '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>' },
    ['<space>D'] = { '<cmd>lua vim.lsp.buf.type_definition()<CR>' },
    ['<space>rn'] = { '<cmd>lua vim.lsp.buf.rename()<CR>' },
    ['<space>ca'] = { '<cmd>lua vim.lsp.buf.code_action()<CR>' },
    ['gr'] = { '<cmd>lua vim.lsp.buf.references()<CR>' },
    ['<space>f'] = { '<cmd>lua vim.lsp.buf.formatting()<CR>' },
  }, {
    buffer = bufnr,
  })

  require('illuminate').on_attach(client)
end


M.flags = {
  debounce_text_changes = 150,
}

M.capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

return M
