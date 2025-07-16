return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  cmd = "Neotree",
  keys = {
    { "<leader>e", "<cmd>Neotree filesystem toggle left<CR>", desc = "Toggle Neo-tree File Explorer" },
    { "<leader>bf", "<cmd>Neotree buffers toggle float<CR>", desc = "Toggle Neo-tree Buffers" },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    vim.keymap.set("n", "<leader>e", ":Neotree filesystem toggle left<CR>", { desc = "Toggle Neo-tree File Explorer" })
    vim.keymap.set("n", "<leader>bf", ":Neotree buffers toggle float<CR>", { desc = "Toggle Neo-tree Buffers" })
  end,
}
