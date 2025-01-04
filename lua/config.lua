local colors = {
  -- dark_gray     = "#303030",
  darker_gray   = "#202020",
  mid_gray      = "#878787",
  default_white = "#FFFFFF",

  lavender      = "#dfafff",
  light_purple  = "#ffdfff",
  gray_puprle   = "#afafd7",

  pink          = "#ffafdf",
  light_blue    = "#afffff",
  mint          = "#afffd7",
  light_yellow  = "#ffffaf",

  dark_pink     = "#ff005f",
  dark_green    = "#00875f",
  dark_blue     = "#0087af",
}


require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = {
      normal = {
        a = { bg = colors.mint, fg = colors.darker_gray, gui = 'bold' },
        b = { fg = colors.default_white },
      },
      insert = {
        a = { bg = colors.light_blue, fg = colors.darker_gray, gui = 'bold' },
      },
      visual = {
        a = { bg = colors.lavender, fg = colors.darker_gray, gui = 'bold' },
      },
      replace = {
        a = { bg = colors.pink, fg = colors.darker_gray, gui = 'bold' },
      },
      command = {
        a = { bg = colors.light_yellow, fg = colors.darker_gray, gui = 'bold' },
      },
      inactive = {
        a = { bg = colors.dark_pink, fg = colors.darker_gray, gui = 'bold' },
      },
    },
    component_separators = { left = '|', right = '|', gui = 'bold' },
    section_separators = { left = '', right = '' },
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    always_show_tabline = true,
    globalstatus = false,
    refresh = {
      statusline = 100,
      tabline = 100,
      winbar = 100,
    }
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch', 'diff', 'diagnostics' },
    lualine_c = { 'filename' },
    lualine_x = { 'encoding' },
    lualine_y = { 'filetype' },
    lualine_z = { 'progress', 'location' }
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { 'filename' },
    lualine_x = { 'location' },
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {},
}

-- Rainbow delimiters
local rainbow_delimiters = require 'rainbow-delimiters'

vim.cmd [[highlight RainbowDelimiterYellow guifg=#ffffaf ctermfg=White]]
vim.cmd [[highlight RainbowDelimiterLavender guifg=#dfafff ctermfg=White]]
vim.cmd [[highlight RainbowDelimiterLightPurple guifg=#ffdfff ctermfg=White]]
vim.cmd [[highlight RainbowDelimiterPink guifg=#ffafdf ctermfg=White]]
vim.cmd [[highlight RainbowDelimiterLightBlue guifg=#afffff ctermfg=White]]
vim.cmd [[highlight RainbowDelimiterMint guifg=#afffd7 ctermfg=White]]

local highlight = {
  'RainbowDelimiterMint',
  'RainbowDelimiterPink',
  'RainbowDelimiterLightBlue',
  'RainbowDelimiterLavender',
  'RainbowDelimiterLightPurple',
  'RainbowDelimiterYellow',
}

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
  highlight = highlight,
}

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  pattern = { "*.py", "*.fs", "*.ml", "*.hs", "*.sql" }, -- tab delimted languages
  callback = function()
    require("ibl").setup { indent = { highlight = highlight } }
  end
})
