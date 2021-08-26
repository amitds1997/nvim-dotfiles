-- Disable default distribution loaded plugins
local disable_distribution_plugins = function()
	vim.g.loaded_gzip		= 1
	vim.g.loaded_zip		= 1
	vim.g.loaded_zipPlugin		= 1
	vim.g.loaded_netrw 		= 1
	vim.g.loaded_netrwPlugin 	= 1
	vim.g.loaded_netrwSettings	= 1
	vim.g.loaded_netrwFileHandlers	= 1
end

local leader_map = function()
	vim.g.mapleader = " "
	vim.api.nvim_set_keymap('n', ' ', '', { noremap = true }) -- Do nothing when <space> is pressed in normal mode
	vim.api.nvim_set_keymap('x', ' ', '', { noremap = true }) -- Do nothing when <space> is pressed in visual mode
end

-- Main function
local load_core = function()
	local packer = require('core.pack')

	disable_distribution_plugins()
	leader_map()

	packer.ensure_plugins()
	require('core.options') -- Load common options
	require('keymap') -- Load keymaps
	packer.load_compile()
end

load_core()
