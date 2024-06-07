-- install without yarn or npm
return {
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  ft = { "markdown" },
  build = function() vim.fn["mkdp#util#install"]() end,
  config = function()
    vim.g.mkdp_theme = 'dark'  -- 'light'
    -- vim.g.mkdp_filetypes = { 'markdown', }
  end,
}
