local function find_nearest_scaffdog_root(start_path)
  local uv = vim.loop
  local function is_scaffdog_root(path)
    local config = uv.fs_stat(path .. '/scaffdog.config.ts')
      or uv.fs_stat(path .. '/scaffdog.config.js')
      or uv.fs_stat(path .. '/.scaffdog')
    return config ~= nil
  end

  local function dirname(path)
    return vim.fn.fnamemodify(path, ':h')
  end

  local current = vim.fn.fnamemodify(start_path, ':p')
  while current ~= '/' do
    if is_scaffdog_root(current) then
      return current
    end
    current = dirname(current)
  end
  return nil
end

return function()
  local ok, neo_tree = pcall(require, 'neo-tree')

  if not ok then
    return
  end

  vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

  vim.fn.sign_define('DiagnosticSignError', { text = ' ', texthl = 'DiagnosticSignError' })
  vim.fn.sign_define('DiagnosticSignWarn', { text = ' ', texthl = 'DiagnosticSignWarn' })
  vim.fn.sign_define('DiagnosticSignInfo', { text = ' ', texthl = 'DiagnosticSignInfo' })
  vim.fn.sign_define('DiagnosticSignHint', { text = '󰌵', texthl = 'DiagnosticSignHint' })

  neo_tree.setup({
    close_if_last_window = true,
    popup_border_style = 'rounded',
    enable_git_status = true,
    enable_diagnostics = true,
    default_component_configs = {
      container = {
        enable_character_fade = true,
      },
      indent = {
        indent_size = 2,
        padding = 1, -- extra padding on left hand side
        -- indent guides
        with_markers = true,
        indent_marker = '│',
        last_indent_marker = '└',
        highlight = 'NeoTreeIndentMarker',
        -- expander config, needed for nesting files
        with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
        expander_collapsed = '',
        expander_expanded = '',
        expander_highlight = 'NeoTreeExpander',
      },
      icon = {
        folder_closed = '',
        folder_open = '',
        folder_empty = 'ﰊ',
        -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
        -- then these will never be used.
        default = '*',
        highlight = 'NeoTreeFileIcon',
      },
      modified = {
        symbol = '[+]',
        highlight = 'NeoTreeModified',
      },
      name = {
        trailing_slash = false,
        use_git_status_colors = true,
        highlight = 'NeoTreeFileName',
      },
      git_status = {
        symbols = {
          -- Change type
          added = '✚', -- or "✚", but this is redundant info if you use git_status_colors on the name
          modified = '', -- or "", but this is redundant info if you use git_status_colors on the name
          deleted = '✖', -- this can only be used in the git_status source
          renamed = '󰁕', -- this can only be used in the git_status source
          -- Status type
          untracked = '',
          ignored = '',
          unstaged = '󰄱',
          staged = '',
          conflict = '',
        },
      },
      type = {
        enabled = false,
      },
      last_modified = {
        enabled = false,
      },
    },
    commands = {
      scaffdog_generate = function(state)
        local node = state.tree:get_node()
        local path = node.path
        local target_path = node.type == 'directory' and path or vim.fn.fnamemodify(path, ':h')

        -- 🔍 scaffdog root を探す
        local scaffdog_root = find_nearest_scaffdog_root(target_path)
        if not scaffdog_root then
          vim.notify('No .scaffdog or scaffdog.config.ts found in parent dirs', vim.log.levels.ERROR)
          return
        end
        scaffdog_root = vim.fn.fnamemodify(scaffdog_root, ':p')
        local relative_path = vim.fs.relpath(scaffdog_root, target_path)

        -- ターミナルバッファ作成
        local buf = vim.api.nvim_create_buf(false, true)
        local width = math.floor(vim.o.columns * 0.8)
        local height = math.floor(vim.o.lines * 0.8)
        local row = math.floor((vim.o.lines - height) / 2)
        local col = math.floor((vim.o.columns - width) / 2)

        vim.api.nvim_open_win(buf, true, {
          relative = 'editor',
          row = row,
          col = col,
          width = width,
          height = height,
          style = 'minimal',
          border = 'rounded',
        })

        -- scaffdog root に cd して実行
        local cmd = string.format(
          'cd %s && npx scaffdog generate -o %s',
          vim.fn.shellescape(scaffdog_root),
          vim.fn.shellescape(relative_path)
        )
        vim.fn.termopen({ 'sh', '-c', cmd })

        vim.cmd('startinsert')
      end,
    },
    window = {
      position = 'left',
      width = 30,
      mapping_options = {
        noremap = true,
        nowait = true,
      },
      mappings = {
        ['<space>'] = {
          'toggle_node',
          nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use
        },
        ['<2-LeftMouse>'] = 'open',
        ['<cr>'] = 'open',
        ['S'] = 'open_split',
        ['s'] = 'open_vsplit',
        -- ["S"] = "split_with_window_picker",
        -- ["s"] = "vsplit_with_window_picker",
        ['t'] = 'open_tabnew',
        ['w'] = 'open_with_window_picker',
        ['C'] = 'close_node',
        ['a'] = {
          'add',
          -- some commands may take optional config options, see `:h neo-tree-mappings` for details
          config = {
            show_path = 'none', -- "none", "relative", "absolute"
          },
        },
        ['A'] = 'add_directory', -- also accepts the config.show_path option.
        ['d'] = 'delete',
        ['r'] = 'rename',
        ['y'] = 'copy_to_clipboard',
        ['x'] = 'cut_to_clipboard',
        ['p'] = 'paste_from_clipboard',
        ['c'] = 'copy', -- takes text input for destination
        ['m'] = 'move', -- takes text input for destination
        ['q'] = 'close_window',
        ['R'] = 'refresh',
        ['?'] = 'show_help',
        ['G'] = 'scaffdog_generate',
      },
    },
    nesting_rules = {},
    filesystem = {
      filtered_items = {
        visible = false, -- when true, they will just be displayed differently than normal items
        hide_dotfiles = false,
        hide_gitignored = true,
        hide_hidden = true, -- only works on Windows for hidden files/directories
        hide_by_name = {
          '.git',
          'node_modules',
        },
        hide_by_pattern = { -- uses glob style patterns
          --"*.meta"
        },
        never_show = { -- remains hidden even if visible is toggled to true
          '.DS_Store',
          --"thumbs.db"
        },
        never_show_by_pattern = { -- uses glob style patterns
          --".null-ls_*",
        },
      },
      follow_current_file = {
        enabled = false, -- This will find and focus the file in the active buffer every
      },
      -- time the current file is changed while the tree is open.
      group_empty_dirs = false, -- when true, empty folders will be grouped together
      hijack_netrw_behavior = 'open_default', -- netrw disabled, opening a directory opens neo-tree
      -- in whatever position is specified in window.position
      -- "open_current",  -- netrw disabled, opening a directory opens within the
      -- window like netrw would, regardless of window.position
      -- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
      use_libuv_file_watcher = false, -- This will use the OS level file watchers to detect changes
      -- instead of relying on nvim autocmd events.
      window = {
        mappings = {
          ['<bs>'] = 'none',
          ['.'] = 'set_root',
          ['H'] = 'toggle_hidden',
          ['/'] = 'fuzzy_finder',
          ['f'] = 'filter_on_submit',
          ['<c-x>'] = 'clear_filter',
          ['[g'] = 'prev_git_modified',
          [']g'] = 'next_git_modified',
        },
      },
    },
    buffers = {
      follow_current_file = {
        enabled = true, -- This will find and focus the file in the active buffer every
      },
      -- time the current file is changed while the tree is open.
      group_empty_dirs = true, -- when true, empty folders will be grouped together
      show_unloaded = true,
      window = {
        mappings = {
          ['bd'] = 'buffer_delete',
          ['<bs>'] = 'navigate_up',
          ['.'] = 'set_root',
        },
      },
    },
    git_status = {
      window = {
        position = 'float',
        mappings = {
          ['A'] = 'git_add_all',
          ['gu'] = 'git_unstage_file',
          ['ga'] = 'git_add_file',
          ['gr'] = 'git_revert_file',
          ['gc'] = 'git_commit',
          ['gp'] = 'git_push',
          ['gg'] = 'git_commit_and_push',
        },
      },
    },
  })

  require('which-key').add({
    { '<leader>e', '<Cmd>Neotree reveal<cr>', desc = 'Neotree focus explorer' },
    { '<leader>t', '<Cmd>Neotree toggle<cr>', desc = 'Neotree toggle open / close' },
  })
end
