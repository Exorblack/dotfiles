return {
  'catppuccin/nvim',
  name = 'catppuccin',
  lazy = false,
  priority = 1000,
  config = function()
    -- Set up the Catppuccin colorscheme
    require('catppuccin').setup {
      flavour = 'mocha', -- latte, frappe, macchiato, mocha
      transparent_background = true, -- Make the background transparent
      integrations = {
        notify = true,
      },
      term_colors = true, -- Also set terminal colors
    }

    vim.cmd.colorscheme 'catppuccin'

    -- Additional transparency settings to ensure full coverage
    vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
    vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
    vim.api.nvim_set_hl(0, 'NormalNC', { bg = 'none' })

    --vim.api.nvim_set_hl(0, 'LineNr', { fg = '#A6E3A1' }) -- Lighter green for line numbers
    --vim.api.nvim_set_hl(0, 'NonText', { fg = '#D9E0EE' }) -- Lighter green for '~' at end of buffer
    --vim.api.nvim_set_hl(0, 'Whitespace', { fg = '#D9E0EE' }) -- Also set whitespace characters
    --vim.api.nvim_set_hl(0, 'EndOfBuffer', { fg = '#D9E0EE' }) -- Specifically for the '~' character at end of buffer
  end,
}
