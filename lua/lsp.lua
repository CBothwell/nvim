require("mason").setup()
require("mason-lspconfig").setup()


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
}
lspconfig.emmet_language_server.setup{
  capabilities = capabilities
}
lspconfig.tailwindcss.setup{
  capabilities = capabilities
}
lspconfig.tsserver.setup{
  capabilities = capabilities
}
lspconfig.pylsp.setup{
  capabilities = capabilities
}
lspconfig.sourcekit.setup{
  capabilities = capabilities
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
    --    ["bem.enabled"] = true,
     -- },
   -- },
 -- },
--}

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client.server_capabilities.hoverProvider then
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, {buffer = args.buf})
    end
  end
})

vim.keymap.set('n', '<leader>lk', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>lq', vim.diagnostic.setloclist)






