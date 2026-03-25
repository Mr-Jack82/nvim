-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Make line numbers default
vim.o.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
vim.o.relativenumber = true

vim.opt.autowrite = true -- Enable auto write
-- only set clipboard if not in ssh, to make sure the OSC 52
-- integration works automatically. Requires Neovim >= 0.10.0
-- Don't show the mode, since it's already in the status line

-- Enable mouse mode, can be useful for resizing splits for example!
vim.o.mouse = 'a'
vim.o.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.o.clipboard = vim.env.SSH_TTY and '' or 'unnamedplus'
end)

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true
vim.o.undolevels = 10000

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.o.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 200

-- Decrease mapped sequence wait time
vim.o.timeoutlen = vim.g.vscode and 1000 or 300

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.splitkeep = 'screen'

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
--
--  Notice listchars is set using `vim.opt` instead of `vim.o`.
--  It is very similar to `vim.o` but offers an interface for conveniently interacting with tables.
--   See `:help lua-options`
--   and `:help lua-options-guide`
vim.o.list = true

vim.opt.listchars = {
  eol = "↴",
  tab = "» ",
  trail = "•",
  lead = "-",
  extends = "…",
  precedes = "…",
  conceal = "+",
  nbsp = "␣",
}

vim.opt.completeopt = 'menu,menuone,noselect'
vim.opt.conceallevel = 2
vim.opt.expandtab = true

vim.opt.fillchars = {
  foldopen = "",
  foldclose = "",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}

vim.opt.foldlevel = 99

-- tcqj
vim.opt.formatoptions = 'jcroqlnt'

vim.opt.grepformat = '%f:%l:%c:%m'
vim.opt.grepprg = 'rg --vimgrep'
vim.opt.jumpoptions = 'view'

-- global statusline
vim.opt.laststatus = 3

-- Wrap lines at convenient points
vim.opt.linebreak = true

-- Show some ionvisible characters (tabs...
vim.opt.list = true

-- Popup blend
vim.opt.pumblend = 10

-- Maximum number of entries in a popup
vim.opt.pumheight = 10

-- Disable the default ruler
vim.opt.ruler = false

vim.opt.sessionoptions = { 'buffers', 'curdir', 'tabpages', 'winsize', 'help', 'globals', 'skiprtp', 'folds' }

-- Round indent
vim.opt.shiftround = true

-- Size of an indent
vim.opt.shiftwidth = 2

vim.opt.shortmess:append({ W = true, I = true, c = true, C = true })

-- Don't show since we have a statusline
vim.opt.showmode = false

-- Columns of context
vim.opt.sidescrolloff = 8

-- Insert indents automatically
vim.opt.smartindent = true

vim.opt.spelllang = { 'en_us', 'ru' }

-- Number of spaces tabs count for
vim.opt.tabstop = 2

-- True color support
vim.opt.termguicolors = true

-- Allow cursor to move where there is no text in visual block mode
vim.opt.virtualedit = 'block'

-- Command-line completion mode
vim.opt.wildmode = 'longest:full,full'

-- Minimum window width
vim.opt.winminwidth = 5

-- Disable line wrap
vim.opt.wrap = false

-- Preview substitutions live, as you type!
vim.o.inccommand = 'split'

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0

vim.o.textwidth = 80
vim.o.colorcolumn = '81'
vim.o.softtabstop = 2
vim.o.ttimeoutlen = 150
vim.opt.path:append('.**')
vim.o.swapfile = false
vim.o.wildignorecase = true
vim.o.wildoptions = 'pum,fuzzy'

-- Show which line your cursor is on
vim.o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 8

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.o.confirm = true

-- vim: ts=2 sts=2 sw=2 et
