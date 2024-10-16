local spaces = require("hs.spaces")

local prefix = require("prefix")
local utils = require("utils")

hs.window.animationDuration = 0

----------------
-- Switch
----------------
-- hs.hints.hintChars = utils.strToTable('ASDFGQWERTZXCVB12345')
-- prefix.bind('', 'w', function() hs.hints.windowHints() end)

-- local switcher = hs.window.switcher.new(nil, {
--     fontName = ".AppleSystemUIFont",
--     textSize = 16,
--     textColor = { white = 0, alpha = 1 },
--     highlightColor = { white = 0.5, alpha = 0.3 },
--     backgroundColor = { white = 0.95, alpha = 0.9 },
--     titleBackgroundColor = { white = 0.95, alpha = 0 },
--     showThumbnails = false,
--     showSelectedThumbnail = false,
-- })

-- local function nextWindow()
--     switcher:next()
-- end

-- local function previousWindow()
--     switcher:previous()
-- end

-- hs.hotkey.bind('alt', 'tab', nextWindow, nil, nextWindow)
-- hs.hotkey.bind('alt-shift', 'tab', previousWindow, nil, previousWindow)

----------------
-- resize & move
----------------
local arrowKeys = {'h', 'j', 'k', 'l'}

-- prefix + h -> left half
-- prefix + j -> bottom half
-- prefix + k -> top half
-- prefix + l -> right half
-- prefix + hj -> bottom left quarter
-- prefix + hk -> top left quarter
-- prefix + jl -> top right quarter
-- prefix + kl -> top bottom quarter
-- prefix + lj -> top bottom quarter
-- prefix + jk -> center
-- prefix + hl -> full screen
local rectMap = {
    ['h'] = {0, 0, 0.5, 1},
    ['j'] = {0, 0.5, 1, 0.5},
    ['k'] = {0, 0, 1, 0.5},
    ['l'] = {0.5, 0, 0.5, 1},
    ['hj'] = {0, 0.5, 0.5, 0.5},
    ['hk'] = {0, 0, 0.5, 0.5},
    ['jl'] = {0.5, 0.5, 0.5, 0.5},
    ['kl'] = {0.5, 0, 0.5, 0.5},
    ['hl'] = {0, 0, 1, 1},
}
local wasPressed = {false, false, false, false}
local pressed = {false, false, false, false}

local function resizeWindow()
    for i = 1, #pressed do
        if pressed[i] then
            return
        end
    end

    local win = hs.window.focusedWindow()
    if win ~= nil then
        local keys = ''
        for i = 1, #wasPressed do
            if wasPressed[i] then
                keys = keys .. arrowKeys[i]
                wasPressed[i] = false
            end
        end
        local rect = rectMap[keys]
        local revert = utils.axHotfix(win)
        if rect ~= nil then
            win:move(rect)
        elseif keys == 'jk' then
            win:centerOnScreen()
        end
        revert()
    end
    prefix.exit()
end

for i = 1, #arrowKeys do
    local pressedFn = function()
        wasPressed[i] = true
        pressed[i] = true
    end
    local releasedFn = function()
        pressed[i] = false
        resizeWindow()
    end
    prefix.bindMultiple('', arrowKeys[i], pressedFn, releasedFn, nil)
end

-- prefix + ctrl-h -> left one third
-- prefix + ctrl-j -> left two thirds
-- prefix + ctrl-k -> right two thirds
-- prefix + ctrl-l -> right one third
local rectMapCtrl = {
    ['h'] = {0, 0, 1/3, 1},
    ['j'] = {0, 0, 2/3, 1},
    ['k'] = {1/3, 0, 2/3, 1},
    ['l'] = {2/3, 0, 1/3, 1},
}

for k, v in pairs(rectMapCtrl) do
    local fn = function()
        local win = hs.window.focusedWindow()
        if win ~= nil then
            local revert = utils.axHotfix(win)
            win:move(v)
            revert()
        end
    end
    prefix.bind('ctrl', k, fn)
end

-- prefix + shift-hjkl -> move window
local DX = {-1, 0, 0, 1}
local DY = {0, 1, -1, 0}
local DELTA = 20

