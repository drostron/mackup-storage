
-- consider splitting into lib and config files

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

function sizeAnchorSide(percentWidth, percentHeight, hSide, vSide)
  return function()
    local rw = percentWidth * 0.01
    local rh = percentHeight * 0.01
    local win = hs.window.focusedWindow()
    local sc = win:screen()
    local sf = sc:frame()
    local sff = sc:fullFrame()
    local wf = win:frame()

    win:setFrame({
      x = hSide == "l" and 0 or sff.w * (1 - rw),
      y = vSide ~= "b" and 0 or (sf.h * (1 - rh)) + (sff.h - sf.h),
      w = sff.w * rw,
      h = sf.h * rh
    })
  end
end

function halfWidthPartialHeight(percentHeight, hSide)
  local vSide = "t"

  return function()
    sizeAnchorSide(50, percentHeight, hSide, vSide)()

    vSide = vSide == "t" and "b" or "t"
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

bind({ "ctrl" }, "2", sizeAnchorSide(50, 100, "l"))
bind({ "ctrl", "shift" }, "2", sizeAnchorSide(50, 100, "r"))
bind({ "ctrl", "shift", "cmd" }, "2", sizeAnchorSide(64.2, 100, "r"))

bind({ "ctrl" }, "3", halfWidthPartialHeight(50, "l"))
bind({ "ctrl", "shift" }, "3", halfWidthPartialHeight(50, "r"))
bind({ "ctrl", "shift", "cmd" }, "3", sizeAnchorSide(75, 75, "l"))

bind({ "ctrl" }, "4", halfWidthPartialHeight(70, "l"))
bind({ "ctrl", "shift" }, "4", halfWidthPartialHeight(70, "r"))

bind({ "alt", "cmd" }, "delete", horizontalCenter)

bind({ "ctrl", "cmd" }, "1", resizeAndCenter(100))
bind({ "ctrl", "cmd" }, "2", resizeAndCenter(90))
bind({ "ctrl", "cmd" }, "3", resizeAndCenter(80))
bind({ "ctrl", "cmd" }, "4", resizeAndCenter(70))
bind({ "ctrl", "cmd" }, "5", resizeAndCenter(60))
bind({ "ctrl", "cmd" }, "6", resizeAndCenter(50))
bind({ "ctrl", "cmd" }, "7", resizeAndCenter(40))

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

hs.hotkey.bind({"ctrl", "cmd"}, "space", function()
  hs.alert.show("reloading hammerspoon")
  hs.reload()
end)
