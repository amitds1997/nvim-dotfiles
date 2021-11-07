local api, cmd = vim.api, vim.cmd

metals_config = require("metals").bare_config()
metals_config.init_options.statusBarProvider = "on"
metals_config.settings = {
	showImplicitArguments = true,
	showImplicitConversionsAndClasses = true,
	showInferredType = true,
	superMethodLensesEnabled = true
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
metals_config.capabilities = capabilities

local opts = {noremap = true, silent = true}
api.nvim_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
api.nvim_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
api.nvim_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
api.nvim_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
api.nvim_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
api.nvim_set_keymap('n', 'gds', '<cmd>lua vim.lsp.buf.document_symbol()<CR>', opts)
api.nvim_set_keymap('n', 'gws', '<cmd>lua vim.lsp.buf.workspace_symbol()<CR>', opts)
api.nvim_set_keymap('n', 'ff', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
api.nvim_set_keymap('n', '<Leader>sh', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
api.nvim_set_keymap('n', '<Leader>td', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)

api.nvim_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev({wrap = false})<CR>', opts)
api.nvim_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next({wrap = false})<CR>', opts)
api.nvim_set_keymap('n', '<Leader>ds', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
api.nvim_set_keymap('n', '<Leader>dl', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
api.nvim_set_keymap('n', '<Leader>da', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)

api.nvim_set_keymap('n', '<Leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
api.nvim_set_keymap('n', '<Leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
api.nvim_set_keymap('n', '<Leader>wh', '<cmd>lua require("metals").worksheet_hover()<CR>', opts)

api.nvim_set_keymap('n', '<Leader>tt', '<cmd>lua require("metals.tvp").toggle_tree_view()<CR>', opts)
api.nvim_set_keymap('n', '<Leader>rt', '<cmd>lua require("metals.tvp").reveal_in_tree()<CR>', opts)

api.nvim_set_keymap('n', '<Leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
api.nvim_set_keymap('n', '<Leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
api.nvim_set_keymap('n', '<Leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)

cmd [[augroup lsp]]
cmd [[au!]]
cmd [[autocmd FileType scala setlocal omnifunc=v:lua.vim.lsp.omnifunc]]
cmd [[au FileType scala,sbt lua require("metals").initialize_or_attach(metals_config)]]
cmd [[augroup end]]
