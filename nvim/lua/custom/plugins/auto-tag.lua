return {
  'windwp/nvim-ts-autotag',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  config = function()
    require('nvim-ts-autotag').setup {
      -- New format configuration
      autotag = {
        enable = true,
        enable_rename = true,
        enable_close = true,
        enable_close_on_slash = true,

        filetypes = {
          'html',
          'css',
          'typescript',
          'javascriptreact',
          'typescriptreact',
          'vue',
          'svelte',
          'jsx',
          'tsx',
        },
      },
    }
  end,
  event = 'InsertEnter',
}
