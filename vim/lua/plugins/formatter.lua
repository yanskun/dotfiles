local prettierConfig = function()
  return {
    exe = "prettier",
    args = {"--stdin-filepath", vim.fn.shellescape(vim.api.nvim_buf_get_name(0)), "--single-quote"},
    stdin = true
  }
end

local formatterConfig = {
  lua = {
    function()
      return {
        exe = "luafmt",
        args = {"--indent-count", 2, "--stdin"},
        stdin = true
      }
    end
  },
  vue = {
    function()
      return {
        exe = "prettier",
        args = {
          "--stdin-filepath",
          vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)),
          "--single-quote",
          "--parser",
          "vue"
        },
        stdin = true
      }
    end
  },
}

local commonFT = {
  "css",
  "scss",
  "html",
  "java",
  "javascript",
  "javascriptreact",
  "typescript",
  "typescriptreact",
  "markdown",
  "markdown.mdx",
  "json",
  "yaml",
  "xml",
  "svg"
}
for _, ft in ipairs(commonFT) do
  formatterConfig[ft] = {prettierConfig}
end

return function()
  require('formatter').setup {
    logging = true,
    formatters = formatterConfig,
  }
end
