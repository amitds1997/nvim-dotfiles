local fn, api, loop = vim.fn, vim.api, vim.loop

local data_dir 		= require('core.global').data_dir
local modules_dir 	= require('core.global').modules_dir

local packer_compiled 	= data_dir .. 'packer_compiled.lua'
local compile_to_lua	= data_dir .. 'lua/_compiled.lua'

local packer 	= nil
local Packer 	= {}
Packer.__index 	= Packer

-- Get all plugins to be managed by packer
function Packer:load_plugins()
	self.repos = {}

	local get_plugin_files_list = function()
		local list = {}
		local plugin_file_paths = vim.split(fn.globpath(modules_dir, '*/plugins.lua'), '\n')
		for _, f in ipairs(plugin_file_paths) do
			-- Remove prefix till `/lua/` and drop the `.lua` extension at the end
			list[#list + 1] = f:sub(#modules_dir - 6, -5)
		end

		return list
	end

	local plugins_file = get_plugin_files_list()
	for _, m in ipairs(plugins_file) do
		local repos = require(m)
		for repo, conf in pairs(repos) do
			-- tbl_extend merges {repo} with {conf} to give {<repo>, conf} kind of structure which packer uses
			self.repos[#self.repos + 1] = vim.tbl_extend('force', {repo}, conf)
		end
	end
end

-- Initialize packer and add all plugins to packer
function Packer:load_packer()
	if not packer then
		api.nvim_command('packadd packer.nvim')
		packer = require('packer')
	end

	packer.init({
		compile_path = packer_compiled,
		git = { clone_timeout = 120 },
		disable_commands = true
	})

	packer.reset()

	local use = packer.use
	self:load_plugins()

	-- Make packer manage itself
	use { "wbthomason/packer.nvim", opt = true }

	-- Add all packages available in various modules to packer
	for _, repo in ipairs(self.repos) do
		use(repo)
	end
end

-- Make sure packer file is available and then delegate the loading of plugins to `load_packer`
function Packer:init_ensure_plugins()
	local packer_dir = data_dir .. 'pack/packer/opt/packer.nvim'
	local state = loop.fs_stat(packer_dir) -- Check if the file exists

	if not state then
		local cmd = "!git clone https://github.com/wbthomason/packer.nvim " .. packer_dir
		api.nvim_command(cmd)
		loop.fs_mkdir(data_dir .. 'lua', 511, function()
			assert("Creation of compile path directory failed")
		end)
		self:load_packer()
		packer.install()
	end
end

-- `__index` defines how to find an absent member in the table. It's a lua feature. If not found, it returns nil
local plugins = setmetatable({}, {
	__index = function(_, key)
		if not packer then
			Packer:load_packer()
		end
		return packer[key]
	end
})

function plugins.ensure_plugins()
	Packer:init_ensure_plugins()
end

function plugins.convert_compile_file()
	local lines = {}
	local lnum = 1
	lines[#lines + 1] = 'vim.cmd [[packadd packer.nvim]]\n'

	if fn.filereadable(packer_compiled) == 1 then
		for line in io.lines(packer_compiled) do
			lnum = lnum + 1
			if lnum > 9 then
				lines[#lines + 1] = line .. '\n'
				if line == 'END' then
					break
				end
			end
		end
	end

	if fn.isdirectory(data_dir .. 'lua') ~= 1 then
		os.execute('mkdir -p ' .. data_dir .. 'lua')
	end
	if fn.filereadable(compile_to_lua) == 1 then
		os.remove(compile_to_lua)
	end

	local file = io.open(compile_to_lua, "w")
	for _, line in ipairs(lines) do
		file:write(line)
	end
	file:close()

	os.remove(packer_compiled)
end

function plugins.magic_compile()
	plugins.compile()
	plugins.convert_compile_file()
end

-- If you are in the plugins directory, automatically clean and compile
function plugins.auto_compile()
	local file = vim.fn.expand('%:p')

	if file:match(modules_dir) then
		plugins.clean()
		plugins.magic_compile()
	end
end

function plugins.load_compile()
	if vim.fn.filereadable(compile_to_lua) == 1 then
		require('_compiled')
	else
		assert('Missing packer compile file. Run :PackerCompile or :PackerInstall to fix')
	end

	vim.cmd [[command! PackerClean	 lua require('core.pack').clean()]]
	vim.cmd [[command! PackerCompile lua require('core.pack').magic_compile()]]
	vim.cmd [[command! PackerInstall lua require('core.pack').install()]]
	vim.cmd [[command! PackerStatus  lua require('core.pack').status()]]
	vim.cmd [[command! PackerSync 	 lua require('core.pack').sync()]]
	vim.cmd [[command! PackerUpdate  lua require('core.pack').update()]]

	vim.cmd [[autocmd User PackerComplete lua require('core.pack').magic_compile()]]
end

return plugins
