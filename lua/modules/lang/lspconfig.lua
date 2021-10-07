local api = vim.api
local global = require('core.global')
local lspconfig = require('lspconfig')
local format = require('modules.lang.lsp_format')

local lsp_dir = string.format('%s/lsp/', vim.fn.stdpath('data'))

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
	properties = {
		'document',
		'detail',
		'additionalTextEdits'
	}
}

-- Reload LSP
function _G.reload_lsp()
	vim.lsp.stop_client(vim.lsp.get_active_clients())
	vim.cmd [[edit]]
end
vim.cmd('command! -nargs=0 LspRestart call v:lua.reload_lsp()')

-- Open log file
function _G.open_lsp_log()
	local path = vim.lsp.get_log_path()
	vim.cmd("edit " .. path)
end
vim.cmd('command! -nargs=0 LspLog call v:lua.open_lsp_log()')

vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
	vim.lsp.diagnostic.on_publish_diagnostics, {
		underline = true,
		virtual_text = true,
		signs = {
			enable = true,
			priority = 20
		},
		update_in_insert = false, -- What is this?
	}
)

local enhance_attach = function(client, bufnr)
	local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
	api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	local opts = {noremap = true, silent = true}
	buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
	buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
	buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
	buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
	buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
	buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
	buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
	buf_set_keymap('n', '<Leader>sh', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
	buf_set_keymap('n', '<Leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
	buf_set_keymap('n', '<Leader>sd', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
	buf_set_keymap('n', '<Leader>td', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
	buf_set_keymap('n', '<Leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
	buf_set_keymap('n', '<Leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
	buf_set_keymap('n', '<Leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
	buf_set_keymap('n', '<Leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
	buf_set_keymap('n', '<Leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)

	if client.resolved_capabilities.document_formatting then
		format.lsp_before_save()
		buf_set_keymap("n", "ff", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
	elseif client.resolved_capabilities.document_range_formatting then
		buf_set_keymap("n", "ff", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
	end
end

-- Setup Go LS
lspconfig.gopls.setup {
	cmd = { "gopls", "--remote=auto" },
	on_attach = enhance_attach,
	capabilities = capabilities,
	init_options = {
		usePlaceholders = true,
		completeUnimported = true
	},
	settings = {
		gopls = {
			analyses = {
				shadow = true,
				unusedparams = true
			},
			staticcheck = true
		}
	}
}

-- Setup Lua LS
lspconfig.sumneko_lua.setup {
	cmd = {
		lsp_dir .. "lua-language-server/bin/" .. global.platform .. "/lua-language-server",
		"-E",
		lsp_dir .. "lua-language-server/main.lua"
	},
	on_attach = enhance_attach,
	settings = {
		Lua = {
			diagnostics = {
				enable = true,
				globals = { "vim", "packer_plugins" }
			},
			runtime = { version = "LuaJIT" },
			workspace = {
				library = vim.list_extend({[vim.fn.expand("$VIMRUNTIME/lua")] = true}, {})
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false
			}
		}
	}
}

lspconfig.rust_analyzer.setup({
	on_attach = enhance_attach,
	settings = {
		["rust-analyzer"] = {
		    assist = {
			importGranularity = "module",
			importPrefix = "by_self",
		    },
		    cargo = {
			loadOutDirsFromCheck = true
		    },
		    procMacro = {
			enable = true
		    },
		}
	}
})

local servers = {
	'dockerls', 'bashls', 'pyright'
}

for _, server in ipairs(servers) do
	lspconfig[server].setup {
		on_attach = enhance_attach,
		flags = {
			debounce_text_changes = 150
		}
	}
end

-- Configure icons for lsp
require('vim.lsp.protocol').CompletionItemKind = {
    ' Text', -- Text
    ' Method', -- Method
    ' Function', -- Function
    ' Constructor', -- Constructor
    ' Field', -- Field
    ' Variable', -- Variable
    ' Class', -- Class
    'ﰮ Interface', -- Interface
    ' Module', -- Module
    ' Property', -- Property
    ' Unit', -- Unit
    ' Value', -- Value
    '了 Enum', -- Enum
    ' Keyword', -- Keyword
    '﬌ Snippet', -- Snippet
    ' Color', -- Color
    ' File', -- File
    ' Reference', -- Reference
    ' Folder', -- Folder
    ' EnumMember', -- EnumMember
    ' Constant', -- Constant
    ' Struct', -- Struct
    ' Event', -- Event
    'ﬦ Operator', -- Operator
    ' TypeParameter', -- TypeParameter
}
