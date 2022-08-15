return function()
  local luasnip_ok, ls = pcall(require, "luasnip")

  if not luasnip_ok then
    return
  end

  local s = ls.snippet
  local f = ls.function_node
  local i = ls.insert_node
  local fmt = require("luasnip.extras.fmt").fmt
  local fmta = require("luasnip.extras.fmt").fmta

  local comment = function()
    return string.format(vim.bo.commentstring, " TODO: ")
  end

  ls.add_snippets("all", {
    s("td", f(comment, { i(0) })),
  })

  ls.add_snippets("go", {
    s(
      "ife",
      fmta(
        [[
  if err != nil {
    <>
  }
  ]]     ,
        { i(0) }
      )
    ),
  })

  ls.add_snippets("typescriptreact", {
    s(
      "fr",
      fmt([[
/** @jsx h */
import { h } from "preact";

export default function []() {
  return (
    <div>
      []
    </div>
  );
}
  ]],   {
          i(1, "func name"), i(2, "text")
        },
        {
          delimiters = "[]"
        }
      )
    ),
  })

  require('luasnip.loaders.from_vscode').load()
end
