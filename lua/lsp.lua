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

lspconfig.emmet_language_server.setup{
  capabilities = capabilities
}
lspconfig.tailwindcss.setup({
  capabilities = capabilities,
  filetypes = { "html", "css", "javascript", "javascriptreact", "typescript", "typescriptreact", "templ" },
})
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

--autocmd("BufWritePre", {
 -- pattern = "*.go",
  --callback = function()
    --local params = vim.lsp.util.make_range_params()
   -- params.context = {only = {"source.organizeImports"}}
    -- buf_request_sync defaults to a 1000ms timeout. Depending on your
    -- machine and codebase, you may want longer. Add an additional
    -- argument after params if you find that you have to write the file
    -- twice for changes to be saved.
    -- E.g., vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
    --local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
    --for cid, res in pairs(result or {}) do
    --  for _, r in pairs(res.result or {}) do
     --   if r.edit then
      --    local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
       --   vim.lsp.util.apply_workspace_edit(r.edit, enc)
       -- end
     -- end
   -- end
   -- vim.lsp.buf.format({async = false})
 -- end
--})

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client.server_capabilities.hoverProvider then
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, {buffer = args.buf})
    end
  end
})

-- vim.keymap.set('n', '<leader>lk', vim.diagnostic.open_float)
-- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
-- vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
-- vim.keymap.set('n', '<leader>lq', vim.diagnostic.setloclist)

vim.filetype.add({ extension = { templ = "templ" } })
vim.api.nvim_create_autocmd({ "BufWritePre" }, { pattern = { "*.templ" }, callback = vim.lsp.buf.format })
