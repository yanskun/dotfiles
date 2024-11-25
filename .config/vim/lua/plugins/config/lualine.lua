return function()
  local function filepath()
    local fullpath = vim.fn.expand('%')
    local path = vim.fn.fnamemodify(fullpath, ':~:.')
    if vim.fn.winwidth(0) < 84 then
      path = vim.fn.pathshorten(path)
    end
    return path
  end

  local function client_name()
    local msg = 'No Active Lsp'
    local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
    local clients = vim.lsp.get_active_clients()
    if next(clients) == nil then
      return msg
    end
    local client_names = {}
    for _, client in ipairs(clients) do
      local filetypes = client.config.filetypes
      if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
        client_names[client.name] = true
      end
    end
    if next(client_names) then
      local names = ''
      for k, _ in pairs(client_names) do
        if names == '' then
          names = k
        else
          names = names .. ',' .. k
        end
      end
      return names
    end
    return msg
  end

  require('lualine').setup({
    sections = {
      lualine_a = { 'mode' },
      lualine_b = {
        {
          'branch',
          color = { fg = '#c678dd', gui = 'bold' },
        },
        filepath,
      },
      lualine_c = {
        'diagnostics',
        'diff',
      },
      lualine_x = {
        {
          client_name,
          icon = '',
          color = { fg = '#a9a1e1', gui = 'bold' },
        },
        'filetype',
      },
      lualine_y = {
        'progress',
      },
      lualine_z = {
        'location',
      },
    },
    options = {
      theme = 'onedark',
      disabled_filetypes = { 'NvimTree', 'neo-tree' },
      globalstatus = true,
    },
  })
end
