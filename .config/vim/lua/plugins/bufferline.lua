return function()
  require("bufferline").setup({
    options = {
      show_buffer_close_icons = false,
      show_close_icon = false,
      groups = {
        options = {
          toggle_hidden_on_enter = true, -- when you re-enter a hidden group this options re-opens that group so the buffer is visible
        },
        items = {
          {
            name = "Tests", -- Mandatory
            highlight = { underline = true, sp = "blue" }, -- Optional
            priority = 2, -- determines where it will appear relative to other groups (Optional)
            icon = "", -- Optional
            matcher = function(buf) -- Mandatory
              return buf.path:match("%test") or buf.path:match("%spec")
            end,
          },
          {
            name = "Docs",
            highlight = { undercurl = true, sp = "green" },
            auto_close = false, -- whether or not close this group if it doesn't contain the current buffer
            matcher = function(buf)
              return buf.path:match("%.md") or buf.path:match("%.txt")
            end,
            separator = { -- Optional
              style = require("bufferline.groups").separator.tab,
            },
          },
          {
            name = "Story",
            highlight = { undercurl = true, sp = "red" },
            auto_close = false, -- whether or not close this group if it doesn't contain the current buffer
            icon = "",
            matcher = function(buf)
              return buf.path:match("%.stories.tsx") or buf.path:match("%.stories.jsx")
            end,
            separator = { -- Optional
              style = require("bufferline.groups").separator.tab,
            },
          },
        },
      },
    },
  })

  require("which-key").add({
    { "<leader>1",       "<Cmd>BufferLineGoToBuffer 1<CR>",      hidden = true },
    { "<leader>2",       "<Cmd>BufferLineGoToBuffer 2<CR>",      hidden = true },
    { "<leader>3",       "<Cmd>BufferLineGoToBuffer 3<CR>",      hidden = true },
    { "<leader>4",       "<Cmd>BufferLineGoToBuffer 4<CR>",      hidden = true },
    { "<leader>5",       "<Cmd>BufferLineGoToBuffer 5<CR>",      hidden = true },
    { "<leader>6",       "<Cmd>BufferLineGoToBuffer 6<CR>",      hidden = true },
    { "<leader>7",       "<Cmd>BufferLineGoToBuffer 7<CR>",      hidden = true },
    { "<leader>8",       "<Cmd>BufferLineGoToBuffer 8<CR>",      hidden = true },
    { "<leader>9",       "<Cmd>BufferLineGoToBuffer 9<CR>",      desc = "bufferline: goto 9" },
    { "<leader><S-Tab>", "<Cmd>BufferLineCyclePrev<CR>",         desc = "bufferline: previous" },
    { "<leader><Tab>",   "<Cmd>BufferLineCycleNext<CR>",         desc = "bufferline: next" },
    { "<leader>gD",      "<Cmd>BufferLinePickClose<CR>",         desc = "bufferline: delete buffer" },
    { "<leader>gb",      "<Cmd>BufferLinePick<CR>",              desc = "bufferline: pick buffer" },
    { "<leader>gd",      "<Cmd>BufferLineGroupToggle Docs<CR>",  desc = "bufferline group toggle Docs" },
    { "<leader>gt",      "<Cmd>BufferLineGroupToggle Tests<CR>", desc = "bufferline group toggle Tests" },
    { "[b",              "<Cmd>BufferLineMovePrev<CR>",          desc = "bufferline: move prev" },
    { "]b",              "<Cmd>BufferLineMoveNext<CR>",          desc = "bufferline: move next" },
  })
end
