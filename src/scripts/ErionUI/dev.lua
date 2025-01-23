erion = erion or {}
erion.dev = erion.dev or {}
erion.dev.handlers = erion.dev.handlers or {}

local dev = erion.dev
-- Set to false to disable dev features
dev.enabled = true
dev.logEvents = true

local function boot()
  debugc("Booting: start")
  sys.killHandlers(dev.handlers)
  dev.handlers.onShutdown = registerAnonymousEventHandler('erion.sys.shutdown', shutdown, true)
end

local function shutdown()
  sys.killHandlers(dev.handlers)
end

if dev.eventSpamHandler then
  killAnonymousEventHandler(dev.eventSpamHandler)
end

if dev.enabled then
  dev.handlers.onBoot = registerAnonymousEventHandler('erion.sys.boot', boot, true)

  if dev.logEvents then
    -- Keep this handler separate.
    -- We want it to operate outside the normal handlers.
    dev.handlers.eventSpamHandler = registerAnonymousEventHandler('*', function (ev)
      debugc(ev)
    end)
  end
end

