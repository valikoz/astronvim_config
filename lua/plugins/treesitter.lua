-- Customize Treesitter

---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    {
      "HiPhish/rainbow-delimiters.nvim",
      opts = function()
        return {
          strategy = {
            [""] = function()
              if not vim.b.large_buf then return require("rainbow-delimiters").strategy.global end
            end,
          },
        }
      end,
      config = function(_, opts) require "rainbow-delimiters.setup"(opts) end,
    },
  },
  opts = function(_, opts)
    -- add more things to the ensure_installed table protecting against community packs modifying it
    opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, {
      "lua",
      "vim",
      -- add more arguments for adding more treesitter parsers
    })
    opts.highlight = {
       enable = true,
       disable = { "latex" },
     }

    opts.context_commentstring = {
      enable = true,

      -- With Comment.nvim, we don't need to run this on the autocmd.
      -- Only run it in pre-hook
      enable_autocmd = false,

      config = {
        c = "// %s",
        lua = "-- %s",
      },
    }
  end,
}
