---@type LazySpec
return {
  "nvim-neotest/neotest",
  dependencies = {
    { "fredrikaverpil/neotest-golang", version = "*" },
  },
  opts = function()
    return {
      adapters = {
        require "neotest-golang",
        -- require "neotest-rust",
        require "neotest-python",
      },
    }
  end,
}
