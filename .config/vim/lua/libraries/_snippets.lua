local luasnip = require 'luasnip'

local node = luasnip.snippet_node
local text = luasnip.text_node
local insert = luasnip.insert_node
local dynamic = luasnip.dynamic_node

local M = {}

function M.visual_insert(jump, placeholder)
  return dynamic(jump, function(_, snippet)
    local selected_txt = snippet.env.TM_SELECTED_TEXT
    if selected_txt and selected_txt[1] then
      if #selected_txt == 1 then
        return node(nil, { text(selected_txt), insert(1) })
      else
        return node(nil, { text { '', '' }, text(selected_txt), insert(1), text { '', '' } })
      end
    else
      return node(nil, { insert(1, placeholder or '') })
    end
  end)
end

return M
