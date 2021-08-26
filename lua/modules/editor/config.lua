local config = {}

function config.telescope()
	if not packer_plugins['plenary.nvim'].loaded then
		vim.cmd [[packadd plenary.nvim]]
		vim.cmd [[packadd popup.nvim]]
		vim.cmd [[packadd telescope-fzy-native.nvim]]
	end

	require('telescope').setup {
		defaults = {
			file_ignore_patterns = { "target/.*", ".git/.*", "node_modules/*" },
			layout_config = {
				prompt_position = 'top',
				horizontal = {
					mirror = false
				},
				vertical = {
					mirror = false
				}
			},
			prompt_prefix = '  ',
			selection_caret = ' ',
			color_devicons = true,
			file_previewer = require('telescope.previewers').vim_buffer_cat.new,
			grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
			qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,
		},
		pickers = {
			buffers = {
				theme = "ivy"
			},
			find_files = {
				theme = "ivy"
			},
		},
		extensions = {
			fzy_native = {
				override_generic_sorter = false,
				override_file_sorter = true,
			}
		}
	}
	require('telescope').load_extension('fzy_native')
end

return config
