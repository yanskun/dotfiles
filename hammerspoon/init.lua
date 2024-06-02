Alacritty = require("alacritty")

-- control window size
hs.window.animationDuration = 0
local units = {
  right50 = { x = 0.50, y = 0.00, w = 0.50, h = 1.00 },
  left50 = { x = 0.00, y = 0.00, w = 0.50, h = 1.00 },
  top50 = { x = 0.00, y = 0.00, w = 1.00, h = 0.50 },
  bot50 = { x = 0.00, y = 0.50, w = 1.00, h = 0.50 },
  maximum = { x = 0.00, y = 0.00, w = 1.00, h = 1.00 },
}
local mash = { "ctrl", "shift", "cmd" }
hs.hotkey.bind(mash, "right", function()
  hs.window.focusedWindow():move(units.right50, nil, true)
end)
hs.hotkey.bind(mash, "left", function()
  hs.window.focusedWindow():move(units.left50, nil, true)
end)
hs.hotkey.bind(mash, "up", function()
  hs.window.focusedWindow():move(units.top50, nil, true)
end)
hs.hotkey.bind(mash, "down", function()
  hs.window.focusedWindow():move(units.bot50, nil, true)
end)
hs.hotkey.bind(mash, "m", function()
  hs.window.focusedWindow():move(units.maximum, nil, true)
end)

-- toggle Alacritty opacity
hs.hotkey.bind({ "cmd" }, "u", function()
  local appName = "alacritty"
  local app = hs.application.find(appName)
  if app.isFrontmost(app) then
    hs.execute("toggle_opacity", true)
  end
end)

-- toggle Keycastr
hs.hotkey.bind({ "ctrl", "shift" }, "k", function()
  local appName = "KeyCastr"
  local app = hs.application.get(appName)

  if app == nil then
    hs.application.launchOrFocus(appName)
  else
    app:kill()
  end
end)

local screenWatcher = hs.screen.watcher.new(
  function()
    if not hs.fnutils.some(hs.screen.allScreens(), function(scr) return scr:name():find("Built%-in .*") end) then
      hs.execute("yabai --start-service", true)
    else
      hs.execute("yabai --stop-service", true)
    end
  end
)
-- screenWatcher:start()
