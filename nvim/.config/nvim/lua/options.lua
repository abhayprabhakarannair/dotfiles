-- Netrw config
vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

local o = vim.opt

-- Number config
o.nu = true
o.relativenumber = true

-- Tab / indent config
o.tabstop = 4
o.softtabstop = 4
o.shiftwidth = 4
o.expandtab = true
o.smartindent = true

-- Turn off word wrap
o.wrap = false

-- Swapfile and undotree setup
o.swapfile = false
o.backup = false
o.undodir = os.getenv("HOME") .. "/.nvim/undodir"
o.undofile = true

-- Search config
o.hlsearch = false
o.incsearch = true

-- Fix colors
o.termguicolors = true

-- Misc
o.scrolloff = 8
o.signcolumn = "yes"
o.isfname:append("@-@")
o.updatetime = 50
