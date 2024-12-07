
require('telescope').setup {
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = false,
      override_file_sorter = true,
      case_mode = "smart_case",
    }
  }
}
require('telescope').load_extension('fzf')

local builtin = require("telescope.builtin")
-- find tools
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

-- LSP tools
vim.keymap.set('n', '<leader>lr', builtin.lsp_references, {})
vim.keymap.set('n', '<leader>ld', builtin.lsp_definitions, {})
vim.keymap.set('n', '<leader>lD', builtin.lsp_type_definitions, {})
vim.keymap.set('n', '<leader>lsm', builtin.lsp_document_symbols, {})
vim.keymap.set('n', '<leader>lsi', builtin.lsp_implementations, {})
vim.keymap.set('n', '<leader>li', builtin.lsp_incoming_calls, {})
vim.keymap.set('n', '<leader>lo', builtin.lsp_outgoing_calls, {})
vim.keymap.set('n', '<leader>lk', builtin.diagnostics, {})

-- tree tools
vim.keymap.set('n', '<leader>tt', builtin.treesitter, {})