for i = 1, 4 do
    local moveWin = function()
        local win = hs.window.focusedWindow()
        if win ~= nil then
            local p = win:topLeft()
            p.x = p.x + DX[i] * DELTA
            p.y = p.y + DY[i] * DELTA
            local release = utils.axHotfix(win)
            win:setTopLeft(p)
            release()
        end
    end
    local pressedFn = function()
        prefix.cancelTimeout()
        moveWin()
    end
    prefix.bindMultiple('shift', arrowKeys[i], pressedFn, nil, moveWin)
end

local function getScreenSpaceID(sp)
    local pri_screen = hs.screen.primaryScreen()
    local pri_screen_id = pri_screen:getUUID()
    local all_spaces = spaces.allSpaces()
    if sp <= #all_spaces[pri_screen_id] then
        return pri_screen_id, all_spaces[pri_screen_id][sp]
    else
        sp = sp - #all_spaces[pri_screen_id]
        -- only works for two spaces:
        for uuid, screen_spaces in pairs(all_spaces) do
            if uuid ~= pri_screen_id then
                return uuid, screen_spaces[sp]
            end
        end
    end
end

-- prefix + number -> move current window to space
local function MoveWindowToSpace(sp)
    prefix.exit()
    local win = hs.window.focusedWindow()      -- current window
    local screenID, spaceID = getScreenSpaceID(sp)
    print("moving window to space " .. spaceID)
    spaces.moveWindowToSpace(win:id(), spaceID)
    win:focus()  -- follow window to new space

    -- MacOS takes focus from us, get it fucking back. This may cease to
    -- be an issue after we choose to "Reduce motion" in
    -- System preferences -> accessibility -> display.
    -- cunha@20240409 it's still an issue
    hs.timer.usleep(400000)
    -- moveToScreen necessary after Sonoma 14.5 issue:
    -- https://github.com/Hammerspoon/hammerspoon/pull/3638#issuecomment-2209445157
    local release = utils.axHotfix(win)
    win:moveToScreen(screenID)
    release()
    win:focus()
end
for i = 1, 8 do
    prefix.bind('', tostring(i), function() MoveWindowToSpace(i) end)
end


-- prefix + ; -> move window to the next screen

