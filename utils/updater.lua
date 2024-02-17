return{
  update = function()
    local output = io.popen("cd "..vim.fn.stdpath("config").."/lua/user && git fetch && git pull"):read("a")
    require("notify")(output, "info")
  end
}
