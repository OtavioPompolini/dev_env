return {
	"folke/tokyonight.nvim",
	lazy = false,
	priority = 1000,
	opts = {},
	config = function()
		require("tokyonight").setup({
			style = "night",
			transparent = true,
			-- on_highlights = function(hl, c)
			-- 	hl.TelescopeNormal = {
			-- 		bg = "none",
			-- 	}
			-- 	hl.TelescopeBorder = {
			-- 		bg = "none",
			-- 	}
			-- 	hl.TelescopePromptNormal = {
			-- 		bg = "none",
			-- 	}
			-- 	hl.TelescopePromptBorder = {
			-- 		bg = "none",
			-- 	}
			-- 	hl.TelescopePromptTitle = {
			-- 		bg = "none",
			-- 	}
			-- 	hl.TelescopePreviewTitle = {
			-- 		bg = "none",
			-- 	}
			-- 	hl.TelescopeResultsTitle = {
			-- 		bg = "none",
			-- 	}
			-- end,
		})

		vim.cmd.colorscheme("tokyonight-night")
		-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
		-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
		-- vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })

		-- local floatborder_hl = vim.api.nvim_get_hl(0, { name = "FloatBorder", link = false })
		-- local fg_color = floatborder_hl and floatborder_hl.fg or nil
		-- if fg_color then
		-- 	vim.api.nvim_set_hl(0, "FloatBorder", { fg = fg_color, bg = "none" })
		-- end
	end,
}
