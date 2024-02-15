return {
  colorscheme = "catppuccin",

  vim.api.nvim_create_augroup('AutoRestore', {}),

  vim.api.nvim_create_autocmd("VimEnter", {
    pattern = "*",
    group = 'AutoRestore',
    once = true,
    callback = function(_)
      local stargs = vim.fn.argc()
      local vcwd = vim.fn.getcwd()
      local homedir = os.getenv( "HOME" )
      if ( stargs == 0 and vcwd == homedir ) then
        local nvims = tonumber(io.popen("pgrep -x nvim|wc -l"):read("*a"))
        if nvims>2 then
            -- require("alpha").start(false)
            -- vim.cmd.Neotree('toggle')
            return
        else
          vim.cmd.SessionManager('load_last_session')
        end
      elseif ( stargs == 0 and vcwd ~= homedir ) then
        local vsession = require('session_manager.config').dir_to_session_filename(vcwd)
        if vsession:exists() then
          vim.cmd.SessionManager('load_current_dir_session')
        else
          vim.cmd.Neotree('toggle')
          -- vim.cmd.wincmd "p"
        end
      end
   end,
  }),

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
  --   for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
  --     if vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(win), 'ft') == 'neo-tree' then
  --       return true
  --     end
  --   end
  --   return false
  -- end,

  vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
    callback = function ()
      -- Don't save at home
      if vim.fn.getcwd() == os.getenv( "HOME" ) then return end
      -- local neotreeOpen = is_neotree_open()
      -- if ( neotreeOpen == true ) then vim.cmd.Neotree('toggle') end
      for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        -- Don't save while there's any 'nofile' buffer open.
        local bufType = vim.api.nvim_get_option_value("buftype", { buf = buf })
        -- local fileType = vim.api.nvim_get_option_value("filetype", { buf= buf })
        -- require("astronvim.utils").notify(
        --   ("buf: "..buf.."buftype: "..bufType.."filetype: "..fileType),
        --   vim.log.levels.INFO
        --   )
        if ( ( bufType  == 'nofile') --[[ and not ( fileType  == 'neo-tree') ]] ) then
          return
        end
      end
      vim.cmd.SessionManager('save_current_session')
      -- if ( neotreeOpen == true ) then vim.cmd.Neotree('toggle') end
    end
  }),


  lsp = {
    formatting = {
      format_on_save = {
        enabled = false
      }
    }
  },
}
