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
  require('which-key').register {
    name = 'telescope',
    ['<leader>ff'] = { "<cmd>lua require('telescope.builtin').find_files({find_command = " .. find_command .. " })<cr>",
      'telescope find file' },
    ['<leader>fg'] = { "<cmd>lua require('telescope.builtin').live_grep({find_command = " .. find_command .. " })<cr>",
      'telescope live grep' },
    ['<leader>fb'] = { "<cmd>lua require('telescope.builtin').buffers({find_command = " .. find_command .. " })<cr>",
      'telescope buffers' },
    ['<leader>fh'] = { "<cmd>lua require('telescope.builtin').help_tags()<cr>", 'telescope help tags' },
    ['<leader>fo'] = { "<cmd>lua require('telescope.builtin').oldfiles({find_command = " .. find_command .. " })<cr>",
      'telescope old files' },
    ['<leader>fc'] = { "<cmd>lua require('telescope.builtin').commands()<cr>", 'telescope commands' },
    ['<leader>fk'] = { "<cmd>lua require('telescope.builtin').keymaps()<cr>", 'telescope key maps' },
  }
end
