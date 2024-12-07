require("mason").setup()
require("mason-lspconfig").setup()

local util = require("lspconfig/util")
local path = util.path

local function get_python_path(workspace)
  -- Use activated poetry
  if vim.env.VIRTUAL_ENV then
    return path.join(vim.env.VIRTUAL_ENV, "bin", "python")
  end 

  -- Find and use poetry from poetry in workspace directory
  local match = vim.fn.glob(path.join(workspace, 'poetry.lock'))
  if match ~= '' then
    local venv = vim.fn.trim(vim.fn.system('poetry env info -p'))
    return path.join(venv, 'bin', 'python')
  end 
  
  -- Fallback to system python
  return vim.fn.exepath('python3') or vim.fn.exepath('python') or 'python'
end

local cmp = require'cmp'
cmp.setup({
  snippet = {
    expand = function(args) 
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
  }, {
    { name = 'buffer' },
  })
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()
local lspconfig = require'lspconfig'
lspconfig.gopls.setup{
  capabilities = capabilities,
   settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
      gofumpt = true,
    },
  },
}

lspconfig.templ.setup{
  on_attach = on_attach,
  capabilities = capabilities
}

lspconfig.htmx.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "html", "templ" },
})

lspconfig.clangd.setup({
  on_attach = on_attach,
  capabilities = capabilities
})

lspconfig.emmet_language_server.setup{
  capabilities = capabilities
}
lspconfig.tailwindcss.setup({
  capabilities = capabilities,
  filetypes = { "html", "css", "javascript", "javascriptreact", "typescript", "typescriptreact", "templ" },
})
lspconfig.pyright.setup{
  on_attach = function() 
    client.config.settings.python.pythonPath = get_python_path(client.config.root_dir)
    require'lsp_signature'.on_attach {
    }
  end,
  on_init = function(client)
    client.config.settings.python.pythonPath = get_python_path(client.config.root_dir)
  end,
  capabilities = capabilities
}
lspconfig.sourcekit.setup{
    capabilities = {
    workspace = {
      didChangeWatchedFiles = {
        dynamicRegistration = true,
      },
    },
  },
}
lspconfig.cssls.setup{
  capabilities = capabilities
}
lspconfig.phpactor.setup{
  capabilities = capabilities
}
lspconfig.html.setup{
  capabilities = capabilities
} 
lspconfig.dockerls.setup{
  capabilities = capabilities
}
lspconfig.jsonls.setup{capabilities = capabilities}
lspconfig.ocamllsp.setup{capabilities = capabilities}



--lspconfig.emmet_ls.setup{
  -- on_attach = on_attach,
 -- capabilities = capabilities,
  --filetypes = { "css", "eruby", "html", "javascript", "javascriptreact", "json", "sass", "scss", "typescript", "typescriptreact", "svelte", "vue" },
 -- init_options = {
  --  html = {
   --   options = {
        -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79
   -- },
 -- },
--}

vim.api.nvim_create_autocmd('BufWritePre', {
 -- pattern = "*.go",
 callback = function()
   vim.lsp.buf.format({async = false})
  end
})

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client.server_capabilities.hoverProvider then
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, {buffer = args.buf})
    end

    local wk = require('which-key')
    wk.register({
      K = { vim.lsp.buf.hover, "LSP hover info"},
      gd = { vim.lsp.buf.definition, "LSP go to definition"},
      gD = { vim.lsp.buf.declaration, "LSP go to declaration"},
      gi = { vim.lsp.buf.implementation, "LSP go to implementation"},
      gr = { vim.lsp.buf.references, "LSP list references"},
      gs = { vim.lsp.buf.signature_help, "LSP signature help"},
      gn = { vim.lsp.buf.rename, "LSP rename"},
      ["[g"] = { vim.diagnostic.goto_prev, "Go to previous diagnostic"},
      ["g]"] = { vim.diagnostic.goto_next, "Go to next diagnostic"},
    }, {
      mode = 'n',
      silent = true,
    })
  end
})

vim.keymap.set('n', '<C-k>', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>lq', vim.diagnostic.setloclist)

vim.filetype.add({ extension = { templ = "templ" } })
vim.api.nvim_create_autocmd({ "BufWritePre" }, { pattern = { "*.templ" }, callback = vim.lsp.buf.format })
