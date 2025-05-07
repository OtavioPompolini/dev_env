return {
   "kdheepak/lazygit.nvim",
   dependencies = {
      "nvim-lua/plenary.nvim",
   },
   config = function ()
      vim.keymap.set("n", "<leader>gs", ":LazyGit<CR>", { desc = "Lazy Git"})
   end
}
