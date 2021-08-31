require('keymap.tab_completion') -- Setup tab based completion

local set_keymap = vim.api.nvim_set_keymap
local opts = {noremap = true, silent = true}

-- Allow qi to work as <Esc>
set_keymap('i', 'qi', '<ESC>', opts)

-- Allow movement through data visually, without skipping wrapped lines
set_keymap('n', 'j', 'gj', opts)
set_keymap('n', 'k', 'gk', opts)

-- Set quick window switch
set_keymap('', '<C-h>', '<C-W><C-h>', opts)
set_keymap('', '<C-j>', '<C-W><C-j>', opts)
set_keymap('', '<C-k>', '<C-W><C-k>', opts)
set_keymap('', '<C-l>', '<C-W><C-l>', opts)

-- Quick text copy to clipboard
set_keymap('', '<Leader>c', '"+y', opts)

-- Quickly switch between open buffers
set_keymap('n', '<TAB>', ':bnext<CR>', opts)
set_keymap('n', '<S-TAB>', ':bprevious<CR>', opts)

-- Quickly unhiglight search results
set_keymap('', '<Leader>h', ':nohlsearch<CR>', opts)

-- Use tab to cycle through the completion list
set_keymap('i', '<TAB>', 'v:lua.tab_complete()', {silent = true, expr = true})
set_keymap('i', '<S-TAB>', 'v:lua.s_tab_complete()', {silent = true, expr = true})

-- Set Enter to code completion
set_keymap('i', '<CR>', "compe#confirm('<CR>')", {noremap = true, silent = true, expr = true})

-- Set packer shortcuts
set_keymap('n', '<Leader>ps', ':PackerSync<CR>', {noremap = true, silent = true, nowait = true})
set_keymap('n', '<Leader>pu', ':PackerUpdate<CR>', {noremap = true, silent = true, nowait = true})
set_keymap('n', '<Leader>pi', ':PackerInstall<CR>', {noremap = true, silent = true, nowait = true})
set_keymap('n', '<Leader>pc', ':PackerCompile<CR>', {noremap = true, silent = true, nowait = true})

-- Set telescope shortcuts
set_keymap('n', '<Leader>st', ':Telescope<CR>', {noremap = true})
set_keymap('n', '<Leader>fg', ':Telescope git_files<CR>', {noremap = true})
set_keymap('n', '<Leader>ff', ':Telescope find_files<CR>', {noremap = true})
set_keymap('n', '<Leader>fw', ':Telescope live_grep<CR>', {noremap = true})
