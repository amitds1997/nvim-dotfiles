local editor = {}
local conf = require('modules.editor.config')

editor['nvim-telescope/telescope.nvim'] = {
	cmd = 'Telescope',
	config = conf.telescope,
	requires = {
		{'nvim-lua/popup.nvim', opt = true},
		{'nvim-lua/plenary.nvim', opt = true},
		{'nvim-telescope/telescope-fzy-native.nvim', opt = true}
	}
}

return editor
