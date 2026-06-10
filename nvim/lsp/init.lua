-- ~/.config/nvim/lsp/init.lua

-- Merge blink.cmp capabilities into all LSP servers globally
vim.lsp.config('*', {
  capabilities = require('blink.cmp').get_lsp_capabilities(),
  on_attach = function(client, bufnr)
    local opts = { buffer = bufnr, silent = true }

    vim.keymap.set('n', 'gd',         vim.lsp.buf.definition,     opts)
    vim.keymap.set('n', 'gD',         vim.lsp.buf.declaration,    opts)
    vim.keymap.set('n', 'gr',         vim.lsp.buf.references,     opts)
    vim.keymap.set('n', 'gi',         vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', 'K',          vim.lsp.buf.hover,          opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename,         opts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action,    opts)

    -- Enable semantic tokens (type-aware highlighting inside <template> from Volar)
    if client.server_capabilities.semanticTokensProvider then
      vim.lsp.semantic_tokens.start(bufnr, client.id)
    end
  end,
})

-- Enable servers (lsp/volar.lua and lsp/ts_ls.lua are auto-discovered)
vim.lsp.enable({ 'volar', 'ts_ls' })

-- Ensure .vue files get the vue filetype
vim.filetype.add({ extension = { vue = 'vue' } })
