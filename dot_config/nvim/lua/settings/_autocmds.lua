vim.api.nvim_create_autocmd(
  'FileType',
  { pattern = 'qf', command = [[ nnoremap <buffer><silent> <CR> <CR>:cclose<CR> ]] }
)
vim.api.nvim_create_autocmd('FileType', { pattern = 'qf', command = [[ nnoremap <buffer><silent>q <CR>:cclose<CR> ]] })

vim.api.nvim_create_augroup('fileTypeIndent', {})
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  group = 'fileTypeIndent',
  pattern = '*.go, Makefile',
  command = [[ setlocal noexpandtab ]],
})

-- change filetype
vim.api.nvim_create_augroup('fileTypeSet', {})
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  group = 'fileTypeSet',
  pattern = '*.golden, *textlintrc',
  command = [[ set filetype=json ]],
})

-- strip .tmpl extension for chezmoi template files
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  group = 'fileTypeSet',
  pattern = '*.tmpl',
  callback = function()
    local filename = vim.fn.expand('%:t:r') -- e.g. settings.json from settings.json.tmpl
    local ft = vim.filetype.match({ filename = filename, buf = 0 })
    if ft then
      vim.bo.filetype = ft
    end
  end,
})
