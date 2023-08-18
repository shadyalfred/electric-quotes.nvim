local smart_quotes = require('smart-quotes')

vim.api.nvim_create_user_command(
    'SmartQuotesToggle',
    function() smart_quotes.toggle() end,
    {
        desc  = 'Toggle smart-quotes on & off',
        force = true
    }
)
