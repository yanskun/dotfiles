local lspconfig = require 'lspconfig'
local configs = require 'lspconfig/configs'

if vim.fn.exepath('golangci-lint-langserver') ~= '' then
  if not configs.golangcilsp then
    configs.golangcilsp = {
		  default_config = {
			  cmd = {'golangci-lint-langserver'},
			  root_dir = lspconfig.util.root_pattern('.git', 'go.mod'),
			  init_options = {
					command = { "golangci-lint", "run", "--enable-all", "--disable", "lll", "--out-format", "json" };
		  	}
		  };
	}
  end
  lspconfig.golangcilsp.setup {
    filetypes = {'go'}
  }
else
  print('go install github.com/nametake/golangci-lint-langserver@latest')
end
