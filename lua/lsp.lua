require("mason").setup()
require("mason-lspconfig").setup {
  ensure_installed = {
    "templ",
    "gopls",
    "htmx",
    "clangd",
    "emmet_language_server",
    "tailwindcss",
    "pyright",
    "html",
    "dockerls",
    "jsonls",
    "ocamllsp",
    "ts_ls",
    "lua_ls",
    "neocmake",
  },
}

local cmp = require 'cmp'
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

local lspconfig = require 'lspconfig'
lspconfig.lua_ls.setup {
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = "LuaJIT",
        path = vim.split(package.path, ";"),
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { "vim" },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files and plugins
        library = { vim.env.VIMRUNTIME },
        checkThirdParty = false,
      },
      telemetry = {
        enable = false,
      },
    },
  },
}

lspconfig.gopls.setup {
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
require('go').setup()

lspconfig.neocmake.setup {
  capabilities = capabilities,
}

lspconfig.ts_ls.setup {
  capabilities = capabilities
}

lspconfig.templ.setup {
  --on_attach = on_attach,
  capabilities = capabilities
}

lspconfig.htmx.setup({
  --on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "html", "templ" },
})

lspconfig.clangd.setup({
  --on_attach = on_attach,
  capabilities = capabilities
})

lspconfig.emmet_language_server.setup {
  filetypes = { "css", "eruby", "html", "javascript", "javascriptreact", "less", "sass", "scss", "pug", "typescriptreact", "templ", "php" },
  capabilities = capabilities,
}
lspconfig.tailwindcss.setup({
  capabilities = capabilities,
  filetypes = { "html", "css", "javascript", "javascriptreact", "typescript", "typescriptreact", "templ", "php" },
})

lspconfig.pyright.setup {
  --  on_attach = function()
  --   client.config.settings.python.pythonPath = get_python_path(client.config.root_dir)
  --  require 'lsp_signature'.on_attach {
  -- }
  --  end,
  --  on_init = function(client)
  --    client.config.settings.python.pythonPath = get_python_path(client.config.root_dir)
  --  end,
  capabilities = capabilities
}

lspconfig.sourcekit.setup {
  capabilities = {
    workspace = {
      didChangeWatchedFiles = {
        dynamicRegistration = true,
      },
    },
  },
}
lspconfig.cssls.setup {
  capabilities = capabilities
}
lspconfig.phpactor.setup {
  capabilities = capabilities
}
lspconfig.html.setup {
  capabilities = capabilities
}
lspconfig.dockerls.setup {
  capabilities = capabilities
}
lspconfig.jsonls.setup { capabilities = capabilities }
lspconfig.ocamllsp.setup { capabilities = capabilities }

vim.filetype.add({ extension = { templ = "templ" } })

vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = "*.go",
  callback = function()
    require('go.format').goimports()
  end,
})

vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = { "*.cpp", "*.h", "*.c", "*.hpp", "*.ts", "*.js", "*.css", "*.html", "*.templ", "*.ml", "*.mli", "*.re", "*.rei", "*.py", "*.json", "*.md", "*.yaml", "*.php", "*.swift", "*.lua", "*.sql", "DockerFile" },
  callback = function()
    vim.lsp.buf.format({ async = false })
  end
})

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function()
    local wk = require('which-key')
    wk.add({
      { "K",  vim.lsp.buf.hover,          desc = "LSP hover info" },
      { "[g", vim.diagnostic.goto_prev,   desc = "Go to previous diagnostic" },
      { "gD", vim.lsp.buf.declaration,    desc = "LSP go to declaration" },
      { "g]", vim.diagnostic.goto_next,   desc = "Go to next diagnostic" },
      { "gd", vim.lsp.buf.definition,     desc = "LSP go to definition" },
      { "gi", vim.lsp.buf.implementation, desc = "LSP go to implementation" },
      { "gn", vim.lsp.buf.rename,         desc = "LSP rename" },
      { "gr", vim.lsp.buf.references,     desc = "LSP list references" },
      { "gs", vim.lsp.buf.signature_help, desc = "LSP signature help" },
    }, {
      mode = 'n',
      silent = true,
    })
  end
})
