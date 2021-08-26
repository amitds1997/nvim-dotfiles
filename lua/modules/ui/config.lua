local config = {}

function config.nvim_tree()
	vim.g.nvim_tree_ignore = { ".git", "node_modules", ".cache" }
	vim.g.nvim_tree_highlight_opened_files = 1
	vim.api.nvim_set_keymap('n', '<Leader>e', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
end

function config.tokyonight()
	vim.cmd [[colorscheme tokyonight]]
	vim.g.tokyonight_style = "storm"
	vim.g.tokyonight_italic_functions = true
	vim.g.tokyonight_transparent_sidebar = true
end

function config.galaxyline()
	require('modules.ui.galaxyline')
end

return config
