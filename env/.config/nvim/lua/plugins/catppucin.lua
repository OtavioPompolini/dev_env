return {
	"catppuccin/nvim",
	config = function()
		require("catppuccin").setup({
			integrations = {
				cmp = true,
				fidget = true,
				gitsigns = true,
				harpoon = true,
				indent_blankline = {
					enabled = true,
					scope_color = "sapphire",
					colored_indent_levels = false,
				},
				mason = true,
				native_lsp = { enabled = true },
				noice = true,
				notify = true,
				symbols_outline = true,
				telescope = true,
				treesitter = true,
				treesitter_context = true,
			},
		})

		vim.cmd.colorscheme("catppuccin-macchiato")

		vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
	end,
}
