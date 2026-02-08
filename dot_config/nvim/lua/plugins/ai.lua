local utils = require('libraries._set_config')

local conf = utils.conf

return {
  -- "github/copilot.vim",
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    config = function()
      require('copilot').setup({})
    end,
  },

  {
    'CopilotC-Nvim/CopilotChat.nvim',
    branch = 'main',
    dependencies = {
      { 'zbirenbaum/copilot.lua' }, -- or github/copilot.vim
      { 'nvim-lua/plenary.nvim' },  -- for curl, log wrapper
    },
    build = 'make tiktoken',        -- Only on MacOS or Linux
    opts = {
      debug = true,                 -- Enable debugging
      -- See Configuration section for rest
    },
    config = conf('copilot-chat'),
    -- See Commands section for default commands if you want to lazy load on them
  },

  -- {
  --   'yetone/avante.nvim',
  --   event = 'VeryLazy',
  --   lazy = false,
  --   version = false, -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.
  --   opts = {
  --     provider = 'copilot',
  --     auto_suggestions_provider = 'copilot',
  --     behaviour = {
  --       auto_suggestions = false,
  --       auto_set_highlight_group = true,
  --       auto_set_keymaps = true,
  --       auto_apply_diff_after_generation = false,
  --       support_paste_from_clipboard = false,
  --       minimize_diff = true,
  --     },
  --   },
  --   -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  --   build = 'make',
  --   -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
  --   dependencies = {
  --     'stevearc/dressing.nvim',
  --     'nvim-lua/plenary.nvim',
  --     'MunifTanjim/nui.nvim',
  --     --- The below dependencies are optional,
  --     'echasnovski/mini.pick',         -- for file_selector provider mini.pick
  --     'nvim-telescope/telescope.nvim', -- for file_selector provider telescope
  --     'hrsh7th/nvim-cmp',              -- autocompletion for avante commands and mentions
  --     'ibhagwan/fzf-lua',              -- for file_selector provider fzf
  --     'nvim-tree/nvim-web-devicons',   -- or echasnovski/mini.icons
  --     'zbirenbaum/copilot.lua',        -- for providers='copilot'
  --     -- {
  --     --   -- support for image pasting
  --     --   'HakonHarnes/img-clip.nvim',
  --     --   event = 'VeryLazy',
  --     --   opts = {
  --     --     -- recommended settings
  --     --     default = {
  --     --       embed_image_as_base64 = false,
  --     --       prompt_for_file_name = false,
  --     --       drag_and_drop = {
  --     --         insert_mode = true,
  --     --       },
  --     --       -- required for Windows users
  --     --       use_absolute_path = true,
  --     --     },
  --     --   },
  --     -- },
  --     -- {
  --     --   -- Make sure to set this up properly if you have lazy=true
  --     --   'MeanderingProgrammer/render-markdown.nvim',
  --     --   opts = {
  --     --     file_types = { 'markdown', 'Avante' },
  --     --   },
  --     --   ft = { 'markdown', 'Avante' },
  --     -- },
  --   },
  -- },

  {
    'ravitemer/mcphub.nvim',
    -- comment the following line to ensure hub will be ready at the earliest
    cmd = 'MCPHub',                          -- lazy load by default
    build = 'npm install -g mcp-hub@latest', -- Installs required mcp-hub npm module
    -- uncomment this if you don't want mcp-hub to be available globally or can't use -g
    -- build = "bundled_build.lua",  -- Use this and set use_bundled_binary = true in opts  (see Advanced configuration)
    config = function()
      require('mcphub').setup()
    end,
  },
}
