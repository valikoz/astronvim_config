-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- You can also add or configure plugins by creating files in this `plugins/` folder
-- Here are some examples:

---@type LazySpec
return {

  -- == Examples of Adding Plugins ==

  -- "andweeb/presence.nvim",
  -- {
  --   "ray-x/lsp_signature.nvim",
  --   event = "BufRead",
  --   config = function() require("lsp_signature").setup() end,
  -- },

  -- == Examples of Overriding Plugins ==

  { "goolord/alpha-nvim", enabled = false },
  { "max397574/better-escape.nvim", enabled = false },
  { "lukas-reineke/indent-blankline.nvim", enabled = false },

  {
    "rcarriga/nvim-notify",
    opts = {
      timeout = 0,
      background_colour = "#000000",
    }
  },

  {
    "folke/which-key.nvim",
    keys = { "<leader>", },
    event = function() return { "User AstroFile" } end,
    opts = {
      plugins = {
          marks = false, -- shows a list of your marks on ' and `
          registers = false, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
      },
      layout = {
        height = { min = 4, max = 15 },
      },
      window = {
        winblend = 20, -- value between 0-100 0 for fully opaque and 100 for fully transparent
      },
    }
  },

  {
    "mfussenegger/nvim-dap",
    dependencies = {
      { "theHamsta/nvim-dap-virtual-text", config = true },
    }
  },

  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signcolumn = false,
      numhl = true,
      current_line_blame_opts = { ignore_whitespace = true },
    },
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        filtered_items = {
          always_show = { ".github", ".gitignore" },
        },
          follow_current_file = {
            -- enabled = false,
            leave_dirs_open = true, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
          },
      },
    },
  },
  -- You can also easily customize additional setup of plugins that is outside of the plugin's setup call

  {
    "windwp/nvim-autopairs",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.nvim-autopairs"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom autopairs configuration such as custom rules
      local npairs = require "nvim-autopairs"
      local Rule = require "nvim-autopairs.rule"
      local cond = require "nvim-autopairs.conds"
      npairs.add_rules(
        {
          Rule("$", "$", { "tex", "latex" })
            -- don't add a pair if the next character is %
            :with_pair(cond.not_after_regex "%%")
            -- don't add a pair if  the previous character is xxx
            :with_pair(
              cond.not_before_regex("xxx", 3)
            )
            -- don't move right when repeat character
            :with_move(cond.none())
            -- don't delete if the next character is xx
            :with_del(cond.not_after_regex "xx")
            -- disable adding a newline when you press <cr>
            :with_cr(cond.none()),
        },
        -- disable for .vim files, but it work for another filetypes
        Rule("a", "a", "-vim")
      )
      require('nvim-autopairs').remove_rule([[`]])
      require('nvim-autopairs').setup({
        disable_filetype = {
            "tex", "TelescopePrompt", "text",
            "neo-tree-popup", "spectre_panel",
            "nofile", "quickfix", "prompt",
            -- "dressinginput", "DressingSelect",
        },
      })
    end,
  },
}
