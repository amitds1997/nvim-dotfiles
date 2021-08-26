local global 	= {}
local path_sep 	= '/'

function global:load_variables()
	self.home 	= os.getenv("HOME")
	self.path_sep 	= path_sep

	self.vim_path 		= vim.fn.stdpath('config')
	self.modules_dir 	= self.vim_path .. '/lua/modules'
	self.cache_dir 		= self.home .. path_sep .. '.cache' .. path_sep .. '.nvim' .. path_sep
	self.data_dir 		= string.format('%s/site/', vim.fn.stdpath('data'))
end

global:load_variables()

return global
