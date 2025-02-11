return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    keys = {
      {
        "<C-n>",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = vim.uv.cwd() })
        end,
        desc = "Explorer NeoTree (cwd)",
      },
      {
        "<leader>fe",
        function()
          require("neo-tree.command").execute({ toggle = false, dir = vim.uv.cwd() })
        end,
        desc = "Explorer NeoTree (cwd)",
      },
      {
        "<leader>fE",
        function()
          require("neo-tree.command").execute({ toggle = false, dir = LazyVim.root() })
        end,
        desc = "Explorer NeoTree (Root Dir)",
      },
      { "<leader>e", "<leader>fe", desc = "Explorer NeoTree (cwd)", remap = true },
      { "<leader>E", "<leader>fE", desc = "Explorer NeoTree (Root Dir)", remap = true },
    },
    opts = {
      window = {
        mappings = {
          ["w"] = "none",
          ["h"] = "none",
          ["l"] = "none",
          ["H"] = "none",
          ["I"] = "toggle_hidden",
          ["p"] = function(state)
            local node = state.tree:get_node()
            require("neo-tree.ui.renderer").focus_node(state, node:get_parent_id())
          end,
        },
      },
    },
  },

  {
    "ibhagwan/fzf-lua",
    keys = {
      { "<leader>/", false },
      { "<leader>ff", false },
      { "\\", LazyVim.pick("live_grep"), desc = "Grep (Root Dir)" },
      { "<C-p>", LazyVim.pick("files"), desc = "Find Files (Root Dir)" },
      {
        "<leader>bb",
        "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>",
        desc = "Switch Buffer",
      },
      { "<leader>,", false }, -- <leader>, will be used to format, @see config/keymaps.lua
    },
    opts = {
      oldfiles = {
        cwd_only = true,
      },
    },
  },

  {
    "folke/which-key.nvim",
    enabled = false,
  },
}
