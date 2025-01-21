-- see: https://github.com/Hammerspoon/hammerspoon/pull/3638

Alacritty = require('alacritty')
Alacritty.toggleOpacityWacher:start()

-- toggle Keycastr
hs.hotkey.bind({ 'ctrl', 'shift' }, 'k', function()
  local appName = 'KeyCastr'
  local app = hs.application.get(appName)

  if app == nil then
    hs.application.launchOrFocus(appName)
  else
    app:kill()
  end
end)

local screenWatcher = hs.screen.watcher.new(function()
  if not hs.fnutils.some(hs.screen.allScreens(), function(scr)
        return scr:name():find('Built%-in .*')
      end) then
    hs.execute('yabai --start-service', true)
  else
    hs.execute('yabai --stop-service', true)
  end
end)
-- screenWatcher:start()
