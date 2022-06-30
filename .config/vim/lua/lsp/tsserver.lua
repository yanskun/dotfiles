if vim.fn.exepath('typescript-language-server') ~= '' then
  local lspconfig = require('lspconfig')
  local util = require('libraries._set_lsp')

  local ts_utils = require'nvim-lsp-ts-utils'

  ts_utils.setup {
    debug = false,
    disable_commands = false,
    enable_import_on_completion = false,
    import_all_timeout = 5000,

    -- ESLint
    eslint_bin = 'eslint_d',
    eslint_config_fallback = nil,
    -- ESLint code actions
    eslint_enable_code_actions = true,
    eslint_enable_disable_comments = true,
    -- ESLint diagnostics
    eslint_enable_diagnostics = true,

    -- Formatting
    enable_formatting = true,
    formatter = 'prettier',
    formatter_config_fallback = nil,

    -- Parentheses completion
    complete_parens = false,
    signature_help_in_parens = false,

    -- Update imports on file move
    update_imports_on_move = true,
    require_confirmation_on_move = true,
    watch_dir = nil
  }

  lspconfig.tsserver.setup {
    root_dir = lspconfig.util.root_pattern("package.json"),
    on_attach = util.on_attach,
    capabilities = util.capabilities,
    flags = util.flags,
  }
else
  print('npm install -g typescript-language-server')
end
