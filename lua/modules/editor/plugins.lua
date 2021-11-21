local editor = {}
local conf = require('modules.editor.config')

editor['github/copilot.vim'] = {}

editor['nvim-telescope/telescope.nvim'] = {
	cmd = 'Telescope',
	config = conf.telescope,
	requires = {
		{'nvim-lua/plenary.nvim'},
		{'nvim-lua/popup.nvim', opt = true}
	}
}

return editor
