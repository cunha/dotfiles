local module = {}

local bindings_string = "Prefix Mode\n" ..
    "d       Toggle Hammerspoon console\n" ..
    "r       Reload config\n" ..
    "\n" ..
    "v       Hard paste clipboard\n" ..
    "\n" ..
    "#       Move window to space\n" ..
    ";       Move window to next screen\n" ..
    "-       Shrink window\n"..
    "+       Expand window\n"..
    "\n" ..
    "hjkl    place window (hl to maxizmize)\n" ..
    "        ctrl+ to place window and make smaller\n" ..
    "        shift+ to move window from current position\n" ..
    "        cmd+ expand window edges\n" ..
    "        cmd+shift+ shrink window edges\n"

local TIMEOUT = 5

local modal = hs.hotkey.modal.new({}, 'f16') -- NL+a is f16

function modal:entered()
    modal.alertId = hs.alert.show("Prefix Mode", 9999)
    modal.timer = hs.timer.doAfter(TIMEOUT, function() modal:exit() end)
end

function modal:exited()
    if modal.alertId then
        hs.alert.closeSpecific(modal.alertId)
    end
    module.cancelTimeout()
end

function module.exit()
    modal:exit()
end

function module.cancelTimeout()
    if modal.timer then
        modal.timer:stop()
    end
end

function module.bind(mod, key, fn)
    modal:bind(mod, key, nil, function() fn(); module.exit() end)
end

function module.bindMultiple(mod, key, pressedFn, releasedFn, repeatFn)
    modal:bind(mod, key, pressedFn, releasedFn, repeatFn)
end

module.bind('', 'escape', module.exit)
-- module.bind({'ctrl'}, '`', module.exit)

module.bind('', 'd', hs.toggleConsole)
module.bind('', 'r', hs.reload)

module.bind('', 'v', function() hs.eventtap.keyStrokes(hs.pasteboard.getContents()) end)

module.bind('', 'a', function() hs.alert.showWithImage(bindings_string, nil, { textFont = "JetBrains Mono" }, 5) end)

return module
