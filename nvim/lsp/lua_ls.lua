-- ~/.config/nvim/lsp/lua_ls.lua
return {
  cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
  root_markers = { '.luarc.json', '.luarc.jsonc', '.git' },
  settings = {
    Lua = {
      runtime = {
        -- Tell lua_ls you're using LuaJIT (Neovim's runtime)
        version = 'LuaJIT',
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file('', true),
        checkThirdParty = false, -- suppress "Do you need to configure..." prompts
      },
      diagnostics = {
        -- Recognize `vim` global without needing a .luarc.json
        globals = { 'vim' },
      },
      completion = {
        callSnippet = 'Replace', -- show full call snippets in blink.cmp
      },
      hint = {
        -- Inline type hints
        enable = true,
        arrayIndex = 'Disable',
        setType = true,
        paramName = 'Disable',
        paramType = true,
      },
      telemetry = {
        enable = false,
      },
    },
  },
}
