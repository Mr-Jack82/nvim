-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

---@module 'lazy'
---@type LazySpec
return {
  "nvim-neo-tree/neo-tree.nvim",
  version = "*",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
  },
  lazy = false,
  keys = {
    {
      "<leader>e",
      ":Neotree reveal<CR>",
      desc = "NeoTree reveal",
      silent = true,
    },
    {
      "<leader>fE",
      function()
        require("neo-tree.command").execute { toggle = true, dir = vim.uv.cwd() }
      end,
      desc = "Explorer NeoTree (cwd)",
    },
    {
      "<leader>ge",
      function()
        require("neo-tree.command").execute {
          source = "git_status",
          toggle = true,
        }
      end,
      desc = "Git Explorer",
    },
    {
      "<leader>be",
      function()
        require("neo-tree.command").execute { source = "buffers", toggle = true }
      end,
      desc = "Buffer Explorer",
    },
  },
  ---@module 'neo-tree'
  ---@type neotree.Config
  opts = {
    sources = { "filesystem", "buffers", "git_status" },
    open_files_do_not_replace_types = {
      "terminal",
      "Trouble",
      "trouble",
      "qf",
      "Outline",
    },
    filesystem = {
      bind_to_cwd = false,
      follow_current_file = { enable = true },
      use_libuv_file_watcher = true,
      window = {
        mappings = {
          ["<Esc>"] = "close_window",
          ["l"] = "open",
          ["h"] = "close_node",
          ["Y"] = {
            function(state)
              local node = state.tree:get_node()
              local path = node:get_id()
              vim.fn.setreg("+", path, "c")
            end,
            desc = "Copy Path to Clipboard",
          },
          ["P"] = { "toggle_preview", config = { use_float = false } },
        },
      },
      default_component_configs = {
        ident = {
          with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
          expander_collapsed = "",
          expander_expanded = "",
          expander_highlight = "NeoTreeExpander",
        },
        git_status = {
          symbols = {
            unstaged = "󰄱",
            staged = "󰱒",
          },
        },
      },
    },
  },
}
