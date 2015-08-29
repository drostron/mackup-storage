
-- consider splitting into lib and config files

hs.window.animationDuration = 0

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

        local currentWindows = app:visibleWindows()

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

        windows[1]:focus()
      end
    end
  end
end

appKeyMapping = {
  ["a"] = "Adium",
  ["c"] = "Google Chrome",
  ["d"] = "Gitter",
  ["e"] = "Slack",
  ["f"] = "Finder",
  ["g"] = "SourceTree",
  ["i"] = "iBooks",
  ["l"] = "Light Table",
  ["m"] = "Messages",
  ["p"] = "Preview",
  ["s"] = "Sublime Text 2",
  ["t"] = "iTerm",
  ["v"] = "IntelliJ IDEA",
  ["x"] = "Atom",
  ["y"] = "Twitter",
  ["r"] = "Rdio",
  ["b"] = "SoundCleod",
}

local bind = hs.hotkey.bind

for k, v in pairs(appKeyMapping) do
  f = focusApp(v)
  bind({"ctrl", "cmd"}, k, f())
  bind({"ctrl", "cmd", "shift"}, k, f(true))
end

-- check out hs.grid
-- keep an eye out for the sizeup extension https://github.com/Hammerspoon/hammerspoon/issues/154

function halfScreen(side)
  return function()
    local win = hs.window.focusedWindow()
    local sc = win:screen()
    local sf = sc:frame()
    local wf = win:frame()

    if side == "l" then
      win:setFrame({ x = 0, y = 0, w = sf.w / 2, h = sf.h })
    elseif side == "r" then
      win:setFrame({ x = sf.w - wf.w, y = 0, w = sf.w / 2, h = sf.h })
    end
  end
end

local halfPartial = (function()
  local i = 0
  local currentSide = "n"

  function halfPartial(x, yPercentage, nextSide)
    if (currentSide ~= nextSide) then
      i = 0
    end

    currentSide = nextSide

    hs.window.focusedWindow():moveToUnit(
      { x = x, y = yPercentage * 0.01 * i, w = 0.5, h = yPercentage * 0.01 })

    i = (i + 1) % 2
  end

  return {
    left50 = function() halfPartial(0, 50, "l") end,
    right50 = function() halfPartial(0.5, 50, "r") end,
    left70 = function() halfPartial(0, 70, "l") end,
    right70 = function() halfPartial(0.5, 70, "r") end,
  }
end)()

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
    local sf = sc:frame()
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
  toEdge("t")()

  local win = hs.window.focusedWindow()
  local sc = win:screen()
  local sf = sc:frame()
  local wf = win:frame()

  wf.x = (sf.w - wf.w) / 2

  win:setFrame(wf)
end

function resizeAndCenter(percentage)
  return function()
    local win = hs.window.focusedWindow()
    local sc = win:screen()
    local sf = sc:frame()
    local wf = win:frame()

    wf.w = sf.w * percentage * 0.01
    wf.h = sf.h
    wf.x = (sf.w - wf.w) / 2
    wf.y = 0
    win:setFrame(wf)
  end
end

bind({ "ctrl" }, "2", halfScreen("l"))
bind({ "ctrl", "shift" }, "2", halfScreen("r"))

bind({ "ctrl" }, "3", halfPartial.left50)
bind({ "ctrl", "shift" }, "3", halfPartial.right50)

bind({ "ctrl" }, "4", halfPartial.left70)
bind({ "ctrl", "shift" }, "4", halfPartial.right70)

bind({ "alt", "cmd" }, "delete", horizontalCenter)

bind({ "ctrl", "cmd" }, "1", resizeAndCenter(100))
bind({ "ctrl", "cmd" }, "2", resizeAndCenter(90))
bind({ "ctrl", "cmd" }, "3", resizeAndCenter(80))
bind({ "ctrl", "cmd" }, "4", resizeAndCenter(70))
bind({ "ctrl", "cmd" }, "5", resizeAndCenter(60))
bind({ "ctrl", "cmd" }, "6", resizeAndCenter(50))
bind({ "ctrl", "cmd" }, "7", resizeAndCenter(40))

local step = 80
local smallStep = 40

bind({ "ctrl", "cmd" }, "up", move(0, step))
bind({ "ctrl", "cmd" }, "down", move(0, -step))
bind({ "ctrl", "cmd" }, "left", move(step, 0))
bind({ "ctrl", "cmd" }, "right", move(-step, 0))

bind({ "ctrl", "cmd", "shift" }, "up", move(0, smallStep))
bind({ "ctrl", "cmd", "shift" }, "down", move(0, -smallStep))
bind({ "ctrl", "cmd", "shift" }, "left", move(smallStep, 0))
bind({ "ctrl", "cmd", "shift" }, "right", move(-smallStep, 0))

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

hs.hotkey.bind({"ctrl", "cmd"}, "space", function()
  hs.alert.show("reloading hammerspoon")
  hs.reload()
end)
