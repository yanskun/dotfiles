return function()
  local telescope = require('telescope')

  telescope.setup{
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
  }

  require('which-key').register {
    name = 'telescope',
    ['<leader>ff'] = { "<cmd>lua require('telescope.builtin').find_files({ hidden = true })<cr>", 'telescope find file' },
    ['<leader>fg'] = { "<cmd>lua require('telescope.builtin').live_grep({ hidden = true })<cr>", 'telescope live grep' },
    ['<leader>fb'] = { "<cmd>lua require('telescope.builtin').buffers({ hidden = true })<cr>", 'telescope buffers' },
    ['<leader>fh'] = { "<cmd>lua require('telescope.builtin').help_tags()<cr>", 'telescope help tags' },
    ['<leader>fo'] = { "<cmd>lua require('telescope.builtin').oldfiles({ hidden = true })<cr>", 'telescope old files' },
    ['<leader>fc'] = { "<cmd>lua require('telescope.builtin').commands()<cr>", 'telescope commands' },
    ['<leader>fk'] = { "<cmd>lua require('telescope.builtin').keymaps()<cr>", 'telescope key maps' },
  }
end
