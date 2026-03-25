-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

local function map(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.buffer = bufnr
  vim.keymap.set(mode, lhs, rhs, opts)
end
-- Some mappings are taken from here:
-- https://www.lazyvim.org/configuration/general

-- Powerful <esc>. Taken from here: https://tinyurl.com/4buh75hz
--  See `:help hlsearch`
map(
  { "i", "s", "n" },
  "<esc>",
  function()
    if require("luasnip").expand_or_jumpable() then
      require("luasnip").unlink_current()
    end
    vim.cmd "noh"
    return "<esc>"
  end,
  { desc = "Escape, clear hlsearch, and stop snippets session", expr = true }
)

-- Diagnostic keymaps
map(
  "n",
  "<leader>q",
  vim.diagnostic.setloclist,
  { desc = "Open diagnostic [Q]uickfix list" }
)

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Save files without write permissions via sudo
vim.cmd [[cabbrev w!! execute 'silent write !sudo tee % >/dev/null' <bar> edit!]]

-- Moving left/right in *INSERT* and *COMMAND* mode
-- Using `silent = false` makes movements to be immediately shown.
map({ "i", "c" }, "<C-h>", "<Left>", { silent = false, desc = "Move Left" })
map({ "i", "c" }, "<C-l>", "<Right>", { silent = false, desc = "Move Right" })

-- Make {motion} text uppercase in INSERT mode.
map("!", "<C-f>", "<Esc>gUiw`]a", { noremap = false })

-- Allow 'gf' to open non-existent files
map("", "gf", "<cmd>edit <cfile><CR>", { noremap = true, silent = true })

-- Make sure to go to proper indentantion level when pressing i
-- source: https://www.reddit.com/r/neovim/comments/12rqyl8/5_smart_minisnippets_for_making_text_editing_more/
map("n", "i", function()
  if #vim.fn.getline "." == 0 then
    return [["_cc]]
  else
    return "i"
  end
end, { expr = true })

-- Reselect latest changed, put, or yanked text
map(
  "n",
  "gV",
  '"`[" . strpart(getregtype(), 0, 1) . "`]"',
  { expr = true, desc = "Visually select changed text" }
)

-- When joining lines keep cursor position
map("n", "J", "mzJ`z", { desc = "Join lines" })

map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

-- U for redo, the opposite of for undo
map("n", "U", "<C-r>", { desc = "Redo" })

-- Set working directory to the current buffer's directory
map(
  "n",
  "cd",
  "<cmd>lcd %:p:h<bar>lua print('current directory is ' .. vim.fn.getcwd())<CR>",
  { silent = false }
)
map("n", "cu", "..<bar>pwd<CR>", { silent = false })

-- better up/down
map(
  { "n", "x" },
  "j",
  "v:count == 0 ? 'gj' : 'j'",
  { desc = "Down", expr = true, silent = true }
)
map(
  { "n", "x" },
  "<Down>",
  "v:count == 0 ? 'gj' : 'j'",
  { desc = "Down", expr = true, silent = true }
)
map(
  { "n", "x" },
  "k",
  "v:count == 0 ? 'gk' : 'k'",
  { desc = "Up", expr = true, silent = true }
)
map(
  { "n", "x" },
  "<Up>",
  "v:count == 0 ? 'gk' : 'k'",
  { desc = "Up", expr = true, silent = true }
)

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
-- Move to window using the <ctrl> hjkl keys
map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })

-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
map(
  "n",
  "<C-Left>",
  "<cmd>vertical resize -2<cr>",
  { desc = "Decrease Window Width" }
)
map(
  "n",
  "<C-Right>",
  "<cmd>vertical resize +2<cr>",
  { desc = "Increase Window Width" }
)

-- Move Lines
map(
  "n",
  "<A-j>",
  "<cmd>execute 'move .+' . v:count1<cr>==",
  { desc = "Move Down" }
)
map(
  "n",
  "<A-k>",
  "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==",
  { desc = "Move Up" }
)
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
map(
  "v",
  "<A-j>",
  ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv",
  { desc = "Move Down" }
)
map(
  "v",
  "<A-k>",
  ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv",
  { desc = "Move Up" }
)

-- Clear search, diff update and redraw
-- taken from runtime/lua/_editor.lua
map(
  "n",
  "<leader>ur",
  "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
  { desc = "Redraw / Clear hlsearch / Diff Update" }
)

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map(
  "n",
  "n",
  "'Nn'[v:searchforward].'zv'",
  { expr = true, desc = "Next Search Result" }
)
map(
  "x",
  "n",
  "'Nn'[v:searchforward]",
  { expr = true, desc = "Next Search Result" }
)
map(
  "o",
  "n",
  "'Nn'[v:searchforward]",
  { expr = true, desc = "Next Search Result" }
)
map(
  "n",
  "N",
  "'nN'[v:searchforward].'zv'",
  { expr = true, desc = "Prev Search Result" }
)
map(
  "x",
  "N",
  "'nN'[v:searchforward]",
  { expr = true, desc = "Prev Search Result" }
)
map(
  "o",
  "N",
  "'nN'[v:searchforward]",
  { expr = true, desc = "Prev Search Result" }
)

-- Add undo break-points
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", ";", ";<c-g>u")

--keywordprg
map("n", "<leader>K", "<cmd>norm! K<cr>", { desc = "Keywordprg" })

-- lazy
map("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })

-- new file
map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })

-- location list
map("n", "<leader>xl", function()
  local success, err = pcall(
    vim.fn.getloclist(0, { winid = 0 }).winid ~= 0 and vim.cmd.lclose
      or vim.cmd.lopen
  )
  if not success and err then
    vim.notify(err, vim.log.levels.ERROR)
  end
end, { desc = "Location List" })

-- quickfix list
map("n", "<leader>xq", function()
  local success, err = pcall(
    vim.fn.getqflist({ winid = 0 }).winid ~= 0 and vim.cmd.cclose
      or vim.cmd.copen
  )
  if not success and err then
    vim.notify(err, vim.log.levels.ERROR)
  end
end, { desc = "Quickfix List" })

-- diagnostic
local diagnostic_goto = function(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go { severity = severity }
  end
end
map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
map("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
map("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
map("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
map("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
map("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
map("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })

-- vim: ts=2 sts=2 sw=2 et
