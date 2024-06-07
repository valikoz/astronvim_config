local utils = require("utils")

return {
  -- override nvim-cmp plugin
  "hrsh7th/nvim-cmp",
  dependencies = {
    { "hrsh7th/cmp-nvim-lua", ft = "lua", },
    { "hrsh7th/cmp-calc" },
    { "hrsh7th/cmp-emoji" },
    { "jc-doyle/cmp-pandoc-references" },
    { "kdheepak/cmp-latex-symbols" },
  },
  -- override the options table that is used in the `require("cmp").setup()` call
  opts = function(_, opts)
    -- opts parameter is the default options table
    -- the function is lazy loaded so cmp is able to be required
    local cmp = require "cmp"
    local snip_status_ok, luasnip = pcall(require, "luasnip")
    if not snip_status_ok then return end

    -- modify the mapping part of the table
    opts.mapping["\f"] = cmp.mapping { -- <c-l> 0x0C FORM FEED
      i = function()
        if cmp.visible() then
          cmp.abort()
        else
          cmp.complete()
        end
      end,
      c = cmp.mapping.close(),
    }
    -- Cycle between nodes from choice_node
    opts.mapping["<C-]>"] = cmp.mapping(function(fallback)
      if luasnip.choice_active() then
        luasnip.change_choice(1)
      else
        fallback()
      end
    end, { 'i', 's' })
    opts.mapping["<C-a>"] = cmp.mapping(function(fallback)
      if luasnip.choice_active() then
        require "luasnip.extras.select_choice"()
      else
        fallback()
      end
    end,
    { 'i', 's' })
    opts.mapping['<C-e>'] = cmp.config.disable
    opts.mapping['<C-n>'] = cmp.mapping(function()
     if require("luasnip").expand_or_jumpable() then
      require("luasnip").expand_or_jump()
     else
      return nil
     end
    end, { 'i', 's' })
    opts.mapping['<C-p>'] = cmp.mapping(function()
      if require("luasnip").jumpable() then
        require("luasnip").jump(-1)
      else
        return false
      end
    end, { 'i', 's' })
    opts.mapping["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item { behavior = cmp.SelectBehavior.Select }
      else
        fallback()
      end
    end, { "i", "s" })
    opts.mapping["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item { behavior = cmp.SelectBehavior.Select }
      -- elseif luasnip.jumpable(-1) then
      --  luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" })
    -- Undo a snippet
    opts.mapping["<c-u>"] = cmp.mapping(function(fallback)
      if require("luasnip").in_snippet() then
        utils.untrigger()
        require("luasnip").unlink_current()
      else
        fallback()
      end
    end, { "i", "s" })
    -- Insert otf snippet
    opts.mapping["<c-f>"] = cmp.mapping {
      i = function()
      vim.ui.input({ prompt = 'Enter regname: ' }, function(input)
        if input == "" or input == nil then return end
        require('luasnip.extras.otf').on_the_fly(input)
      end)
    end,
    }
    -- modify the sources part of the options table
    opts.sources = {
      {
        name = "nvim_lsp",
        priority = 1000,
        option = { markdown_oxide = { keyword_pattern = [[\(\k\| \|\/\|#\)\+]] } },
      },
      { name = "luasnip", priority = 750 },
      { name = "pandoc_references", priority = 725 },
      { name = "latex_symbols", priority = 700 },
      { name = "emoji", priority = 700 },
      { name = "calc", priority = 650 },
      { name = "path", priority = 500 },
      { name = "buffer", priority = 250, group_index = 2 },
      { name = "nvim_lua", priority = 50 },
    }
    -- return the new table to be used
    return opts
  end,
}
