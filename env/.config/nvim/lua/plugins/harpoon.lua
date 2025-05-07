return {
   "OtavioPompolini/harpoon",
   branch = "harpoon2",
   dependencies = {
      "nvim-lua/plenary.nvim"
   },
   config = function()
      local harpoon = require("harpoon")

      -- REQUIRED
      harpoon:setup({
         settings = {
            sync_on_ui_close = true,
            save_on_toggle = false
         }
      })
      -- REQUIRED
      --

      vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
      vim.keymap.set("n", "<C-e>", function()
         harpoon.ui:toggle_quick_menu(
            harpoon:list(),
            { title = "" }
         )
      end)

      vim.keymap.set("n", "<A-j>", function() harpoon:list():select(1) end)
      vim.keymap.set("n", "<A-k>", function() harpoon:list():select(2) end)
      vim.keymap.set("n", "<A-l>", function() harpoon:list():select(3) end)
      vim.keymap.set("n", "<A-;>", function() harpoon:list():select(4) end)
   end
}
