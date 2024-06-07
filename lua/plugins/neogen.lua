return {
  {
    "danymat/neogen",
    cmd = "Neogen",
    opts = {
      snippet_engine = "luasnip",
      languages = {
        lua = { template = { annotation_convention = "emmylua" } },
        typescript = { template = { annotation_convention = "tsdoc" } },
        typescriptreact = { template = { annotation_convention = "tsdoc" } },
      },
    },
  },
}
