return {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	config = function()
		-- local harpoon = require("harpoon")
		-- local function harpoon_component()
		-- 	local total_marks = harpoon:list():length()
		--
		-- 	if total_marks == 0 then
		-- 		return ""
		-- 	end
		--
		-- 	local current_mark = "—"
		--
		-- 	local mark_idx = harpoon:list():index()
		-- 	print("pudim" .. vim.inspect(mark_idx))
		-- 	if mark_idx ~= nil then
		-- 		current_mark = tostring(mark_idx)
		-- 	end
		--
		-- 	return string.format("󱡅 %s/%d", current_mark, total_marks)
		-- end

		require("lualine").setup({
			options = {
				icons_enabled = true,
				theme = "catppuccin-macchiato",
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
