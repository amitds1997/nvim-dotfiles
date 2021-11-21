local lang = {}
local conf = require('modules.lang.config')

lang['nvim-treesitter/nvim-treesitter'] = {
	event = 'BufRead',
	config = conf.nvim_treesitter,
	run = ':TSUpdate'
}

lang['scalameta/nvim-metals'] = {
	event = 'BufReadPre',
	config = conf.nvim_metals,
	requires = {
		{'nvim-lua/plenary.nvim'},
	}
}

lang['neovim/nvim-lspconfig'] = {
	event = 'BufReadPre',
	config = conf.nvim_lsp
}

lang['hrsh7th/nvim-compe'] = {
	event = 'InsertEnter',
	config = conf.nvim_compe
}

lang['hrsh7th/vim-vsnip'] = {
	event = 'InsertCharPre',
	config = conf.vim_vsnip,
	after = { 'nvim-compe' }
}

return lang
