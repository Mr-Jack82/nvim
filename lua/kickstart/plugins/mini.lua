---@module 'lazy'
---@type LazySpec
return {
  { -- Collection of various small independent plugins/modules
    "nvim-mini/mini.nvim",
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
      --  - ci'  - [C]hange [I]nside [']quote
      require("mini.ai").setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require("mini.surround").setup {
        -- vim-surround style mappings
        -- left brackets and space around the text object
        -- 'ysiw('    foo -> ( foo )
        -- 'ysiw)'    foo -> (foo)
        custom_surroundings = {
          -- since mini.nvim#84 we no longer need to customize
          -- the left brackets, they are spaced by default
          -- https://github.com/echasnovski/mini.nvim/issues/84
          s = {
            --  lua bracketed string mapping
            --  'ysiwS'  foo -> [[foo]]
            input = { "%[%[().-()%]%]" },
            output = { left = "[[", right = "]]" },
          },
          b = {
            --  replace b (brackets) with lua block comment
            --  'viwSb' foo           -> --[[ foo ]]
            --  'dsb'   --[[ foo ]]   -> foo
            --  'csb"'  --[[ foo ]]   -> "foo"
            input = { "%-%-%[%[%s?().-()%s?%]%]" },
            output = { left = "--[[ ", right = " ]]" },
          },
        },
        mappings = {
          add = "ys",
          delete = "ds",
          find = "",
          find_left = "",
          highlight = "gs", -- hijack 'gs' (sleep) for highlight
          replace = "cs",
          update_n_lines = "", -- bind for updating 'config.n_lines'
        },
        -- Number of lines within which surrounding is searched
        n_lines = 68,
        -- Duration (in ms) of highlight when calling `MiniSurround.highlight()`
        highlight_duration = 2000,
        -- How to search for surrounding (first inside current line, then inside
        -- neighborhood). One of 'cover', 'cover_or_next', 'cover_or_prev',
        -- 'cover_or_nearest'. For more details, see `:h MiniSurround.config`.
        search_method = "cover_or_next",
      }

      -- Simple and easy statusline.
      --  You could remove this setup call if you don't like it,
      --  and try some other statusline plugin
      -- local statusline = require 'mini.statusline'
      -- set use_icons to true if you have a Nerd Font
      -- statusline.setup { use_icons = vim.g.have_nerd_font }

      -- You can configure sections in the statusline by overriding their
      -- default behavior. For example, here we set the section for
      -- cursor location to LINE:COLUMN
      ---@diagnostic disable-next-line: duplicate-set-field
      -- statusline.section_location = function() return '%2l:%-2v' end

      -- ... and there is more!
      --  Check out: https://github.com/nvim-mini/mini.nvim
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
