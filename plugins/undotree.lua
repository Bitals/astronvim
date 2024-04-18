return{
	"jiaoshijie/undotree",
	dependencies = "nvim-lua/plenary.nvim",
	config = function()
		require('undotree').setup({
			float_diff = false,	-- using float window previews diff, set this `true` will disable layout option
			layout = "right_bottom", -- "left_bottom", "left_left_bottom"
			position = "right", -- "right", "bottom"
			ignore_filetype = { 'undotree', 'undotreeDiff', 'qf', 'TelescopePrompt', 'spectre_panel', 'tsplayground', 'neo-tree' },
			window = {
				winblend = 50,
			},
			keymaps = {
				['j'] = "move_next",
				['k'] = "move_prev",
				['gj'] = "move2parent",
				['J'] = "move_change_next",
				['K'] = "move_change_prev",
				['<cr>'] = "action_enter",
				['p'] = "enter_diffbuf",
				['q'] = "quit",
			},
		})
	end
	-- keys = { -- load the plugin only when using it's keybinding:
		-- { "<leader>u", "<cmd>lua require('undotree').toggle()<cr>" },
	-- },
}
