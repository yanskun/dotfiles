-- pyenv install 2.x.x
-- pyenv virtualenv 2.x.x neovim-2
-- pip install neovim
vim.g['python_host_prog'] = vim.env.PYENV_ROOT .. '/versions/neovim-2/bin/python'

-- pyenv install 3.x.x
-- pyenv virtualenv 3.x.x neovim-3
-- pip install neovim
vim.g['python3_host_prog'] = vim.env.PYENV_ROOT .. '/versions/neovim-3/bin/python'
