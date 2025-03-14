-- Customize Treesitter

---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = {
      "lua",
      "vim",
      "html",
      -- add more arguments for adding more treesitter parsers
    },
  },
  highlight = {
    enable = true,
    disable = { "just" },
  },
}
