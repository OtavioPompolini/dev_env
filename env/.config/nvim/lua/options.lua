-- vim.o.hlsearch = false
--
-- -- Make line numbers default
-- vim.wo.number = true
--
-- -- Enable mouse mode
-- vim.o.mouse = 'a'
--
-- -- Sync clipboard between OS and Neovim.
-- --  Remove this option if you want your OS clipboard to remain independent.
-- --  See `:help 'clipboard'`
-- vim.o.clipboard = 'unnamedplus'
--
-- Enable break indent
-- vim.o.breakindent = true
--
-- -- Save undo history
-- vim.o.undofile = true
--
-- -- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true
--
-- -- Keep signcolumn on by default
-- vim.wo.signcolumn = 'yes'
--
-- -- Decrease update time
-- vim.o.timeoutlen = 300
--
-- -- Set completeopt to have a better completion experience
-- vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- Disable showing the mode below the statusline
vim.opt.showmode = false

vim.opt.guicursor = ""

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"
