
-- consider splitting into lib and config files

hs.alert.show("hammerspoon loading...")

hs.window.animationDuration = 0

local step = 100
local smallStep = 50

-- a touch long
function focusApp(name)
  local windows = {}
  return function(reverseRotate)
    return function()
      local currentlyActive = hs.application.frontmostApplication()

      local app = hs.appfinder.appFromName(name)

      local rotate = next(windows) == nil or currentlyActive == app

      if app then
        app:activate()

        -- filter currentWindows on non-empty titles per Chrome (haven't yet investigated)
        local currentWindows = hs.fnutils.filter(
          app:visibleWindows(),
          function(i) return i:title() ~= "" end)

        for i, v in pairs(currentWindows) do; hs.printf(v:title()); end
        hs.printf("")

        -- prune windows
        for i, v in pairs(windows) do
          if not hs.fnutils.find(currentWindows, function(i) return i == v end) then
            windows[i] = nil
          end
        end

        -- add missing windows
        for _, v in pairs(currentWindows) do
          if not hs.fnutils.find(windows, function(i) return i == v end) then
            table.insert(windows, 1, v)
          end
        end

        if rotate then
          if reverseRotate then
            w = table.remove(windows)
            table.insert(windows, 1, w)
          else
            table.insert(windows, table.remove(windows, 1))
          end
        end

        if windows[1] then
          windows[1]:focus()
        end
      end
    end
  end
end

appKeyMapping = {
  ["a"] = "emacs",
  ["b"] = "SoundCleod",
  -- ["c"] = "Google Chrome",
  ["c"] = "Firefox",
  ["d"] = "Signal",
  ["e"] = "Gitter",
  ["g"] = "Sourcetree",
  ["i"] = "iBooks",
  ["l"] = "Light Table",
  ["m"] = "Messages",
  ["p"] = "Preview",
  ["r"] = "Spotify",
  ["s"] = "Slack",
  ["t"] = "iTerm2",
  ["v"] = "Activity Monitor",
  ["x"] = "Discord",
  ["y"] = "Twitter",
  ["z"] = "LimeChat",
}

local bind = hs.hotkey.bind

for k, v in pairs(appKeyMapping) do
  f = focusApp(v)
  bind({"ctrl", "cmd"}, k, f())
  bind({"ctrl", "cmd", "shift"}, k, f(true))
end

bind({"ctrl", "cmd", "shift"}, "f", focusApp("Finder")())


-- check out hs.grid
-- keep an eye out for the sizeup extension https://github.com/Hammerspoon/hammerspoon/issues/154

function sizeAnchorSide(percentWidth, percentHeight, hSide, vSide)
  return function()
    local rw = percentWidth * 0.01
    local rh = percentHeight * 0.01
    local win = hs.window.focusedWindow()

    win:move(hs.geometry.new({
      x = hSide == "l" and 0 or 1 - rw,
      y = vSide ~= "b" and 0 or 1 - rh,
      w = rw,
      h = rh
    }))
  end
end

function halfWidthPartialHeight(percentHeight, hSide, vSide)
  local _vSide = "t"

  return function()
    sizeAnchorSide(50, percentHeight, hSide, vSide or _vSide)()

    _vSide = _vSide == "t" and "b" or "t"
  end
end

function move(xd, yd)
  return function()
    local win = hs.window.focusedWindow()
    local f = win:frame()

    f.x = f.x - xd
    f.y = f.y - yd
    win:setFrame(f)
  end
end

function resize(xd, yd)
  return function()
    local win = hs.window.focusedWindow()
    local f = win:frame()

    f.w = f.w + xd
    f.h = f.h + yd
    win:setFrame(f)
  end
end

function resizeReverseAnchor(xd, yd)
  return function()
    local win = hs.window.focusedWindow()
    local f = win:frame()

    f.w = f.w + xd
    f.x = f.x - xd
    f.h = f.h + yd
    f.y = f.y - yd
    win:setFrame(f)
  end
end

function toEdge(e)
  return function()
    local win = hs.window.focusedWindow()
    local sc = win:screen()
    local sf = sc:fullFrame()
    local wf = win:frame()

    if e == "t" then
      wf.y = 0
    elseif e == "b" then
      wf.y = sf.h - wf.h
    elseif e == "l" then
      wf.x = 0
    elseif e == "r" then
      wf.x = sf.w - wf.w
    end

    win:setFrame(wf)
  end
end

local horizontalCenter = function()
  local win = hs.window.focusedWindow()
  local sc = win:screen()
  local sf = sc:frame()
  local wf = win:frame()

  win:move(hs.geometry.new({
    x = (1 - (wf.w / sf.w)) / 2,
    y = 0,
    w = wf.w / sf.w,
    h = wf.h / sf.h
  }))
end

function resizeAndCenter(percentage)
  return function()
    local win = hs.window.focusedWindow()
    local wp = percentage * 0.01

    win:move(hs.geometry.new({
      x = (1 - wp) / 2,
      y = 0,
      w = wp,
      h = 1.0
    }))
  end
end

function moveNorth()
  local win = hs.window.focusedWindow()
  pcall(function () win:moveOneScreenNorth() end)
end

function moveSouth()
  local win = hs.window.focusedWindow()
  pcall(function () win:moveOneScreenSouth() end)
end

bind({ "ctrl" }, ",", sizeAnchorSide(50, 100, "l"))
bind({ "ctrl" }, ".", sizeAnchorSide(50, 100, "r"))

-- bind({ "ctrl", "shift", "cmd" }, "1", sizeAnchorSide(80, 100, "r"))
-- bind({ "ctrl", "shift", "cmd" }, "2", sizeAnchorSide(64.8, 100, "r"))
-- bind({ "ctrl", "shift", "cmd" }, "3", function() sizeAnchorSide(75, 70)(); horizontalCenter() end)
bind({ "ctrl", "shift", "cmd" }, "5", sizeAnchorSide(78, 78, "l"))
bind({ "ctrl", "shift", "cmd" }, "6", sizeAnchorSide(56, 78, "r"))
bind({ "ctrl", "shift", "cmd" }, "7", sizeAnchorSide(42.0, 100, "l"))
bind({ "ctrl", "shift", "cmd" }, "8", sizeAnchorSide(58.1, 100, "r"))

bind({ "alt", "cmd" }, "delete", horizontalCenter)

bind({ "ctrl", "shift" }, "1", resizeAndCenter(100))
bind({ "ctrl", "shift" }, "2", resizeAndCenter(90))
bind({ "ctrl", "shift" }, "3", resizeAndCenter(80))
bind({ "ctrl", "shift" }, "4", resizeAndCenter(70))
bind({ "ctrl", "shift" }, "5", resizeAndCenter(60))
bind({ "ctrl", "shift" }, "6", resizeAndCenter(50))
bind({ "ctrl", "shift" }, "7", resizeAndCenter(40))

bind({ "cmd" }, "pageUp", move(0, step))
bind({ "cmd" }, "pageDown", move(0, -step))
bind({ "cmd" }, "home", move(step, 0))
bind({ "cmd" }, "end", move(-step, 0))

bind({ "cmd", "shift" }, "pageUp", move(0, smallStep))
bind({ "cmd", "shift" }, "pageDown", move(0, -smallStep))
bind({ "cmd", "shift" }, "home", move(smallStep, 0))
bind({ "cmd", "shift" }, "end", move(-smallStep, 0))

bind({ "ctrl", "cmd" }, "pageUp", toEdge("t"))
bind({ "ctrl", "cmd" }, "pageDown", toEdge("b"))
bind({ "ctrl", "cmd" }, "home", toEdge("l"))
bind({ "ctrl", "cmd" }, "end", toEdge("r"))

bind({ "ctrl", "alt", "cmd" }, "up", resize(0, -step))
bind({ "ctrl", "alt", "cmd" }, "down", resize(0, step))
bind({ "ctrl", "alt", "cmd" }, "left", resize(-step, 0))
bind({ "ctrl", "alt", "cmd" }, "right", resize(step, 0))

bind({ "ctrl", "alt", "cmd", "shift" }, "up", resize(0, -smallStep))
bind({ "ctrl", "alt", "cmd", "shift" }, "down", resize(0, smallStep))
bind({ "ctrl", "alt", "cmd", "shift" }, "left", resize(-smallStep, 0))
bind({ "ctrl", "alt", "cmd", "shift" }, "right", resize(smallStep, 0))

bind({ "ctrl", "alt", "cmd" }, "pageUp", resizeReverseAnchor(0, -step))
bind({ "ctrl", "alt", "cmd" }, "pageDown", resizeReverseAnchor(0, step))
bind({ "ctrl", "alt", "cmd" }, "end", resizeReverseAnchor(-step, 0))
bind({ "ctrl", "alt", "cmd" }, "home", resizeReverseAnchor(step, 0))

bind({ "ctrl", "alt", "cmd", "shift" }, "pageUp", resizeReverseAnchor(0, -smallStep))
bind({ "ctrl", "alt", "cmd", "shift" }, "pageDown", resizeReverseAnchor(0, smallStep))
bind({ "ctrl", "alt", "cmd", "shift" }, "end", resizeReverseAnchor(-smallStep, 0))
bind({ "ctrl", "alt", "cmd", "shift" }, "home", resizeReverseAnchor(smallStep, 0))

bind({ "ctrl", "alt" }, "pageUp", moveNorth)
bind({ "ctrl", "alt" }, "pageDown", moveSouth)

bind({"ctrl", "cmd", "shift" }, "space", function()
  hs.reload()
end)

------------------------------
-- Remap a keybinding to F1 for Firefox's show/hide Tree Style Tab
--
-- TODO refine to be application specific
--
-- From https://stackoverflow.com/questions/43383348/remap-apostrophe-to-other-keys-using-hammerspoon

local function keyCode(key, modifiers)
  modifiers = modifiers or {}
  return function()
    hs.eventtap.event.newKeyEvent(modifiers, string.lower(key), true):post()
    hs.timer.usleep(100)
    hs.eventtap.event.newKeyEvent(modifiers, string.lower(key), false):post()
  end
end

local function remapKey(modifiers, key, keyCode)
  hs.hotkey.bind(modifiers, key, keyCode, nil, keyCode)
end

remapKey({"cmd", "shift"}, "e", keyCode("F1", {}))

------------------------------

-- OS wide

remapKey({"ctrl"}, "g", keyCode("escape", {}))

------------------------------
