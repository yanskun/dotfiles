return function()
  local ok, telescope = pcall(require, "telescope")

  if not ok then
    return
  end

  telescope.setup {
    defaults = {
      mappings = {
        i = {
          ["<C-h>"] = "which_key"
        }
      },
      file_ignore_patterns = {
        "node_modules/*",
      }
    },
    pickers = {
      live_grep = {
        additional_args = function()
          return { "--hidden" }
        end
      }
    }
  }

  local find_command = "{ 'rg', '--files', '--hidden', '-g', '!node_modules/**', '-g', '!.git/**', }"
  require('which-key').register({
    name = 'telescope',
    f = {
      f = { "<CMD>lua require('telescope.builtin').find_files({find_command = " .. find_command .. " })<CR>",
        "telescope find file" },
      g = { "<CMD>lua require('telescope.builtin').live_grep({find_command = " .. find_command .. " })<CR>",
        'telescope live grep' },
      b = { "<CMD>lua require('telescope.builtin').buffers({find_command = " .. find_command .. " })<CR>",
        'telescope buffers' },
      h = { "<CMD>lua require('telescope.builtin').help_tags()<CR>", 'telescope help tags' },
      o = { "<CMD>lua require('telescope.builtin').oldfiles({find_command = " .. find_command .. " })<CR>",
        'telescope old files' },
      c = { "<CMD>lua require('telescope.builtin').commands()<CR>", 'telescope commands' },
      k = { "<CMD>lua require('telescope.builtin').keymaps()<CR>", 'telescope key maps' },
      n = { "<CMD>lua require('telescope').extensions.notify.notify()<CR>", 'telescope notify' }
    },
  }, {
    prefix = "<leader>"
  })
end
