return {
  {
    "kylechui/nvim-surround",
    config = function()
      require("nvim-surround").setup {
        surrounds = {
          ["("] = {
            add = function() return { { "(" }, { ")" } } end,
          },
          ["{"] = {
            add = function() return { { "{" }, { "}" } } end,
          },
          ["["] = {
            add = function() return { { "[" }, { "]" } } end,
          },
          ["<"] = {
            add = function() return { { "<" }, { ">" } } end,
          },
        },
      }
    end,
  },
}
