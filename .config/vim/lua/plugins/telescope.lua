return function()
  local ok, telescope = pcall(require, "telescope")

  if not ok then
    return
  end

  telescope.setup {
    defaults = {
      mappings             = {
        i = {
          ["<C-h>"] = "which_key"
        }
      },
      file_ignore_patterns = {
        "node_modules/*",
      },
      -- path_display         = function(opts, path)
      --   local tail = require("telescope.utils").path_tail(path)
      --   return tail
      --   -- return string.format("%s (%s)", tail, path)
      -- end,
      prompt_prefix        = '  ',
      layout_config        = {
        -- prompt_position = "top",
      },
    },
    pickers = {
      live_grep = {
        additional_args = function()
          return { "--hidden" }
        end
      },
    },
    extensions = {
      egrepify = {
        prefixes = {
          ["!"] = {
            flag = "invert-match",
          },
        }
      }
    }
  }

  -- extensions
  telescope.load_extension "egrepify"

  --  see: https://github.com/nvim-telescope/telescope.nvim/issues/605#issuecomment-790805956
  local previewers = require('telescope.previewers')
  local builtin = require('telescope.builtin')

  local delta = previewers.new_termopen_previewer {
    get_command = function(entry)
      -- this is for status
      -- You can get the AM things in entry.status. So we are displaying file if entry.status == '??' or 'A '
      -- just do an if and return a different command
      if entry.status == '??' or 'A ' then
        return { 'git', '-c', 'core.pager=delta', '-c', 'delta.side-by-side=false', 'diff', entry.value }
      end

      -- note we can't use pipes
      -- this command is for git_commits and git_bcommits
      return { 'git', '-c', 'core.pager=delta', '-c', 'delta.side-by-side=false', 'diff', entry.value .. '^!' }
    end
  }

  function My_git_status(opts)
    opts = opts or {}
    opts.previewer = delta

    builtin.git_status(opts)
  end

  local find_command = "{ 'rg', '--files', '--hidden', '-g', '!node_modules/**', '-g', '!.git/**', }"
  require('which-key').register({
    name = 'telescope',
    f = {
      f = { "<CMD>lua require('telescope.builtin').find_files({find_command = " .. find_command .. " })<CR>",
        "telescope find file" },
      g = { "<CMD>lua require('telescope.builtin').live_grep({find_command = " .. find_command .. " })<CR>",
        'telescope live grep' },
      -- g = { "<CMD>lua require('telescope').extensions.egrepify.egrepify({find_command = " .. find_command .. " })<CR>",
      --   'telescope live grep' },
      b = { "<CMD>lua require('telescope.builtin').buffers({find_command = " .. find_command .. " })<CR>",
        'telescope buffers' },
      h = { "<CMD>lua require('telescope.builtin').help_tags()<CR>", 'telescope help tags' },
      o = { "<CMD>lua require('telescope.builtin').oldfiles({find_command = " .. find_command .. " })<CR>",
        'telescope old files' },
      c = { "<CMD>lua require('telescope.builtin').commands()<CR>", 'telescope commands' },
      k = { "<CMD>lua require('telescope.builtin').keymaps()<CR>", 'telescope key maps' },
      n = { "<CMD>lua require('telescope').extensions.notify.notify()<CR>", 'telescope notify' },
      s = { "<CMD>lua My_git_status()<CR>", 'telescope git status' },
    },
  }, {
    prefix = "<leader>"
  })
end
