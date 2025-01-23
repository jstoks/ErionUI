erion = erion or {}
erion.start = erion.start or {}
erion.start.handlers = erion.start.handlers or {}

local start = erion.start

--A couple of variables that I need to ensure are set at 0 initally
CMap = CMap or 0
Score_Buffer_Count = Score_Buffer_Count or 0

function start.boot()
  debugc("start: boot")
  erion.sys.killHandlers(start.handlers)
  start.handlers.onShutdown = registerAnonymousEventHandler('erion.sys.shutdown', start.shutdown, true)
  start.handlers.onFirstInit = registerAnonymousEventHandler('erion.sys.firstInit', start.firstInit, true)
  start.handlers.onReconnected = registerAnonymousEventHandler('erion.sys.reconnected', start.reconnected, true)
end

function start.firstInit()
  debugc("start: firstInit")
  tempTimer(1, [[
    cecho("<green><b>If this is you first time running the UI, ")
    cechoLink("<purple>CLICK HERE!!", function()
      setFont("Bitstream Vera Sans Mono")
      setFontSize(11) end, 
    "UI Setup", true)
    cecho("\n<green><b>This will set the font to a uniform size.")
  ]])
  
end

function start.reconnected()
  debugc("Start: reconnected")
  tempTimer(1.5, [[
    send("look", false)
  ]])
end

function start.shutdown()
  debugc("Start: shutdown")
  erion.sys.killHandlers(start.handlers)
end


start.handlers.onBoot = registerAnonymousEventHandler('erion.sys.boot', start.boot, true)
