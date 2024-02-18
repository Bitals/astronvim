return{
  notify = function(opts)
    local args = ""
    local content = string.gsub(opts[1], "\n", "")
    local replace = opts[2]
    if (replace == nil) then
      replace = ""
    else
      replace = "-r "..replace
      args = args..replace
    end
    local lifetime = opts[3]
    if (lifetime == nil) then
      lifetime = ""
    else
      lifetime = "-t "..lifetime
      args = args.." "..lifetime
    end
    -- local args = replace.." "..lifetime
    -- print(args)
    local argsN = string.gsub(args, "\n", "")
    -- print(argsN)
    local command = "notify-send "..argsN.." -a Neovim -i nvim -e -p \'"..content.."\'"
    print(command)
    local id = tostring(io.popen("notify-send "..argsN.." -a Neovim -i nvim -e -p \'"..content.."\'"):read("a"))
    -- print(id)
    return id
    -- return "1337"
  end
}
