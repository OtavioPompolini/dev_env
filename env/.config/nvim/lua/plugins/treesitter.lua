return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    -- Minimal configuration for nvim-treesitter (main branch)
    -- See: https://github.com/nvim-treesitter/nvim-treesitter/tree/main

    -- Install common parsers
    require("nvim-treesitter").install({
      "lua",
      "vim",
      "vimdoc",
      "query",
      "javascript",
      "typescript",
      "python",
    })

    -- Enable native Neovim treesitter highlighting
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "lua", "vim", "vimdoc", "query", "javascript", "typescript", "python" },
      callback = function()
        vim.treesitter.start()
      end,
    })
  end,
}
