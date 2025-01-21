local timer = require('hs.timer')
local eventtap = require('hs.eventtap')

-- src: https://github.com/asmagill/hs._asm.spaces
local spaces = require('hs.spaces')
local events = eventtap.event.types

local module = {}

local appName = 'Alacritty'

function MoveActiveScreen(app)
  local window = app:focusedWindow()

  local focused = spaces.focusedSpace()

  spaces.moveWindowToSpace(window:id(), focused)
  window:focus()
  hs.window.focusedWindow():move({ x = 0.00, y = 0.00, w = 1.00, h = 1.00 }, nil, true)
end

-- how quickly must the two single ctrl taps occur?
module.timeFrame = 1

-- what to do when the double tap of ctrl occurs
module.action = function()
  local app = hs.application.find(appName)

  if app == nil then
    hs.application.launchOrFocus(appName)
  elseif app:isFrontmost() then
    app:hide()
  else
    MoveActiveScreen(app)
  end
end

local timeFirstControl, firstDown, secondDown = 0, false, false

-- verify that no keyboard flags are being pressed
local noFlags = function(ev)
  local result = true
  for _, v in pairs(ev:getFlags()) do
    if v then
      result = false
      break
    end
  end
  return result
end

-- verify that *only* the ctrl key flag is being pressed
local onlyCtrl = function(ev)
  local result = ev:getFlags().ctrl
  for k, v in pairs(ev:getFlags()) do
    if k ~= 'ctrl' and v then
      result = false
      break
    end
  end
  return result
end

-- the actual workhorse

module.eventWatcher = eventtap
    .new({ events.flagsChanged, events.keyDown }, function(ev)
      -- if it's been too long; previous state doesn't matter
      if (timer.secondsSinceEpoch() - timeFirstControl) > module.timeFrame then
        timeFirstControl, firstDown, secondDown = 0, false, false
      end

      if ev:getType() == events.flagsChanged then
        if noFlags(ev) and firstDown and secondDown then -- ctrl up and we've seen two, so do action
          if module.action then
            module.action()
          end
          timeFirstControl, firstDown, secondDown = 0, false, false
        elseif onlyCtrl(ev) and not firstDown then -- ctrl down and it's a first
          firstDown = true
          timeFirstControl = timer.secondsSinceEpoch()
        elseif onlyCtrl(ev) and firstDown then -- ctrl down and it's the second
          secondDown = true
        elseif not noFlags(ev) then          -- otherwise reset and start over
          timeFirstControl, firstDown, secondDown = 0, false, false
        end
      else -- it was a key press, so not a lone ctrl char -- we don't care about it
        timeFirstControl, firstDown, secondDown = 0, false, false
      end
      return false
    end)
    :start()

-------------

-- toggle App opacity
local transparent = true
local hotkey = nil
local function enableAppHotkey()
  if not hotkey then
    hotkey = hs.hotkey.bind({ 'cmd' }, 'u', function()
      local app = hs.application.find(appName)
      if app.isFrontmost(app) then
        if transparent then
          transparent = false
        else
          transparent = true
        end
      end
    end)
  end
end
local function disabledAppHotkey()
  if hotkey then
    hotkey:disable()
    hotkey:delete()
    hotkey = nil
  end
end

module.toggleOpacityWacher = hs.application.watcher.new(function(targetAppName, eventType, appObject)
  if eventType == hs.application.watcher.activated then
    if targetAppName == appName then
      enableAppHotkey()
    else
      disabledAppHotkey()
    end
  end
end)

return module
