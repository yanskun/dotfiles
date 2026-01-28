local APP_NAME = 'Ghostty'
local lastCtrlPress = 0
local ctrlTapInterval = 0.4

local function toggleApp()
  local app = hs.application.get(APP_NAME)
  local currentScreen = hs.screen.mainScreen()

  -- 1. アプリ自体が起動していない
  if not app then
    hs.application.launchOrFocus(APP_NAME)
    return
  end

  -- 全ウィンドウ取得（Ghosttyは複数の場合があるため）
  local windows = app:allWindows()
  local mainWin = app:mainWindow() or windows[1]

  -- 2. プロセスはあるがウィンドウがない場合
  if not mainWin then
    app:activate()
    -- 少し待ってからウィンドウが生成されるのを期待するか、再起動を促す
    return
  end

  -- 判定フラグ
  local isAppActive = app:isFrontmost()
  local isOnCurrentScreen = (mainWin:screen() == currentScreen)
  local isVisible = mainWin:isVisible()

  -- 【トグルロジック】
  if isAppActive and isVisible and isOnCurrentScreen then
    -- ケースA: 今の画面で最前面にいる -> 隠す
    app:hide()
  else
    -- ケースB: 別の画面にいる、または隠れている -> 今の画面に召還する

    -- 一旦アプリの隠し状態を解除
    if app:isHidden() then
      app:unhide()
    end

    -- 現在のスクリーンの枠に合わせて座標を計算
    local sFrame = currentScreen:frame()
    local wFrame = mainWin:frame()

    -- 座標を現在のスクリーン内に書き換え
    wFrame.x = sFrame.x + (sFrame.w - wFrame.w) / 2
    wFrame.y = sFrame.y + (sFrame.h - wFrame.h) / 2

    -- [重要] 移動 -> 表示 -> フォーカスの順序を厳格に
    mainWin:setFrame(wFrame, 0) -- 瞬時に移動
    app:activate()              -- アプリをアクティブ化
    mainWin:focus()             -- ウィンドウにフォーカス
    mainWin:raise()             -- 最前面へ引き上げ
  end
end

-- Ctrl 2回押しのイベント監視
local ctrlTapWatcher = hs.eventtap
    .new({ hs.eventtap.event.types.flagsChanged }, function(event)
      local flags = event:getFlags()
      if flags.ctrl and not (flags.shift or flags.cmd or flags.alt) then
        local now = hs.timer.secondsSinceEpoch()
        if now - lastCtrlPress < ctrlTapInterval then
          toggleApp()
          lastCtrlPress = 0
        else
          lastCtrlPress = now
        end
      end
      return false
    end)
    :start()
