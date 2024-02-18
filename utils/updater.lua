return{
  update = function()
    -- local testvar = tostring(vim.cmd.TestF())
    -- require("astronvim.utils").notify("Grabage: "..testvar)
    local startMessage = "Checking for User configuration updates"
    local notificationId = vim.cmd.NotifyOS(startMessage, nil)
    if (notificationId == nil) then
      notificationId = ""
    else
      notificationId = "fuckup"
    end
    require("astronvim.utils").notify("Outsider: "..notificationId)
    if notificationId == "fuckup" then notificationId = "352" end
    local output = io.popen("cd "..vim.fn.stdpath("config").."/lua/user && git fetch && git pull"):read("a")
    -- require("notify")(io.popen("cd "..vim.fn.stdpath("config").."/lua/user && git fetch && git pull"):read("a"), "info")
    -- os.execute("notify-send -t 10000 -a Neovim -i nvim -e -r "..notificationId.." -p \'"..output.."\'")
    vim.cmd.NotifyOS(output, notificationId)
  end
}
