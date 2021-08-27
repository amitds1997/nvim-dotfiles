local global 	= {}
local path_sep 	= '/'

local function get_platform()
	local os_name = vim.loop.os_uname().sysname
	if os_name == 'Darwin' then
		return 'MacOS'
	else
		return os_name
	end
end

function global:load_variables()
	self.home 	= os.getenv("HOME")
	self.path_sep 	= path_sep
	self.platform   = get_platform()

	self.vim_path 		= vim.fn.stdpath('config')
	self.modules_dir 	= self.vim_path .. '/lua/modules'
	self.cache_dir 		= self.home .. path_sep .. '.cache' .. path_sep .. '.nvim' .. path_sep
	self.data_dir 		= string.format('%s/site/', vim.fn.stdpath('data'))
end

global:load_variables()

return global
