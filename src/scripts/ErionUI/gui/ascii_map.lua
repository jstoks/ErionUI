erion = erion or {}
erion.gui = erion.gui or {}
erion.gui.asciiMap = erion.gui.asciiMap or {}
erion.gui.asciiMap.handlers = erion.gui.asciiMap.handlers or {}

local gui = erion.gui
local asciiMap = gui.asciiMap
local evHandlers = asciiMap.handlers

function asciiMap.boot()
  debugc('asciiMapt: boot')
  erion.sys.killHandlers(evHandlers)
  evHandlers.onInit = registerAnonymousEventHandler('erion.sys.init', asciiMap.init, true)
end

function asciiMap.init()
  asciiMap.console = Geyser.MiniConsole:new({
    name = "MapConsole",
    x='90px', y="100%-340px",
    width="11c", height="11c", 
    autoWrap = false,
    scrollBar = false,
    color = "black",
    fontSize = 15,
  }, gui.LeftContainer)

  evHandlers.onBorder = registerAnonymousEventHandler('erion.asciiMap.border', asciiMap.border)
  evHandlers.onRow = registerAnonymousEventHandler('erion.asciiMap.row', asciiMap.row)
end

function asciiMap.border(ev, line)
  if not asciiMap.started then
    asciiMap.console:clear()
    asciiMap.console:decho(line .. "\n")
  else
    asciiMap.console:decho(line .. "\n")
    asciiMap.started = false
  end
end

function asciiMap.row(ev, line)
  asciiMap.started = true
  asciiMap.console:decho(line .. "\n")
end

evHandlers.onBoot = registerAnonymousEventHandler('erion.sys.boot', asciiMap.boot, true)
