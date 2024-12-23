return {
  {
    "eandrju/cellular-automaton.nvim",
    config = function()
      require "cellular-automaton"
      vim.keymap.set("n", "<leader>AR", "<cmd>CellularAutomaton make_it_rain<CR>")
      vim.keymap.set("n", "<leader>AG", "<cmd>CellularAutomaton game_of_life<CR>")
    end,
  },
  "preservim/vim-pencil",
  {
    "kawre/leetcode.nvim",
    build = ":TSUpdate html", -- if you have `nvim-treesitter` installed
    dependencies = {
      "nvim-telescope/telescope.nvim",
      -- "ibhagwan/fzf-lua",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
    opts = {
      arg = "leetcode",
      lang = "golang",
    },
  },
}
