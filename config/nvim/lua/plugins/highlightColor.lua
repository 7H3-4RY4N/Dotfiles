return{
    'brenoprata10/nvim-highlight-colors',
    event = 'BufReadPost',
    config = function ()
        require('nvim-highlight-colors').setup{
            render = 'background',
        }
    end,
}
