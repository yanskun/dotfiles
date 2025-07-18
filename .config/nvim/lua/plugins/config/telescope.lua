return function()
  local ok, telescope = pcall(require, 'telescope')

  if not ok then
    return
  end

  telescope.setup({
    defaults = {
      mappings = {
        i = {
          ['<C-h>'] = 'which_key',
        },
      },
      file_ignore_patterns = {
        'node_modules/*',
      },
      -- path_display         = function(opts, path)
      --   local tail = require("telescope.utils").path_tail(path)
      --   return tail
      --   -- return string.format("%s (%s)", tail, path)
      -- end,
      prompt_prefix = '  ',
      layout_config = {
        -- prompt_position = "top",
      },
    },
    pickers = {
      live_grep = {
        additional_args = function()
          return { '--hidden' }
        end,
      },
    },
    extensions = {
      egrepify = {
        prefixes = {
          ['#'] = {
            -- #$REMAINDER
            -- # is caught prefix
            -- `input` becomes $REMAINDER
            -- in the above example #lua,md -> input: lua,md
            flag = 'glob',
            cb = function(input)
              return string.format([[*.{%s}]], input)
            end,
          },
          -- filter for (partial) folder names
          -- example prompt: >conf $MY_PROMPT
          -- searches with ripgrep prompt $MY_PROMPT in paths that have "conf" in folder
          -- i.e. rg --glob="**/conf*/**" -- $MY_PROMPT
          ['>'] = {
            flag = 'glob',
            cb = function(input)
              return string.format([[**/{%s}*/**]], input)
            end,
          },
          -- filter for (partial) file names
          -- example prompt: &egrep $MY_PROMPT
          -- searches with ripgrep prompt $MY_PROMPT in paths that have "egrep" in file name
          -- i.e. rg --glob="*egrep*" -- $MY_PROMPT
          ['&'] = {
            flag = 'glob',
            cb = function(input)
              return string.format([[*{%s}*]], input)
            end,
          },
          ['!'] = {
            flag = 'invert-match',
          },
        },
      },
    },
  })

  -- extensions
  telescope.load_extension 'egrepify'
  telescope.load_extension 'cmdline'
  telescope.load_extension 'frecency'
  telescope.load_extension 'dir'

  --  see: https://github.com/nvim-telescope/telescope.nvim/issues/605#issuecomment-790805956
  local previewers = require('telescope.previewers')
  local builtin = require('telescope.builtin')

  local delta = previewers.new_termopen_previewer({
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
    end,
  })

  function My_git_status(opts)
    opts = opts or {}
    opts.previewer = delta

    builtin.git_status(opts)
  end

  local find_command = "{ 'rg', '--files', '--hidden', '-g', '!node_modules/**', '-g', '!.git/**', }"
  require('which-key').add({
    { '<leader>f', group = 'telescope' },
    -- {
    --   ':',
    --   '<cmd>Telescope cmdline<cr>',
    --   desc = 'telescope cmdline',
    -- },
    {
      '<leader>fb',
      "<CMD>lua require('telescope.builtin').buffers({find_command = " .. find_command .. ' })<CR>',
      desc = 'telescope buffers',
    },
    {
      '<leader>fc',
      "<CMD>lua require('telescope.builtin').commands()<CR>",
      desc = 'telescope commands',
    },
    {
      '<leader>fd',
      "<CMD>lua require('telescope.builtin').diagnostics({find_command = " .. find_command .. '})<CR>',
      desc = 'telescope diagnostics',
    },
    {
      '<leader>fe',
      "<CMD>lua require('telescope').extensions.egrepify.egrepify({find_command = " .. find_command .. ' })<CR>',
      desc = 'telescope live grep by egrepify',
    },
    {
      '<leader>fD',
      "<CMD>lua require('telescope').extensions.dir.find_files({ find_command = " .. find_command .. ' })<CR>',
      desc = 'telescope telescope find files in directory',
    },
    {
      '<leader>ff',
      "<CMD>lua require('telescope.builtin').find_files({find_command = " .. find_command .. ' })<CR>',
      desc = 'telescope find file',
    },
    {
      '<leader>fg',
      "<CMD>lua require('telescope.builtin').live_grep({find_command = " .. find_command .. ' })<CR>',
      desc = 'telescope live grep',
    },
    {
      '<leader>fD',
      "<CMD>lua require('telescope').extensions.dir.live_grep({ find_command = " .. find_command .. ' })<CR>',
      desc = 'telescope telescope grep in directory',
    },
    {
      '<leader>fh',
      "<CMD>lua require('telescope.builtin').help_tags()<CR>",
      desc = 'telescope help tags',
    },
    {
      '<leader>fk',
      "<CMD>lua require('telescope.builtin').keymaps()<CR>",
      desc = 'telescope key maps',
    },
    {
      '<leader>fn',
      "<CMD>lua require('telescope').extensions.notify.notify()<CR>",
      desc = 'telescope notify',
    },
    {
      '<leader>fo',
      "<CMD>lua require('telescope.builtin').oldfiles({find_command = " .. find_command .. ' })<CR>',
      desc = 'telescope old files',
    },
    {
      '<leader>fs',
      '<CMD>lua My_git_status()<CR>',
      desc = 'telescope git status',
    },
    {
      '<leader>fr',
      '<CMD>Telescope frecency workspace=CWD<CR>',
      desc = 'telescope fine file by frecency',
    },
  })
end
