-- References
-- https://rakhesh.com/coding/using-hammerspoon-to-switch-apps/
-- https://rakhesh.com/coding/using-hammerspoon-to-switch-apps-part-2/

hs.window.animationDuration = 0

-- f16 is NL+a and bound to the prefix itself
local apps = {
    -- {"pad1", "Google Chrome"},
    {"f17", "Visual Studio Code"}, -- f17 is NL+s
    {"f18", "Kitty"}, -- f18 is NL+d
    -- f19 is NL+c and bound to Maccy
    {"f20", "Finder"}, -- f20 is NL+e
}

local function launchOrFocusOrRotate(app)
    local focusedWindow = hs.window.focusedWindow()
    -- Output of the above is an hs.window object

    -- I can get the application it belongs to via the :application() method
    -- See https://www.hammerspoon.org/docs/hs.window.html#application
    local focusedWindowApp = focusedWindow:application()
    -- This returns an hs.application object

    -- Get the name of this application; this isn't really useful fof us as launchOrFocus needs the app name on disk
    -- I do use it below, further on...
    local focusedWindowAppName = focusedWindowApp:name()

    -- This gives the path - /Applications/<application>.app
    local focusedWindowPath = focusedWindowApp:path()

    -- I need to extract <application> from that
    local appNameOnDisk = string.gsub(focusedWindowPath,"/Applications/", "")
    local appNameOnDisk = string.gsub(appNameOnDisk,".app", "")
    -- Finder has this as its path
    local appNameOnDisk = string.gsub(appNameOnDisk,"/System/Library/CoreServices/","")

    -- If already focused, try to find the next window
    if focusedWindow and appNameOnDisk == app then
        -- hs.application.get needs the name as per hs.application:name() and not the name on disk
        -- It can also take pid or bundle, but that doesn't help here
        -- Since I have the name already from above, I can use that though
        local appWindows = hs.application.get(focusedWindowAppName):allWindows()

        -- https://www.hammerspoon.org/docs/hs.application.html#allWindows
        -- A table of zero or more hs.window objects owned by the application. From the current space.

        if #appWindows > 0 then
            -- It seems that this list order changes after one window get focused,
            -- Let's directly bring the last one to focus every time
            -- https://www.hammerspoon.org/docs/hs.window.html#focus
            if app == "Finder" then
            -- If the app is Finder the window count returned is one more than the actual count, so I subtract
            appWindows[#appWindows-1]:focus()
            else
            appWindows[#appWindows]:focus()
            end
        else
            -- this should not happen, but just in case
            hs.application.launchOrFocus(app)
        end
    else -- if not focused
        hs.application.launchOrFocus(app)
    end
    end

for i, keyapp in ipairs(apps) do
    hs.hotkey.bind({}, keyapp[1], function()
        launchOrFocusOrRotate(keyapp[2])
    end)
end

switcher_space = hs.window.switcher.new(hs.window.filter.new():setCurrentSpace(true):setDefaultFilter{}) -- include minimized/hidden windows, current Space only

-- bind to hotkeys; WARNING: at least one modifier key is required!
hs.hotkey.bind('alt','tab','Next window',function()switcher_space:next()end)
hs.hotkey.bind('alt-shift','tab','Prev window',function()switcher_space:previous()end)

-- alternatively, call .nextWindow() or .previousWindow() directly (same as hs.window.switcher.new():next())
-- hs.hotkey.bind('alt','tab','Next window',hs.window.switcher.nextWindow)
-- you can also bind to `repeatFn` for faster traversing
-- hs.hotkey.bind('alt-shift','tab','Prev window',hs.window.switcher.previousWindow,nil,hs.window.switcher.previousWindow)
