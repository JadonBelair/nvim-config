local langs = { 'rust', 'zig', 'lua', 'c', 'ocaml' }

require('nvim-treesitter').install(langs)
vim.api.nvim_create_autocmd('FileType', {
  pattern = langs,
  callback = function() vim.treesitter.start() end,
})
