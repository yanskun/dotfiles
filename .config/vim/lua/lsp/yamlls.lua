if vim.fn.exepath("yaml-language-server") ~= "" then
	require("lspconfig").yamlls.setup({
		settings = {
			yaml = {
				schemas = {
					-- https://www.schemastore.org/json/
					["http://json.schemastore.org/github-workflow"] = ".github/workflows/*.{yml,yaml}",
					["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
					["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/*.{yml,yaml}",
					["http://json.schemastore.org/prettierrc"] = ".prettierrc.{yml,yaml}",
					["http://json.schemastore.org/stylelintrc"] = ".stylelintrc.{yml,yaml}",
					["http://json.schemastore.org/circleciconfig"] = ".circleci/**/*.{yml,yaml}",
				},
			},
		},
	})
else
	vim.notify("npm i -g yaml-language-server", vim.log.levels.WARN, { title = "yamlls" })
end
