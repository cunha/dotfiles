local module = {}

function module.tempNotify(timeout, notif)
    notif:send()
    hs.timer.doAfter(timeout, function() notif:withdraw() end)
end

function module.splitStr(str, sep)
    if sep == nil then
        sep = "%s"
    end
    local t = {}
    i=1
    for str in string.gmatch(str, "([^"..sep.."]+)") do
        t[i] = str
        i = i + 1
    end
    return t
end

function module.strToTable(str)
    local t = {}
    for i = 1, #str do
        t[i] = str:sub(i, i)
    end
    return t
end


-- https://github.com/Hammerspoon/hammerspoon/issues/3224
-- Firefox sets some AX accessibility extension that breaks window management.
-- This hack disables the AX accessibility and then re-enables it
function module.axHotfix(win)
  if not win then win = hs.window.frontmostWindow() end

  local axApp = hs.axuielement.applicationElement(win:application())
  local wasEnhanced = axApp.AXEnhancedUserInterface
  if wasEnhanced then
    axApp.AXEnhancedUserInterface = false
  end

  return function()
    if wasEnhanced then
      axApp.AXEnhancedUserInterface = true
    end
  end
end

function module.withAxHotfix(fn, position)
  if not position then position = 1 end
  return function(...)
    local args = {...}
    local revert = module.axHotfix(args[position])
    fn(...)
    revert()
  end
end

return module
