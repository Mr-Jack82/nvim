return {
  "christoomey/vim-tmux-navigator",
  event = function()
    if vim.fn.exists("$TMUX") == 1 then
      return "VeryLazy"
    end
  end,
}

-- vim: ts=2 sts=2 sw=2 et
