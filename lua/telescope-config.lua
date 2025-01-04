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

local wk = require('which-key')
wk.add({
  { "<Space>ff", builtin.find_files,           desc = "Fuzzy find files" },
  { "<Space>fg", builtin.live_grep,            desc = "Grep" },
  { "<Space>fb", builtin.buffers,              desc = "Fuzzy find buffers" },
  { "<Space>fh", builtin.help_tags,            desc = "Find by help tags" },

  { "<Space>fD", builtin.lsp_type_definitions, desc = "Lsp type Definitions" },
  { "<Space>fr", builtin.lsp_references,       desc = "Lsp refereneces" },
  { "<Space>fd", builtin.lsp_definitions,      desc = "Lsp definitions" },
  { "<Space>fm", builtin.lsp_document_symbols, desc = "Lsp Document Symbols" },
  { "<Space>fi", builtin.lsp_implementations,  desc = "Lsp Implementations" },
  { "<Space>fc", builtin.lsp_incoming_calls,   desc = "Lsp Incomming calls" },
  { "<Space>fC", builtin.lsp_outgoing_calls,   desc = "Lsp Outgoing calls" },
  { "<Space>fK", builtin.diagnostics,          desc = "Lsp diagnostics" },

  { "<Space>tt", builtin.treesitter,           desc = "Treesitter" },
}, {
  mode = 'n',
  silent = true,
})
