---@type LazySpec
return {
  "nvim-neotest/neotest",
  dependencies = {
    { "fredrikaverpil/neotest-golang", version = "*" },
    "marilari88/neotest-vitest",
  },
  opts = function()
    return {
      adapters = {
        require "neotest-golang",
        -- require "neotest-rust",
        require "neotest-python",
        require "neotest-vitest",
      },
    }
  end,
}
