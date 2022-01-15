local cmp = require('cmp')

cmp.setup = {
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'ultisnips' },
    { name = 'buffer' },
  })
}

_G.vimrc = _G.vimrc or {}
_G.vimrc.cmp = _G.vimrc.cmp or {}
_G.vimrc.cmp.lsp = function()
  cmp.complete({
    config = {
      sources = {
        { name = 'nvim_lsp' }
      }
    }
  })
end
_G.vimrc.cmp.snippet = function()
  cmp.complete({
    config = {
      sources = {
        { name = 'ultisnips' },
      }
    }
  })
end
vim.cmd([[
  inoremap <C-x><C-o> <Cmd>lua vimrc.cmp.lsp()<CR>
  inoremap <C-x><C-s> <Cmd>lua vimrc.cmp.snippet()<CR>
]])

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
local servers = { 'vimls', 'gopls', 'sumneko_lua' }
for _, lsp in ipairs(servers) do
  require('lspconfig')[lsp].setup {
    capabilities = capabilities
  }
end
