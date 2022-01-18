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
    f = {
      f = { "<cmd>lua require('telescope.builtin').find_files({ hidden = true })<cr>" },
      g = { "<cmd>lua require('telescope.builtin').live_grep({ hidden = true })<cr>" },
      b = { "<cmd>lua require('telescope.builtin').buffers({ hidden = true })<cr>" },
      h = { "<cmd>lua require('telescope.builtin').help_tags()<cr>" },
      o = { "<cmd>lua require('telescope.builtin').oldfiles({ hidden = true })<cr>" },
      c = { "<cmd>lua require('telescope.builtin').commands()<cr>" },
      k = { "<cmd>lua require('telescope.builtin').keymaps()<cr>" },
    }
  }
end
