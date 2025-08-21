return { "nvim-treesitter/nvim-treesitter",
   branch = 'master',
   event = "BufReadPre",
   build = ':TSUpdate',
   config = function()
     require("nvim-treesitter.configs").setup({
        ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "html", "css", "java", "javascript" },

        auto_install = true,

        highlight = {
          enable = true,
        },

        indent = {
          enable = true,
        },
     })
   end,
}
