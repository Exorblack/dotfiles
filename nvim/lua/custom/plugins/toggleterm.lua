return {
  'akinsho/toggleterm.nvim',
  version = '*',
  config = function()
    require('toggleterm').setup {
      open_mapping = [[<C-\>]],
      direction = 'horizontal', -- "vertical" or "float" option available
      start_in_insert = true,
    }
  end,
}
