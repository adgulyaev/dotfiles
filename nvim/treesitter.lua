-- ~/.config/nvim/treesitter.lua
require('nvim-treesitter.configs').setup {
  ensure_installed = { 'vue', 'html', 'typescript', 'javascript', 'css', 'scss' },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}
