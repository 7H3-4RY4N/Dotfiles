return {
  'akinsho/bufferline.nvim',
  version = "*",
  lazy = false,
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  keys = {
    { "<leader>]", "<cmd>BufferLineCycleNext<CR>", desc = "Next buffer" },
    { "<leader>[", "<cmd>BufferLineCyclePrev<CR>", desc = "Previous buffer" },
    { "<leader>b1", "<cmd>BufferLineGoToBuffer 1<CR>", desc = "Go to buffer 1" },
    { "<leader>b2", "<cmd>BufferLineGoToBuffer 2<CR>", desc = "Go to buffer 2" },
  },

  opts = {
    options = {
      always_show_bufferline = true,
      diagnostics = "nvim_lsp",
      diagnostics_indicator = function(count, level, diagnostics_dict, context)
        local icon = level:match("error") and " " or " " -- Error or Warning icon
        return " " .. icon .. count
      end,
      offsets = {
        {
          filetype = "NvimTree",
          text = "File Explorer",
          text_align = "left",
        },
      },
      sort_by = "insert_after_current",
    },
  },

  config = function(_, opts)
    require("bufferline").setup(opts)
  end,
}