local function getNextScreen(s)
    local all = hs.screen.allScreens()
    for i = 1, #all do
        if all[i] == s then
            return all[(i - 1 + 1) % #all + 1]
        end
    end
    return nil
end

local function moveToNextScreen()
    local win = hs.window.focusedWindow()
    if win ~= nil then
        local currentScreen = win:screen()
        local nextScreen = getNextScreen(currentScreen)
        if nextScreen then
            local release = utils.axHotfix()
            win:moveToScreen(nextScreen)
            release()
        end
    end
end

prefix.bind('', ';', moveToNextScreen)

-- prefix + - -> shrink window frame
-- prefix + = -> expand window frame

local function expandWin(ratio)
    local win = hs.window.focusedWindow()
    if win == nil then
        return
    end
    local frame = win:frame()
    local cx = frame.x + frame.w / 2
    local cy = frame.y + frame.h / 2
    local nw = frame.w * ratio
    local nh = frame.h * ratio
    local nx = cx - nw / 2
    local ny = cy - nh / 2
    local release = utils.axHotfix(win)
    win:setFrame(hs.geometry.rect(nx, ny, nw, nh))
    release()
end

prefix.bind('', '-', function() expandWin(0.9) end)
prefix.bind('', '=', function() expandWin(1.1) end)


-- prefix + cmd-hjkl -> expand window edges
-- prefix + cmd-shift-hjkl -> shrink window edges
--
local function expandEdge(edge, ratio)
    local win = hs.window.focusedWindow()
    if win == nil then
        return
    end
    local frame = win:frame()
    local x, y, w, h = frame.x, frame.y, frame.w, frame.h
    if edge == 'h' then
        w = frame.w * ratio
        x = frame.x + frame.w - w
    elseif edge == 'j' then
        h = frame.h * ratio
    elseif edge == 'k' then
        h = frame.h * ratio
        y = frame.y + frame.h - h
    elseif edge == 'l' then
        w = frame.w * ratio
    else
        return
    end
    local revert = utils.axHotfix(win)
    win:setFrame(hs.geometry.rect(x, y, w, h))
    revert()
end

local edges = {'h', 'j', 'k', 'l'}
local ratios = {0.9, 1.111111}

for i = 1, #edges do
    local edge = edges[i]
    for j = 1, #ratios do
        local mod = (ratios[j] > 1) and 'cmd' or 'cmd+shift'
        local fn = function() expandEdge(edge, ratios[j]) end
        local pressedFn = function()
            prefix.cancelTimeout()
            fn()
        end
        prefix.bindMultiple(mod, edge, pressedFn, nil, fn)
    end
end

local function getVisibleSpaces()
    local screens = hs.screen.allScreens()
    local visibleSpaces = {}
    for _, screen in pairs(screens) do
        local spaceId = hs.spaces.activeSpaceOnScreen(screen)
        visibleSpaces[spaceId] = screen
        -- print("Screen " .. hs.inspect(screen) .. " showing space " .. spaceId)
    end
    return visibleSpaces
end

local function windowIsInSpace(win, spaceId)
    -- return win:isStandard() and hs.spaces.windowSpaces(win)[1] == spaceId
    print("win ".. hs.inspect(win))
    print("windowSpaces " .. hs.inspect(hs.spaces.windowSpaces(win)))
    local wspaces = hs.spaces.windowSpaces(win)
    return #wspaces == 1 and wspaces[1] == spaceId
end

local function focusOrRotateWindowsInSpace(i)
    local _screenId, targetSpaceId = getScreenSpaceID(i)
    print("target space " .. targetSpaceId)

    -- Keeping this block here as documentation for what I have tried.
    -- The eventtap approach may not be entirely necessary, but I was
    -- getting some weird behavior where a window in a non-visible space
    -- would not get picked up by the filter below.
    local visibleSpaces = getVisibleSpaces()
    if visibleSpaces[targetSpaceId] == nil then
        print("visible spaces is nil")
        -- Use MissionControl directly to avoid the animation in gotoSpace.
        -- This requires that you configure the shortcuts in
        -- System preferences -> keyboard -> shortcuts -> Mission Control.
        hs.eventtap.keyStroke('cmd', 'pad'..i)
        return
        -- hs.spaces.gotoSpace(targetSpaceId)
        -- print("moving to space " .. targetSpaceId)

        -- Consider enabling "Reduce motion" in
        -- System preferences -> accessibility -> display.
        -- If you don't, you may need the following delay for
        -- the animation to play out:
        -- hs.timer.usleep(250000)
    end

    local wf = hs.window.filter.new(function(win)
        return windowIsInSpace(win, targetSpaceId) and win:isVisible()
    end)
    local fwin = wf:getWindows()
    print("hs.window.filter: " .. hs.inspect(fwin))

    -- this is a test following from the issue below to see if we can reliably
    -- iterate over windows:
    -- https://github.com/Hammerspoon/hammerspoon/issues/3509
    local allwin = hs.window.allWindows()
    local newwin = hs.fnutils.filter(allwin, function(win)
        return windowIsInSpace(win, targetSpaceId) and win:isVisible() and not hs.fnutils.contains(fwin, win)
    end)

    if #newwin ~= 0 then
        print("missing windows: " .. hs.inspect(newwin))
        print("focusing: " .. hs.inspect(newwin[1]))
        newwin[1]:focus()
        return
    end

    if #fwin == 0 then
        hs.eventtap.keyStroke('cmd', 'pad'..i)
        return
    end

    local focusedSpaceId = hs.spaces.focusedSpace()
    print("focused space " .. focusedSpaceId)
    if focusedSpaceId ~= targetSpaceId then
        -- select first window
        print("selecting window 1")
        -- the following is a hack to prevent some special
        -- windows like the Hammerspoon console
        -- from sitting on the top of the queue
        -- if #fwin >= 2 then
        --     fwin[2]:focus()
        -- end
        fwin[1]:focus()
        -- print("selecting space " .. i)
        -- hs.eventtap.keyStroke('cmd', 'pad'..i)
        -- return
    else
        -- select last window
        print("selecting window " .. #fwin)
        fwin[#fwin]:focus()
    end
end

for i = 1, 8 do
    hs.hotkey.bind({}, 'pad'..i, function()
        focusOrRotateWindowsInSpace(i)
    end)
end
