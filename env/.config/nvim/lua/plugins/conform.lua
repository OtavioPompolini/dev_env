return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	opts = {
		notify_on_error = false,
		format_after_save = {
			async = true,
			timeout_ms = 500,
			lsp_fallback = true,
		},
		formatters_by_ft = {
			javascript = { { "prettierd", "prettier" } },
			typescript = { { "prettierd", "prettier" } },
			typescriptreact = { { "prettierd", "prettier" } },
			lua = { "stylua" },
			sql = { "sql_formatter" },
			go = { "goimports-reviser" },
		},
	},
}
