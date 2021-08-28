local function set_opts()
	local local_opts = {
		number = true, -- Show line number
		linebreak = true, -- Avoid breaking a word apart during wrap
		wrap = true, -- Wrap if too long text
		cursorline = true, -- Highlight current line
		errorbells = false, -- Disable bells and whistles on error
		wildmenu = true, -- Display command line's tab complete options
		autoread = true, -- If file is unread, auto re-read it from disk
		showmatch = true, -- Briefly jump to matching bracket, if exists
		matchtime = 2, -- Tenth of a second to wait before jumping back to current bracket
		lazyredraw = true, -- Do not redraw on macros and other non-necessary options
		showcmd = true, -- Show command in bottom bar

		hidden = true, -- Enable background buffers
		termguicolors = true, -- True color support
		smartindent = true, -- Insert indents automatically

		-- Disabled because the statusline contains the info already
		ruler = false, -- No ruler, since it's present in the status bar
		showmode = false, -- Show current neovim mode

		-- Search settings
		ignorecase = true, -- Ignore case in search patterns
		hlsearch = true, -- Highlight matching searches
		incsearch = true, -- Show where the pattern matches
		smartcase = true, -- Ignore ignorecase when search patterns contains an uppercase

		-- Maintain viable amount of context around cursor position
		scrolloff = 4,
		sidescrolloff = 8,

		-- Split windows to bottom and to right
		splitright = true,
		splitbelow = true,

		-- No backup files
		backup = false,
		writebackup = false,

		-- Better diagnostics
		updatetime = 300,
		signcolumn = "yes"
	}

	for name, value in pairs(local_opts) do
		vim.o[name] = value
	end
end

vim.opt_global.completeopt = {"menuone", "noselect"}
vim.opt_global.shortmess:remove("F"):append("c")
set_opts()
