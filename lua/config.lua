require('lualine').setup {
  options = { theme = auto, 
    refresh = {
      statusline = 100,
      tabline = 100,
      winbar = 100,
    }
  }
}

-- Rainbow delimiters
local rainbow_delimiters = require 'rainbow-delimiters'

vim.cmd[[highlight RainbowDelimiterYellow guifg=#ffffaf ctermfg=White]]
vim.cmd[[highlight RainbowDelimiterLavender guifg=#dfafff ctermfg=White]]
vim.cmd[[highlight RainbowDelimiterLightPurple guifg=#ffdfff ctermfg=White]]
vim.cmd[[highlight RainbowDelimiterPink guifg=#ffafdf ctermfg=White]]
vim.cmd[[highlight RainbowDelimiterLightBlue guifg=#afffff ctermfg=White]]
vim.cmd[[highlight RainbowDelimiterMint guifg=#afffd7 ctermfg=White]]

require 'rainbow-delimiters.setup'.setup {
  strategy = {
    [''] = rainbow_delimiters.strategy['global'],
    commonlisp = rainbow_delimiters.strategy['local'],
  },
  query = {
    [''] = 'rainbow-delimiters',
    lua = 'rainbow-blocks',
  },
  priority = {
    [''] = 110,
    lua = 120,
  },
  highlight = {
    'RainbowDelimiterMint',
    'RainbowDelimiterPink',
    'RainbowDelimiterLightBlue',
    'RainbowDelimiterLavender',
    'RainbowDelimiterLightPurple',
    'RainbowDelimiterYellow',
  },
}
