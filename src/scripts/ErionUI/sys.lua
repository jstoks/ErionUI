erion = erion or {}
erion.sys = erion.sys or {}
erion.sys.handlers = erion.sys.handlers or {}
erion.sys.triggers = erion.sys.triggers or {}
erion.sys.timers = erion.sys.timers or {}

-- Short alias
local sys = erion.sys

-- Loaded flag first layer of system
sys.booted = sys.booted or false

-- initialized flag executes on connection and relies on loaded
sys.initialized = sys.initialized or false

-- Have we initialized at least once?
sys.initializedOnce = sys.initializedOnce or false

function sys.boot()
  debugc("sys: boot")
  raiseEvent('erion.sys.boot')
  debugc("sys: after boot")
  sys.booted = true
  debugc("sys: after boot")
  -- If already logged in and playing 
  if sys.initialized then
    debugc("sys: init now")
    sys.initialize()
  else
    debugc("sys: init later")
    sys.triggers.welcome = tempRegexTrigger("Welcome to Erion!", function ()
      sys.initialize()
      killTrigger(sys.triggers.reconnect)
    end, 1)
    sys.triggers.reconnect = tempRegexTrigger("Reconnecting", function ()
      sys.initialize()
      raiseEvent('erion.sys.reconnected')
      killTrigger(sys.triggers.welcome)
    end, 1)
  end
end

function sys.initialize()
  debugc("sys: intit")
  raiseEvent('erion.sys.init')
  sys.initialized = true

  if not sys.initializedOnce then
    debugc("sys: firstInit")
    raiseEvent('erion.sys.firstInit')
    sys.initializedOnce = true
  end
end

function sys.shutdown()
  debugc("sys: shutdown")
  raiseEvent('erion.sys.shutdown')
  sys.killHandlers(sys.handlers)
  sys.killTriggers(sys.triggers)
  sys.killTimers(sys.timers)
end


function sys.killHandlers(handlers)
  for name, handler in pairs(handlers) do
    if handler then
      killAnonymousEventHandler(handler)
    end
  end
end
sys.killHandlers(sys.handlers)

function sys.killTriggers(triggers)
  for name, trigger in pairs(triggers) do
    if trigger then
      killTrigger(trigger)
    end
  end
end
sys.killTriggers(sys.triggers)

function sys.killTimers(timers)
  for name, timer in pairs(timers) do
    if timer then
      killTimer(timer)
    end
  end
end
sys.killTimers(sys.timers)

sys.handlers.onInstall = registerAnonymousEventHandler("sysInstallPackage", function (_, packageName)
  if packageName ~= "@PKGNAME@" then return end

  sys.boot()
end)

sys.handlers.onLoad = registerAnonymousEventHandler("sysLoadEvent", function ()
  sys.boot()
end)

sys.handlers.onUninstall = registerAnonymousEventHandler("sysUninstallPackage", function (_, packageName)
  if packageName ~= "@PKGNAME@" then return end

  sys.shutdown()
end)

sys.handlers.onUnload = registerAnonymousEventHandler("sysUnloadEvent", function ()
  sys.shutdown()
end)

sys.handlers.onWindowResized = registerAnonymousEventHandler('sysWindowResizeEvent', function ()
  if sys.timers.resized then
    killTimer(sys.timers.resized)
  end
  sys.timers.resized = tempTimer(3, [[ raiseEvent('erion.sys.reflow') ]])
end)

