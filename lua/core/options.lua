local arrows = require("icons").arrows
local opt = vim.opt

opt.shell = "pwsh"
opt.shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command"
opt.shellquote = ""
opt.shellxquote = ""
opt.termguicolors = true
opt.relativenumber = true
opt.number = true
opt.scrolloff = 10
opt.laststatus = 3
opt.expandtab = true
opt.shada = ""
opt.autoindent = true
opt.wrap = false
opt.ignorecase = true
opt.smartcase = true
opt.cursorline = true
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"
opt.backspace = "indent,eol,start"
opt.clipboard:append("unnamedplus")
opt.splitright = true
opt.splitbelow = true
opt.swapfile = false
opt.splitbelow = true -- split windows below
opt.splitright = true -- split windows right
opt.colorcolumn = "80"

-- Save undo history.
vim.o.undofile = true

vim.o.foldtext = ""
vim.o.fillchars = "fold: "

vim.o.wrap = true
vim.o.lazyredraw = true
-- Assume fast terminal connection
vim.o.ttyfast = true
-- Set the update time for writing to the swap file and triggering CursorHold events (in milliseconds)
vim.o.updatetime = 300
vim.o.timeoutlen = 500
vim.o.ttimeoutlen = 10
vim.o.termguicolors = true

vim.o.spelllang = "en_us"
vim.o.spell = false

-- Folding.
vim.o.foldcolumn = "1"
vim.o.foldlevelstart = 99
vim.o.foldmethod = "expr"
vim.wo.foldtext = "v:lua.vim.treesitter.foldtext()"
vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"

-- UI characters.
vim.opt.fillchars = {
	eob = " ",
	fold = " ",
	foldclose = arrows.right,
	foldopen = arrows.down,
	foldsep = " ",
	msgsep = "─",
}

-- Status line.
vim.o.laststatus = 3
vim.o.cmdheight = 1


-- Completion.
vim.opt.wildignore:append { '.DS_Store' }
vim.o.completeopt = 'menuone,noselect,noinsert'
vim.o.pumheight = 15

-- Diff mode settings.
-- Setting the context to a very large number disables folding.
vim.opt.diffopt:append 'vertical,context:99'

vim.opt.shortmess:append {
    w = true,
    s = true,
}

-- Disable health checks for these providers.
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0

vim.api.nvim_create_autocmd("FileType", {
	pattern = "*",
	command = "setlocal tabstop=4 shiftwidth=4 softtabstop=4",
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
	command = "setlocal tabstop=2 shiftwidth=2 softtabstop=2",
})

