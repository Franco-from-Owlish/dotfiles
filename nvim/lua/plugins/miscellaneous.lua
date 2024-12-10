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
}
