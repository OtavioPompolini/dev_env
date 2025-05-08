return {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	config = function()
		require("lualine").setup({
			options = {
				icons_enabled = true,
				theme = "tokyonight",
				component_separators = "|",
				section_separators = "",
			},
			sections = {
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = {
					{
						"filename",
						file_status = true,
						newfile_status = false,
						path = 1,

						shorting_target = 20,

						symbols = {
							modified = "[+]",
							readonly = "[-]",
							unnamed = "[No Name]",
							newfile = "[New]",
						},
					},
				},
				lualine_y = {},
				lualine_z = {},
			},
		})
	end,
}
