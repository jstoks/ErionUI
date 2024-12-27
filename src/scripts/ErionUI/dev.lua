
DEV_MODE = true

if not DEV_MODE then
    return
end

local DEV = DEV or {}

local function kill_helper()
  for pkgName, _ in pairs(package.loaded) do
    if pkgName:find("@PKGNAME@") then
      debugc("Uncaching lua package " .. pkgName)
      package.loaded[pkgName] = nil
    end
  end
end

local function create_helper()
  if DEV.muddler then DEV.muddler:stop() end
  DEV.muddler = Muddler:new({
    path = getMudletHomeDir() .. "/@PKGNAME@",
    postremove = kill_helper,
  })
end

if not DEV.muddler then
  registerAnonymousEventHandler("sysLoadEvent", create_helper)
end
