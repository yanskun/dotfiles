return function()
  local telescope = require('telescope')

  telescope.setup{
    defaults = {
      -- Default configuration for telescope goes here:
      -- config_key = value,
      mappings = {
        i = {
          -- map actions.which_key to <C-h> (default: <C-/>)
          -- actions.which_key shows the mappings for your picker,
          -- e.g. git_{create, delete, ...}_branch for the git_branches picker
          ["<C-h>"] = "which_key"
        }
      }
    },
    pickers = {
      -- Default configuration for builtin pickers goes here:
      -- picker_name = {
      --   picker_config_key = value,
      --   ...
      -- }
      -- Now the picker_config_key will be applied every time you call this
      -- builtin picker
    },
    extensions = {
      -- Your extension configuration goes here:
      -- extension_name = {
      --   extension_config_key = value,
      -- }
      -- please take a look at the readme of the extension you want to configure
    }
  }

  require('which-key').register {
    ['<leader>ff'] = { "<cmd>lua require('telescope.builtin').find_files({ hidden = true })<cr>", 'telescope find file' },
    ['<leader>fg'] = { "<cmd>lua require('telescope.builtin').live_grep({ hidden = true })<cr>", 'telescope live grep' },
    ['<leader>fb'] = { "<cmd>lua require('telescope.builtin').buffers({ hidden = true })<cr>", 'telescope buffers' },
    ['<leader>fh'] = { "<cmd>lua require('telescope.builtin').help_tags()<cr>", 'telescope help tags' },
    ['<leader>fo'] = { "<cmd>lua require('telescope.builtin').oldfiles({ hidden = true })<cr>", 'telescope old files' },
    ['<leader>fc'] = { "<cmd>lua require('telescope.builtin').commands()<cr>", 'telescope commands' },
    ['<leader>fk'] = { "<cmd>lua require('telescope.builtin').keymaps()<cr>", 'telescope key maps' },
  }
end
