return function()
  local luasnip_ok, ls = pcall(require, "luasnip")

  if not luasnip_ok then
    return
  end

  local helper = require("../libraries/_snippets")
  local snip = ls.snippet
  local func = ls.function_node
  local insert = ls.insert_node
  local fmt = require("luasnip.extras.fmt").fmt
  local fmta = require("luasnip.extras.fmt").fmta

  ls.add_snippets("all", {
    snip(
      "td",
      {
        func(function(_)
          return string.format(vim.bo.commentstring, ' TODO: ')
        end, { 1 }), helper.visual_insert(1)
      }
    ),
    snip(
      "co",
      {
        func(function(_)
          return string.format(vim.bo.commentstring, '')
        end, { 1 }), helper.visual_insert(1)
      }
    )
  })

  ls.add_snippets("go", {
    snip(
      "ife",
      fmta(
        [[
  if err != nil {
    <>
  }
  ]]     ,
        { insert(0) }
      )
    ),
  })

  ls.add_snippets("typescriptreact", {
    snip(
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
      ]], {
        insert(1, "func name"), insert(2, "text")
      },
        {
          delimiters = "[]"
        }
      )
    ),
  })

  require('luasnip.loaders.from_vscode').load()
end
