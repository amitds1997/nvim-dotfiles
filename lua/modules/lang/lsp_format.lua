local lsp = vim.lsp
local lsp_format = {}

local function nvim_create_augroup(group_name, definitions)
  vim.api.nvim_command('augroup ' .. group_name)
  vim.api.nvim_command('autocmd!')

  for _, def in ipairs(definitions) do
    local command = table.concat(vim.tbl_flatten{'autocmd', def}, ' ')
    vim.api.nvim_command(command)
  end

  vim.api.nvim_command('augroup END')
end

function lsp_format.lsp_before_save()
  local defs = {}
  local ext = vim.fn.expand('%:e')

  table.insert(defs,{"BufWritePre", '*.'..ext , "lua vim.lsp.buf.formatting_sync(nil,1000)"})
  if ext == 'go' then
    table.insert(defs,{"BufWritePre","*.go", "lua require('modules.lang.lsp_format').go_organize_imports_sync(1000)"})
  end

  nvim_create_augroup('lsp_before_save',defs)
end

-- Synchronously organise (Go) imports. Taken from
-- https://github.com/neovim/nvim-lsp/issues/115#issuecomment-654427197.
function lsp_format.go_organize_imports_sync(timeout_ms)
  local params = vim.lsp.util.make_range_params()
  params.context = {only = {"source.organizeImports"}}

  local result = lsp.buf_request_sync(0, "textDocument/codeAction", params, timeout_ms)
  for _, res in pairs(result or {}) do
  	for _, r in pairs(res.result or {}) do
		if r.edit then
			vim.lsp.util.apply_workspace_edit(r.edit)
		else
			vim.lsp.buf.execute_command(r.command)
		end
	end
  end
end

return lsp_format
