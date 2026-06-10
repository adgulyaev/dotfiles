-- ~/.config/nvim/lsp/ts_ls.lua
local vue_plugin_path = vim.fn.expand(
  '~/.local/share/nvim/mason/packages/vue-language-server/node_modules/@vue/language-server'
)

return {
  cmd = { 'typescript-language-server', '--stdio' },
  filetypes = {
    'typescript',
    'javascript',
    'javascriptreact',
    'typescriptreact',
    'vue', -- needed so ts_ls attaches to .vue files (for @vue/typescript-plugin)
  },
  root_markers = { 'tsconfig.json', 'jsconfig.json', 'package.json', '.git' },
  init_options = {
    plugins = {
      {
        name = '@vue/typescript-plugin',
        location = vue_plugin_path,
        languages = { 'vue' },
      },
    },
  },
}
