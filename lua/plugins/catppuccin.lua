return {
  "catppuccin/nvim",
  name = "catppuccin",
  opts = function()
    local latte = require("catppuccin.palettes").get_palette "latte"
    local mappings = {
      ["t"] = {
        function()
          local cat = require "catppuccin"
          cat.options.transparent_background = not cat.options.transparent_background
          cat.compile()
          vim.cmd.colorscheme(vim.g.colors_name)
        end,
        "Toggle transparency",
      },
    }
    require("which-key").register(mappings, {
      mode = "n",
      prefix = "<Leader><LocalLeader>",
    })
    return {
      transparent_background = true,
      show_end_of_buffer = true,
      dim_inactive = { enabled = false },
      integrations = {
        alpha = false,
        dashboard = false,
        flash = false,
        nvimtree = false,
        ts_rainbow = false,
        ts_rainbow2 = false,
        barbecue = false,
        indent_blankline = false,
        navic = false,
        dropbar = false,

        aerial = true,
        dap = { enabled = true, enable_ui = true },
        headlines = true,
        mason = true,
        native_lsp = { enabled = true, inlay_hints = { background = false } },
        neogit = true,
        neotree = true,
        noice = true,
        notify = true,
        sandwich = true,
        semantic_tokens = true,
        symbols_outline = true,
        which_key = true,
      },
      custom_highlights = {
        -- disable italics  for treesitter highlights
        TabLineFill = { link = "StatusLine" },
        LspInlayHint = { style = { "italic" } },
        ["@parameter"] = { style = {} },
        ["@type.builtin"] = { style = {} },
        ["@namespace"] = { style = {} },
        ["@text.uri"] = { style = { "underline" } },
        ["@tag.attribute"] = { style = {} },
        ["@tag.attribute.tsx"] = { style = {} },
        -- WhichKeyFloat = { bg = "#1e1e2e" },
        WhichKeyFloat = { link = "FloatBorder" },
      },
      color_overrides = {
        latte = {
          base = "#F7F8F8",
          -- mantle = "#242424",
          -- crust = "#474747",
        },
      },
    }
  end,
}
