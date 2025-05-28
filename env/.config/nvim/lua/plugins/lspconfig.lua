return {
  "neovim/nvim-lspconfig",
  dependencies = {
    { "williamboman/mason.nvim", opts = {} },
    "williamboman/mason-lspconfig.nvim",

    -- Useful status updates for LSP.
    { "j-hui/fidget.nvim",       opts = {} },

    -- Allows extra capabilities provided by blink.cmp
    "saghen/blink.cmp",
  },
  config = function()
    require("mason").setup({})

    local capabilities = require("blink.cmp").get_lsp_capabilities()
    local servers = {}

    require("mason-lspconfig").setup({
      ensure_installed = { "gopls", "lua_ls", "sqls", "ts_ls" },

      handlers = {
        function(server_name)
          local server = servers[server_name] or {}
          -- This handles overriding only values explicitly passed
          -- by the server configuration above. Useful when disabling
          -- certain features of an LSP (for example, turning off formatting for ts_ls)
          server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
          require("lspconfig")[server_name].setup(server)
        end,
      },
    })

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc, mode)
          mode = mode or "n"
          vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end

        map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
        map("<leader>ca", vim.lsp.buf.code_action, "[G]oto Code [A]ction", { "n", "x" })
        map("<leader>gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
        map("<leader>gi", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
        map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
        map("<leader>gs", require("telescope.builtin").lsp_document_symbols, "Open Document Symbols")
        map("<leader>gw", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Open Workspace Symbols")
      end,
    })
  end,
}
