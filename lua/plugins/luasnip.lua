return {
  "L3MON4D3/LuaSnip",
  dependencies = {
    -- locally load snippets
    { 
      dir = "~/plugins/sniplib.nvim",
      config = function() require("sniplib").lazy_load() end 
    },
  },
  config = function(plugin, opts)
    require "astronvim.plugins.configs.luasnip"(plugin, opts) -- include the default astronvim config that calls the setup call
    -- add more custom luasnip configuration such as filetype extend or custom snippets
    local luasnip = require "luasnip"

    luasnip.filetype_extend("javascript", { "javascriptreact" })

    luasnip.config.setup {
      enable_autosnippets = true,
      store_selection_keys = "<c-x>",
      history = true,
      update_events = "TextChanged,TextChangedI",
    }
    -- load snippets paths
    require("luasnip.loaders.from_lua").lazy_load {
      paths = { "./lua/snippets", },
    }
    require("luasnip.loaders.from_vscode").load {
      exclude = { "tex", },
    }
  end,
}
