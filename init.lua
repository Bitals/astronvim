return {
	colorscheme = "catppuccin",

	vim.api.nvim_create_augroup('AutoRestore', {}),

	vim.api.nvim_create_autocmd("VimEnter", {
		pattern = "*",
		group = 'AutoRestore',
		once = true,
		callback = function(_)
			-- Load last closed session if launched from ~ with no arguments
			local stargs = vim.fn.argc()
			local vcwd = vim.fn.getcwd()
			local homedir = os.getenv("HOME")
			if (stargs == 0 and vcwd == homedir) then
				-- Skip if another instance is already running
				local nvims = io.popen("pgrep -x nvim|wc -l"):read("n")
				-- Every instance spawns 2 processes IDK why
				if nvims > 2 then
					-- require("alpha").start(false)
					-- vim.cmd.Neotree('toggle')
					return
				else
					vim.cmd.SessionManager('load_last_session')
				end
		-- Load expliticly specified non-~ directory session if it exists
			elseif (stargs == 0 and vcwd ~= homedir) then
				if require('session_manager.config').dir_to_session_filename(vcwd):exists() then
					vim.cmd.SessionManager('load_current_dir_session')
				else
					-- Just open neo-tree if it doesn't
					vim.cmd.Neotree('toggle')
					-- vim.cmd.wincmd "p"
				end
			end
		end,
	}),

	-- Open neo-tree upon session load because I'm a child
	vim.api.nvim_create_autocmd({ 'User' }, {
		pattern = "SessionLoadPost",
		group = 'AutoRestore',
		callback = function()
			vim.cmd.Neotree('toggle')
			vim.cmd.wincmd "p"
		end,
	}),

	-- Auto save session
	-- local function is_neotree_open()
	--	 for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
	--		 if vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(win), 'ft') == 'neo-tree' then
	--			 return true
	--		 end
	--	 end
	--	 return false
	-- end,

	vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
		callback = function()
			-- Don't save at home
			if vim.fn.getcwd() == os.getenv("HOME") then return end
			-- local neotreeOpen = is_neotree_open()
			-- if ( neotreeOpen == true ) then vim.cmd.Neotree('toggle') end
			for _, buf in ipairs(vim.api.nvim_list_bufs()) do
				-- Don't save while there's any 'nofile' buffer open.
				local bufType = vim.api.nvim_get_option_value("buftype", { buf = buf })
				-- local fileType = vim.api.nvim_get_option_value("filetype", { buf= buf })
				if ((bufType == 'nofile') --[[ and not ( fileType	== 'neo-tree') ]]) then
					return
				end
			end
			vim.cmd.SessionManager('save_current_session')
			-- if ( neotreeOpen == true ) then vim.cmd.Neotree('toggle') end
		end
	}),

	-- vim.api.nvim_create_user_command(
	--	 "NotifyOS",
	--	 function(opts)
	--			 return require("user.utils.notifier").notify(opts)
	--	 end,
	--	 {
	--		 nargs = "*",
	--		 desc = "Send desktop notification",
	--		 bang = true
	--	 }
	-- ),
	-- vim.api.nvim_create_user_command(
	--	 "TestF",
	--	 function()
	--		 local i = "fgdgvgf"
	--		 return tostring("kljugb")
	--		 -- return i
	--		 -- print("icfobyhb")
	--	 end,
	-- {}),
	-- require("astronvim.utils").notify(require("user.utils.notifier").notify{"test", "352"}),
	-- require("astronvim.utils").notify("Outsider:	"..vim.cmd.NotifyOS("test")),

	vim.api.nvim_create_user_command(
		"UserConfUpdate",
		function()
			require("user.utils.updater").update() end,
		{ desc = "Update User config" }
	),

	lsp = {
		formatting = {
			format_on_save = {
				enabled = false
			},
		},
	},


	-- Overwiting AstroNvim default commands to use desktop notifications

}
