return {
  'akinsho/toggleterm.nvim',
  version = "*",
  cmd = "ToggleTerm",
  opts = {
    size = 20,
    open_mapping = [[<leader>tg]],
    hide_numbers = true,
    direction = "horizontal",
   -- float_opts = {
    --  border = "single", -- 'single', 'double', 'curved', 'none'
    --  width = vim.o.columns - 10,  -- Example: 10 columns less than full width
      --height = vim.o.lines - 8,    -- Example: 8 lines less than full height
    --  row = 4,                     -- Example: Fixed offset from top
     -- col = 5,
      --winblend = 3,      -- Transparency (0-100)
     -- highlights = {
        --border = "Normal",
     --   background = "Normal",
    --  },
   -- },
  },
  keys = {
    { "<leader>t", "<cmd>ToggleTerm<cr>", desc = "Toggle Terminal (Default: Horizontal)" },
    { "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", desc = "Toggle Floating Terminal" },
    { "<leader>th", "<cmd>ToggleTerm direction=horizontal<cr>", desc = "Toggle Horizontal Terminal" },
    { "<esc>", "<cmd>ToggleTerm<cr>", mode = "t", desc = "Exit Terminal and Hide" },
  },
  config = function(_, opts)
    require("toggleterm").setup(opts)
  end,
}
