require('nvim-treesitter.configs').setup {
  ensure_installed = "all",
  sync_install = false,
  auto_install = true,

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false, -- could be a list of languages like ["python", "json"]
  }
}

vim.filetype.add({
  extension = {
    webc = "webc",
  },
  filename = { ['.webc'] = 'html' },
})
vim.treesitter.language.register('html', 'webc')
