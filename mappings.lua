return {
	n = {
		["<leader>a"] = {"<cmd>ASToggle<CR>", desc = "Toggle Autosave"},
		["<leader><F5>"] = {"<cmd>lua require('undotree').toggle()<CR>", desc = "Toggle Undotree"},
		["<C-d>"] = {"<C-d>zz"},
		["<C-u>"] = {"<C-u>zz"},
		["<C-Tab>"] = {
			function() require("astronvim.utils.buffer").nav(vim.v.count > 0 and vim.v.count or 1) end,
			desc = "Switch to buffer tab right",
		},
		["<C-S-Tab>"] = {
			function() require("astronvim.utils.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1)) end,
			desc = "Switch to buffer tab left",
		},
		["n"] = {"nzzzv"},
		["N"] = {"Nzzzv"},
		["<leader>y"] = {"\"+y", desc = "Copy to CB"},
		["p"] = {"\"\"p"},
		["P"] = {"\"\"P"},
		["<leader>p"] = {"\"+p", desc = "Paste from CB"},
		["<leader>P"] = {"\"+P", desc = "Paste from CB before the cursor"},
		["<leader>s"] = [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
		["<leader>x"] = {"<cmd>silent !chmod +x %<CR>", desc = "Make the file executable"},

		["<leader>pc"] = {"<cmd>UserConfUpdate<CR>", desc = "Update User config"},
	},
	v = {
		-- Do NOT overwrite current buffer on paste
		["p"] = {"\"_dp"},
		["<leader>d"] = {"\"_d"},
		["<Del>"] = {"\"_d"},
		["<leader>y"] = {"\"+y"},
		["<leader>s"] = [[:s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
	}
}
