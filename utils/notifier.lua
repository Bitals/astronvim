return{
  notify = function(opts)
    local content = opts.fargs[1]
    local replace = opts.fargs[2]
    if (replace == nil) then
      replace = ""
    else
      replace = tostring("-r "..replace)
    end
    require("astronvim.utils").notify("Replacer: "..replace)
    local id = tostring(io.popen("notify-send -t 10000 -a Neovim -i nvim -e -p \'"..content.."\' "..replace):read("a"))
    require("astronvim.utils").notify("Insider: "..id)
    return id
  end
}
