return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			cond = function()
				return vim.fn.executable("make") == 1
			end,
		},
	},
	config = function()
		require("telescope").setup({
			defaults = {
				vimgrep_arguments = {
					"rg",
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
					"--hidden",
					"--smart-case",
					"--glob",
					"!**/.git/*",
				},
				mappings = {},
				file_ignore_patterns = {
					"%.po",
					"^%.git/",
				},
				path_display = {
					"filename_first",
				},
			},
		})

		vim.keymap.set(
			"n",
			"<leader><space>",
			require("telescope.builtin").buffers,
			{ desc = "[ ] Find existing buffers" }
		)
		vim.keymap.set("n", "<C-p>", require("telescope.builtin").git_files)
		vim.keymap.set("n", "<leader>pf", require("telescope.builtin").find_files)
		vim.keymap.set("n", "<leader>sh", require("telescope.builtin").help_tags)
		vim.keymap.set(
			"n",
			"<leader>sw",
			require("telescope.builtin").grep_string,
			{ desc = "[S]earch current [W]ord" }
		)
		vim.keymap.set("n", "<leader>sg", require("telescope.builtin").live_grep)
	end,
}
