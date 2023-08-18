local electric_quotes = require('electric-quotes')

vim.api.nvim_create_user_command(
    'ElectricQuotesToggle',
    function() electric_quotes.toggle() end,
    {
        desc  = 'Toggle electric-quotes.nvim on & off',
        force = true
    }
)
