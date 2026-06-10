-- ~/.config/nvim/lsp/volar.lua
return {
  cmd = { 'vue-language-server', '--stdio' },
  filetypes = { 'vue' },
  root_markers = { 'package.json', '.git' },
  init_options = {
    typescript = {
      -- Resolve tsdk from project-local install, fallback to global Mason path
      tsdk = (function()
        local local_ts = vim.fn.getcwd() .. '/node_modules/typescript/lib'
        if vim.fn.isdirectory(local_ts) == 1 then
          return local_ts
        end
        return vim.fn.expand('~/.local/share/nvim/mason/packages/typescript-language-server/node_modules/typescript/lib')
      end)(),
    },
    vue = {
      hybridMode = true, -- Volar handles .vue, ts_ls handles .ts/.js
    },
  },
}
