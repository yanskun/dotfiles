if vim.fn.exepath('efm-langserver') ~= '' then
  local lspconfig = require('lspconfig')

  -- javaScript, TypeScript, React
  local eslint = {
    lintCommand = "./node_modules/.bin/eslint -f unix --stdin --stdin-filename ${INPUT}",
    lintIgnoreExitCode = true,
    lintStdin = true,
    lintFormats = { "%f:%l:%c: %m" },
    formatCommand = "./node_modules/.bin/eslint --fix-to-stdout --stdin --stdin-filename=${INPUT}",
    formatStdin = true
  }
  local prettier = {
    formatCommand = "./node_modules/.bin/prettier --stdin-filepath ${INPUT}",
    formatStdin = true,
  }

  -- YAML
  local prettier_yaml = {
    formatCommand = "prettier --stdin-filepath ${INPUT}",
    formatStdin = true,
  }

  -- Lua
  local luaFormat = {
    formatCommand = "lua-format -i --no-keep-simple-function-one-line --column-limit=120",
    formatStdin = true
  }

  lspconfig.efm.setup {
    init_options = {documentFormatting = true, codeAction = false},
    filetypes = { "javascriptreact", "javascript", "typescriptreact", "typescript", "css", "lua", "json", "yaml" },
    settings = {
      rootMarkers = {".git/"},
      languages = {
        javascriptreact = { eslint, prettier },
        javascript = { eslint, prettier },
        typescriptreact = { eslint, prettier },
        typescript = { eslint, prettier },
        css = { prettier },
        lua = { luaFormat },
        json = { prettier },
        yaml = {prettier_yaml},
      }
    }
  }
else
  print('brew install efm-langserver')
end
