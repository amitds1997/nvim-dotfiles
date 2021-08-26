local fn = vim.fn

local check_backspace = function()
	local col = fn.col('.') - 1
	return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s')
end

local t = function(str)
	return vim.api.nvim_replace_termcodes(str, true, true, true)
end

-- Move to prev/next item in completion menuone
-- Jump to prev/next snippet's placeholder
_G.tab_complete = function()
	if fn.pumvisible() == 1 then
		return t("<C-n>")
	elseif fn.call('vsnip#available', {1}) == 1 then
		return t("<Plug>(vsnip-expand-or-jump)")
	elseif check_backspace() then
		return t("<Tab>")
	else
		return fn['compe#complete']()
	end
end

_G.s_tab_complete = function()
	if fn.pumvisible() == 1 then
		return t("<C-p>")
	elseif fn.call('vsnip#jumpable', {-1}) == 1 then
		return t("<Plug>(vsnip-jump-prev)")
	else
		return t("<C-h>")
	end
end
