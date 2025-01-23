erion = erion or {}
erion.gui = erion.gui or {}
erion.gui.main = erion.gui.main or {}
erion.gui.main.handlers = erion.gui.main.handlers or {}

local gui = erion.gui
local main = gui.main
local evHandlers = erion.gui.main.handlers

main.boot = function()
  debugc("main: boot")
  createBuffer('MainBuffer')
  setWindowWrap('MainBuffer', 1000)
  
  erion.sys.killHandlers(evHandlers)
  evHandlers.onInit = registerAnonymousEventHandler('erion.sys.init', gui.main.init, true)
  evHandlers.onShutdown = registerAnonymousEventHandler('erion.sys.shutdown', gui.main.shutdown, true)
end

function main.shutdown()
  erion.sys.killHandlers(evHandlers)
end

function main.init()
  evHandlers.onResized = registerAnonymousEventHandler(
    "AdjustableContainerRepositionFinish", function (ev, containerName)
      debugc('main: resized - ' .. containerName)

      main.reWrap()

    end)

  evHandlers.onReflow = registerAnonymousEventHandler('erion.sys.reflow', main.reWrap)
  evHandlers.onCapture = registerAnonymousEventHandler('erion.main.captured', function (ev, lineCount, spaces)
    main.purge(lineCount)
  end)
end

function main.purge(lineCount, spaces)
  debugc('main: purge - ' .. lineCount)
  if lineCount <= 0 then
    return
  end
  moveCursorEnd('MainBuffer')
  moveCursorUp('MainBuffer', 1)
  deleteLine('MainBuffer')
  
  if spaces then
    main.compactSpaces('main', spaces)
    main.compactSpaces('MainBuffer', spaces)
  end
end

function main.compactSpaces(buffer, spaces)
  moveCursorEnd(buffer)
  for i = 1, spaces do
    moveCursorUp(buffer, 1)
    if getCurrentLine(buffer) ~= '' then
      return
    end
  end
  moveCursorUp(buffer, 1)
  while getCurrentLine(buffer) == '' do
    deleteLine(buffer)
    moveCursorUp(buffer, 1)
  end
end

function main.pruneLines(buffer, lineCount)
  moveCursor(buffer, 0, getLastLineNumber(buffer) - lineCount)
  for i = 1, lineCount do
    deleteLine(buffer)
  end

  moveCursorEnd(buffer)
  selectCurrentLine("MainBuffer")
  deleteLine("MainBuffer")
end

function main.reWrap()
  local columns = getColumnCount('main')
  if columns < 65 then 
    columns = 65
  end
  clearWindow('main')
  setWindowWrap('main', columns - 1)

  local lines = getLastLineNumber("MainBuffer")
  for i = 0, lines-1, 1 do
    moveCursor("MainBuffer", 0, i)
    selectCurrentLine("MainBuffer")
    copy("MainBuffer")
    appendBuffer('main')
  end
end

evHandlers.onBoot = registerAnonymousEventHandler("erion.sys.boot", gui.main.boot, true)
