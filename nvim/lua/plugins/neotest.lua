---@type LazySpec
return {
  "nvim-neotest/neotest",
  opts = function()
    return {
      adapters = {
        require "neotest-golang",
        require "neotest-rust",
        require "neotest-python",
      },
    }
  end,
}
