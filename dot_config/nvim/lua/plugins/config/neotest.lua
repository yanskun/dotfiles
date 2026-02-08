return function()
  require('neotest').setup({
    adapters = {
      require('neotest-vitest') {
        vitestCommand = 'npx vitest run',
        vitestConfigFile = function(file)
          if string.find(file, '/packages/') or string.find(file, '/apps') then
            return string.match(file, '(.-/[^/]+/)src') .. 'vitest.config.ts'
          end

          return vim.fn.getcwd() .. '/vitest.config.ts'
        end,
      },
    },
  })

  -- require('which-key').add({
  --   { 't', group = 'test' },
  --   {
  --     'tN',
  --     function()
  --       require('neotest').run.run()
  --     end,
  --     desc = 'Run the nearest test',
  --   },
  --   {
  --     'tF',
  --     function()
  --       require('neotest').run.run(vim.fn.expand('%'))
  --     end,
  --     desc = 'Run the current file',
  --   },
  --   {
  --     'tD',
  --     function()
  --       require('neotest').run.run({ strategy = 'dap' })
  --     end,
  --     desc = 'Debug the nearest test',
  --   },
  -- })
end
