local ui = {}
local conf = require('modules.ui.config')

ui['kyazdani42/nvim-tree.lua'] = {
	config = conf.nvim_tree,
	requires = 'kyazdani42/nvim-web-devicons'
}

ui['folke/tokyonight.nvim'] = {
	config = conf.tokyonight
}

ui['glepnir/galaxyline.nvim'] = {
	branch = 'main',
	config = conf.galaxyline,
	requires = 'kyazdani42/nvim-web-devicons',
	after = { 'nvim-treesitter' }
}

return ui
