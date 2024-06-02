-- https://rust-analyzer.github.io/manual.html#rust-analyzer-language-server-binary

if vim.fn.exepath("rust-analyzer") ~= "" and vim.fn.exepath("rustfmt") ~= "" then
  local lspconfig = require("lspconfig")
  local util = require("libraries._set_lsp")

  lspconfig.rust_analyzer.setup({
    cmd = { "rust-analyzer" },
    filetypes = { "rust" },
    root_dir = lspconfig.util.root_pattern("Cargo.toml", "rust-project.json"),
    -- https://rust-analyzer.github.io/manual.html#nvim-lsp
    settings = {
      ["rust-analyzer"] = {
        assist = {
          importGranularity = "module",
          importPrefix = "self",
        },
        cargo = {
          loadOutDirsFromCheck = true
        },
        procMacro = {
          enable = true
        },
      }
    },
    on_attach = util.on_attach,
    capabilities = util.capabilities,
    flags = util.flags,
  })
else
  vim.notify(
    [[mkdir -p ~/.local/bin
curl -L https://github.com/rust-lang/rust-analyzer/releases/latest/download/rust-analyzer-aarch64-apple-darwin.gz | gunzip -c - > ~/.local/bin/rust-analyzer
chmod +x ~/.local/bin/rust-analyzer
rustup component add rustfmt]],
    vim.log.levels.WARN,
    { title = 'rust-analyzer' }
  )
end
