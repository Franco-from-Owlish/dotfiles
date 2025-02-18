return {
  {
    "eandrju/cellular-automaton.nvim",
    dependecies = {
      {
        "AstroNvim/astrocore",
        opts = {
          mappings = {
            n = {
              ["A"] = { desc = "Fuck my life" },
              ["AG"] = {
                function() require("cellular-automaton").animations.make_it_rain() end,
                desc = "Make it rain",
              },
              ["AR"] = {
                function() require("cellular-automaton").animations.game_of_life() end,
                desc = "Game of life",
              },
              ["AS"] = {
                function() require("cellular-automaton").animations.scramble() end,
                desc = "Scramble",
              },
            },
          },
        },
      },
    },
  },
  "preservim/vim-pencil",
}
