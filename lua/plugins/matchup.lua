return {
  {
    "andymass/vim-matchup",
    branch = "master",
    event = "BufReadPost",
    init = function()
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      matchup = {
        enable = true, -- mandatory, false will disable the whole extension
      },
    },
  },
}

-- vim: ts=2 sts=2 sw=2 et
