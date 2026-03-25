return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  config = function()
    require("lualine").setup({
        options = {
          component_separators = { left = "", right = "│" },
          section_separators = { left = "", right = "" },
          globalstatus = true,
        },
        extensions = {
          "neo-tree",
          "quickfix",
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = {
            {
              "branch",
              iconst_enabled = true,
              icon = "",
            },
            { "diff", "" },
          },
          lualine_c = { { "filename", path = 1 } },
          lualine_x = { "diagnostics", "encoding", "fileformat", "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
      })
  end,
}

-- vim: ts=2 sts=2 sw=2 et
