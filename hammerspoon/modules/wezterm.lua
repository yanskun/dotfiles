-- =========================
-- WezTerm Hotkey Window-ish toggle
-- Ctrl x2 to toggle
-- =========================

local APP_NAME = 'WezTerm'

-- -------------------------
-- Settings
-- -------------------------
local DOUBLE_TAP_THRESHOLD = 0.30

-- true: 今いる Space に WezTerm を移動
-- false: WezTerm がいる Space にジャンプ
local MOVE_WINDOW_TO_CURRENT_SPACE = true

-- -------------------------
-- Internal state
-- -------------------------
local lastTapAt = 0
local ctrlWasDown = false

local function now()
  return hs.timer.secondsSinceEpoch()
end

-- -------------------------
-- Helpers
-- -------------------------
local function frontmostIsFullscreen()
  local win = hs.window.frontmostWindow()
  return win and win:isFullScreen() or false
end

local function getMainWindow(app)
  local wins = app:allWindows()
  if not wins or #wins == 0 then
    return nil
  end

  for _, w in ipairs(wins) do
    if w:isStandard() then
      return w
    end
  end

  return wins[1]
end

local function windowIsInCurrentSpace(win)
  local screen = hs.screen.mainScreen()
  local currentSpace = hs.spaces.activeSpaceOnScreen(screen)
  if not currentSpace then
    return true
  end

  local spaces = hs.spaces.windowSpaces(win:id())
  if not spaces then
    return true
  end

  for _, sp in ipairs(spaces) do
    if sp == currentSpace then
      return true
    end
  end
  return false
end

local function moveWindowToCurrentSpace(win)
  local screen = hs.screen.mainScreen()
  local currentSpace = hs.spaces.activeSpaceOnScreen(screen)
  if not currentSpace then
    return false
  end

  return pcall(function()
    hs.spaces.moveWindowToSpace(win:id(), currentSpace)
  end)
end

local function gotoWindowSpace(win)
  local spaces = hs.spaces.windowSpaces(win:id())
  if not spaces or #spaces == 0 then
    return false
  end

  return pcall(function()
    hs.spaces.gotoSpace(spaces[1])
  end)
end

-- -------------------------
-- Core toggle logic
-- -------------------------
local function toggleWezTerm()
  local app = hs.application.find(APP_NAME)

  -- 起動してなければ起動
  if not app then
    hs.application.launchOrFocus(APP_NAME)
    return
  end

  -- 前面なら hide
  if app:isFrontmost() then
    app:hide()
    return
  end

  local win = getMainWindow(app)
  if not win then
    hs.application.launchOrFocus(APP_NAME)
    return
  end

  local isFullscreen = frontmostIsFullscreen()

  -- Space 跨ぎ処理
  if not windowIsInCurrentSpace(win) then
    if MOVE_WINDOW_TO_CURRENT_SPACE then
      local moved = moveWindowToCurrentSpace(win)
      if not moved then
        gotoWindowSpace(win)
      end
    else
      gotoWindowSpace(win)
    end
  end

  -- フォーカス処理
  if isFullscreen then
    hs.timer.doAfter(0.05, function()
      app:activate(true)
      win:raise()
      win:focus()
    end)
  else
    app:activate(true)
    win:raise()
    win:focus()
  end
end

-- -------------------------
-- Ctrl x2 detector
-- -------------------------
hs.eventtap
    .new({ hs.eventtap.event.types.flagsChanged }, function(e)
      local flags = e:getFlags()

      local onlyCtrl = flags.ctrl and not flags.cmd and not flags.alt and not flags.shift and not flags.fn

      if onlyCtrl and not ctrlWasDown then
        ctrlWasDown = true
        return false
      end

      if ctrlWasDown and not flags.ctrl then
        ctrlWasDown = false
        local t = now()

        if (t - lastTapAt) <= DOUBLE_TAP_THRESHOLD then
          lastTapAt = 0
          toggleWezTerm()
        else
          lastTapAt = t
        end
        return false
      end

      if flags.cmd or flags.alt or flags.shift then
        ctrlWasDown = false
        lastTapAt = 0
      end

      return false
    end)
    :start()
