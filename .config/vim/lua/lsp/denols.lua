if vim.fn.exepath("deno") ~= "" then
  vim.g.markdown_fenced_languages = {
    "ts=typescript",
  }

  local lspconfig = require("lspconfig")
  local util = require("libraries._set_lsp")

  lspconfig.denols.setup({
    cmd = { "deno", "lsp" },
    root_dir = lspconfig.util.root_pattern("deno.json"),
    on_attach = util.on_attach,
    capabilities = util.capabilities,
    flags = util.flags,
    init_options = {
      lint = true,
      unstable = true,
      suggest = {
        imports = {
          hosts = {
            ["https://deno.land"] = true,
            ["https://cdn.nest.land"] = true,
            ["https://crux.land"] = true,
          },
        },
      },
    },
  })
else
  vim.notify(
    'asdf install deno latest',
    vim.log.levels.WARN,
    { title = 'denols' }
  )
end
