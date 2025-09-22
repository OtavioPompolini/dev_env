return {
  "OtavioPompolini/peta",
  cmd = { "Peta", "PetaOpen", "PetaClose" },
  keys = {
    { "<leader>pe", desc = "Toggle Peta HTTP Client" },
  },
  config = function()
    require("peta").setup({})
  end,
}
