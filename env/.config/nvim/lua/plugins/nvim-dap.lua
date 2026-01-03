return {
  "rcarriga/nvim-dap-ui",
  dependencies = {
    "mfussenegger/nvim-dap",
    "jay-babu/mason-nvim-dap.nvim",
    "nvim-neotest/nvim-nio",
    "leoluz/nvim-dap-go"
  },
  config = function()
    require("mason-nvim-dap").setup({
      ensure_installed = { "go-debug-adapter" },
      handlers = {},
    })
    local dap, dapui = require("dap"), require("dapui")

    require("dap-go").setup()

    -- require('dap').configurations.go = {
    --   -- Debug with make build
    --   {
    --     type = "delve",
    --     name = "Debug (make build)",
    --     request = "launch",
    --     program = "${file}",
    --     preBuildTask = "make build", -- Custom build command
    --   },
    --   -- Default (go build)
    --   {
    --     type = "delve",
    --     name = "Debug",
    --     request = "launch",
    --     program = "${file}",
    --   },
    -- }

    dapui.setup()
    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end
    vim.keymap.set("n", "<F5>", function()
      dap.continue()
    end)
    vim.keymap.set("n", "<F10>", function()
      dap.step_over()
    end)
    vim.keymap.set("n", "<F11>", function()
      dap.step_into()
    end)
    vim.keymap.set("n", "<F12>", function()
      dap.step_out()
    end)
    vim.keymap.set("n", "<Leader>b", function()
      dap.toggle_breakpoint()
    end)
    vim.keymap.set("n", "<Leader>B", function()
      dap.set_breakpoint()
    end)
  end,
}
