return function()
  local nls = require("null-ls")

  local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
  local on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr })
        end,
      })
    end
  end

  local sources = {
    nls.builtins.formatting.prettierd.with({
      filetypes = { "html", "javascript", "json", "typescript", "yaml", "markdown" },
    }),
    nls.builtins.formatting.eslint_d,
    nls.builtins.formatting.prettier,
    nls.builtins.diagnostics.shellcheck,
    nls.builtins.formatting.stylua,
    nls.builtins.formatting.black,
    nls.builtins.diagnostics.flake8,
    nls.builtins.code_actions.gitsigns,
  }

  nls.setup({
    sources = sources,
    on_attach = on_attach,
  })
end
