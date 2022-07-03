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
			lua = f("stylua", vim.api.nvim_buf_get_name(0)),
			go = {
				f("gofmt", "-w", vim.api.nvim_buf_get_name(0)),
			},
		},
	})

	vim.api.nvim_exec(
		[[
	   augroup FormatAutogroup
       autocmd!
	     autocmd BufWrite * FormatWrite
	   augroup END
	  ]],
		true
	)
end
