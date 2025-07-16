return {
  {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
  },
  {
    "mason-org/mason.nvim",
    cmd = "Mason",
    opts = {
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗"
        },
      },
    },
  },
  {
    "mason-org/mason-lspconfig.nvim",
    event = "BufReadPre",
    opts = {
      ensure_installed = {
        "lua_ls",         -- For lua
        "html",           -- For HTML
        "cssls",          -- For CSS
        "ts_ls",          -- For JavaScript (including React/Next.js JSX/TSX)
        "jdtls",          -- For Java
        "pyright",        -- For Python
        "clangd",         -- For C/C++
        "eslint",         -- For JavaScript/TypeScript linting (including frameworks)
        "tailwindcss",
      },
    },
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
    },
  },
  {
    'saghen/blink.cmp',
    event = "InsertEnter",
    dependencies = { 'rafamadriz/friendly-snippets' },
    version = '1.*',
    opts = {
      keymap = { preset = 'super-tab' },
      appearance = {
        nerd_font_variant = 'mono'
      },
      completion = { documentation = { auto_show = true } },
      sources = {
        default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer' },
        providers = {
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            -- make lazydev completions top priority (see `:h blink.cmp`)
            score_offset = 100,
          },
        },
      },

      fuzzy = { implementation = "prefer_rust_with_warning" }
    },
    opts_extend = { "sources.default" }
  },
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  }
}
