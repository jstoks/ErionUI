ErionUI = ErionUI or {}
ErionUI.Sys = ErionUI.Sys or {}
ErionUI.Sys.handlers = ErionUI.Sys.handlers or {}

-- Short alias
local sys = ErionUI.Sys

sys.boot = function ()
  raiseEvent('erion.sys.boot')
end

sys.shutdown = function ()
  raiseEvent('erion.sys.shutdown')
end

for name, handler in pairs(sys.handlers) do
  if handler then
    killAnonymousEventHandler(handler)
  end
end

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
