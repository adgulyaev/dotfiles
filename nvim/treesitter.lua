-- ~/.config/nvim/treesitter.lua

-- Neovim 0.12 ships these parsers built-in — no compilation needed:
-- c, lua, vim, vimdoc, query, markdown, markdown_inline,
-- bash, python, json, yaml, toml, html, css, javascript, typescript
--
-- We only need to install what is NOT bundled:
local extra_parsers = {
  'vue',  -- required for .vue SFC structure
  'scss', -- required for <style lang="scss"> injection
}

-- Compiler fallback order: prefer zig if cc/gcc/clang are missing
-- Zig ships a bundled C compiler and works on all platforms
require('nvim-treesitter.install').compilers = { 'cc', 'gcc', 'clang', 'zig' }

-- Prefer downloading pre-built parsers over compiling from source
require('nvim-treesitter.install').prefer_git = false

require('nvim-treesitter.configs').setup {
  -- Only install parsers not bundled with Neovim 0.12
  ensure_installed = extra_parsers,

  -- Never auto-install on buffer open (avoids surprise build errors)
  auto_install = false,

  highlight = {
    enable = true,

    -- Disable for very large files to avoid slowdowns
    disable = function(_, buf)
      local max_filesize = 200 * 1024 -- 200 KB
      local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_filesize then
        return true
      end
    end,

    -- Keep this off — conflicts with Treesitter in Vue files
    additional_vim_regex_highlighting = false,
  },

  indent = {
    enable = true,
  },
}

-- Verify parsers that are expected to be built-in
local bundled = { 'html', 'css', 'typescript', 'javascript' }
for _, lang in ipairs(bundled) do
  if not pcall(vim.treesitter.language.inspect, lang) then
    vim.notify(
      '[treesitter] Built-in parser missing: ' .. lang .. '. Run :TSInstall ' .. lang,
      vim.log.levels.WARN
    )
  end
end
