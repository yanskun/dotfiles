return function()
	require("mason-lspconfig").setup({
		ensure_installed = {
			-- "cssls",
			-- "denols",
			-- "gopls",
			-- "jsonls",
			-- "rust_analyzer",
			-- "sqlls",
			-- "lua_ls",
			-- "svelte",
			-- "tflint",
			-- "volar",
			-- "yamlls",
			-- "zls",
			-- "tsserver",
		},
		automatic_installation = true,
	})
end
