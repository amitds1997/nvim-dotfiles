local config = {}

function config.nvim_treesitter()
	require('nvim-treesitter.configs').setup{
		ensure_installed = "maintained", -- Only install parsers that have maintainers
		ignore_install = { "javascript" }, -- Do not install the following parsers
		highlight = {
			enable = true,  -- false will disable the highlight extension
			additional_vim_regex_highlighting = false
		}
	}
end

function config.nvim_lsp()
	require('modules.lang.lspconfig')
end

function config.nvim_compe()
	require('compe').setup {
		enabled = true;
		autocomplete = true;
		debug = false;
		min_length = 1;
		preselect = 'enable';
		throttle_time = 80;
		source_timeout = 200;
		resolve_timeout = 800;
		incomplete_delay = 400;
		max_abbr_width = 100;
		max_kind_width = 100;
		max_menu_width = 100;
		source = {
			path = true,
			buffer = true,
			vsnip = true,
			nvim_lsp = true,
			nvim_lua = true,
			tags = true,
			treesitter = false -- False because this is slow
		}
	}
end

function config.nvim_metals()
	require('modules.lang.metals_config')
end

function config.vim_vsnip()
	vim.g.vsnip_snippet_dir = os.getenv('HOME') .. '/.config/nvim/snippets'
	vim.g.completion_enable_snippet = 'vim-vsnip'
end

return config
