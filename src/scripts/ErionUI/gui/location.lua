erion = erion or {}
erion.gui = erion.gui or {}
erion.gui.location = erion.gui.location or {}
erion.gui.location.handlers = erion.gui.location.handlers or {}

local gui = erion.gui
gui.location.LocationConsole = {}
local LocationConsole = gui.location.LocationConsole
local evHandlers = erion.gui.location.handlers

local cfText = require('ErionUI.ftext').cfText

function gui.location.boot()
  debugc("location: boot")
  erion.sys.killHandlers(evHandlers)
  evHandlers.onShutdown = registerAnonymousEventHandler('erion.sys.shutdown', gui.location.shutdown, true)
  evHandlers.onInit = registerAnonymousEventHandler('erion.sys.init', gui.location.init, true)
end

function gui.location.shutdown()
  debugc("location: shutdown")
  erion.sys.killHandlers(evHandlers)
end


gui.location.init = function ()
  debugc("location: init")

  local locationConsole = gui.location.LocationConsole:new()
  if erion.data.location and erion.data.location.room then 
    local loc = erion.data.location
    locationConsole:patch(loc)
  end
  locationConsole:echo()

  evHandlers.onLocationUpdated = registerAnonymousEventHandler(
    'data.location', function(event, location)
      debugc('patching location')
      locationConsole:update(location)
    end
  )
end

evHandlers.onBoot = registerAnonymousEventHandler("erion.sys.boot", gui.location.boot, true)


LocationConsole.__index = LocationConsole

function LocationConsole:new()
  local obj = {
    title = 'Location',
    fields = {
      area = { label = 'Area', value = '' },
      room = { label = 'Room', value = ''},
      sector = { label = 'Sector', value = ''},
      vnum = { label = 'VNUM', value = ''},
    },
    console = Geyser.MiniConsole:new({
      name = "LocationConsole",
      x = 30, y = "100%-460px",
      width = "32c", height = "9c",
      autoWrap = false,
      scrollBar = false,
      fontSize = 11,
      color = 'black',
    }, gui.LeftContainer),
  }
  setmetatable(obj, self)
  return obj
end

function LocationConsole:update(location)
  self:patch(location)
  self:echo()
end

function LocationConsole:patch(location)
  for key,value in pairs(location) do
    local field = self.fields[key]
    if field then
      field.value = value
    end
  end
end

function LocationConsole:echo()
  self.console:clear()
  self:echoTitle()
  self.console:cecho("\n")
  self:echoRoom()
  self.console:cecho("\n")
  self:echoField(self.fields.area)
  self:echoField(self.fields.sector)
  self:echoField(self.fields.vnum)
end

function LocationConsole:echoTitle()
  local text = cfText(self.title, {
    alignment = "center", 
    width = self.console:getColumnCount(),
    cap = "{",
    spacer = "=",
    inside = false,
    mirror = true,
    textBold = true,
  }) .. "\n"
  self.console:cecho(text)
end

function LocationConsole:echoRoom()
  local roomValue = self.fields.room.value
  local columnCount = self.console:getColumnCount()
  local lines = splitLine(roomValue, columnCount)

  for _,line in pairs(lines:split("\n")) do
    local text = cfText(line, {
      alignment = "center", 
      width = self.console:getColumnCount(),
      spacer = " ",
      inside = false,
      textColor = "<cyan>",
      textBold = true,
    }) .. "\n"
    self.console:cecho(text)
  end
end

function LocationConsole:echoField(field)
  local text = cfText(field.value, {
    alignment = "right", 
    width = self.console:getColumnCount(),
    cap = field.label .. ":",
    spacer = " ",
    inside = true,
    textColor = "<white>",
    truncate = true,
  }) .. "\n"
  self.console:cecho(text)
end
