return {
	"stevearc/oil.nvim",
	---@module 'oil'
	---@type oil.SetupOpts
	opts = {},
	dependencies = { { "echasnovski/mini.icons", opts = {} } },
	lazy = false,
	config = function()
		require("oil").setup({
			default_file_explorer = true,
			delete_to_trash = true,
			skip_confirm_for_simple_edits = false,
			keymaps = {
				["-"] = { "actions.parent", mode = "n" },
				["<CR>"] = "actions.select",
			},
			use_default_keymaps = false,
			view_options = {
				show_hidden = true,
				is_always_hidden = function(name, bufnr)
					return name == ".." or name:match(".git.*")
				end,
				natural_order = "fast",
			},
			git = {
				-- Return true to automatically git add/mv/rm files
				add = function(path)
					return true
				end,
				mv = function(src_path, dest_path)
					return true
				end,
				rm = function(path)
					return true
				end,
			},
		})

		vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
		vim.keymap.set("n", "<leader>pv", "<CMD>Oil<CR>", { desc = "Open parent directory" })
	end,
}
