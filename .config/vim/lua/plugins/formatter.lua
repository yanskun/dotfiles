return function()
	local function f(cmd, ...)
		local args = { ... }
		return {
			function()
				return {
					exe = cmd,
					args = args,
					stdin = false,
				}
			end,
		}
	end

	require("formatter").setup({
		filetype = {
			lua = f("stylua", "./*/*.lua"),
		},
	})

	vim.api.nvim_exec(
		[[
	   augroup FormatAutogroup
	     autocmd!
	     autocmd BufWritePost * FormatWrite
	   augroup END
	  ]],
		true
	)
end
