erion = erion or {}
erion.gui = erion.gui or {}
erion.gui.exits = erion.gui.exits or {}
erion.gui.exits.handlers = erion.gui.exits.handlers or {}

local gui = erion.gui
local exits = gui.exits
local evHandlers = exits.handlers

local cfText = require('ErionUI.ftext').cfText

function exits.boot()
  debugc('exits: boot')
  erion.sys.killHandlers(evHandlers)
  evHandlers.onInit = registerAnonymousEventHandler('erion.sys.init', exits.init, true)
end

function exits.init()
  local window = exits.Window:new()

  if erion.data.location.exits then
    window:patch(erion.data.location.exits)
  end

  evHandlers.onExitsUpdated = registerAnonymousEventHandler(
    'data.location.exits', function (ev, exitChanges) 
      debugc(ev)
      window:update(exitChanges)
      
    end)
end

exits.Window = {}
exits.Window.__index = exits.Window

function exits.Window:new()
  local obj = {
    order = { 'north', 'east', 'south', 'west', 'up', 'down' },
    directions = { 
      north = '_',
      east = '_',
      south = '_',
      west = '_',
      up = '_',
      down = '_',
    }
  }
  obj.console = Geyser.MiniConsole:new({
    name = "Window",
    x = 30, y = "100%-100px",
    width = "32c", height = "4c",
    autoWrap = true,
    scrollBar = false,
    color = "black",
    fontSize = 12,
  }, LeftContainer)
  setmetatable(obj, self)
  return obj
end

function exits.Window:update(changes)
  self:patch(changes)
  self:render()
end

function exits.Window:patch(changes)
  for dir, status in pairs(changes) do
    self.directions[dir] = status
  end
end

function exits.Window:echoTitle()
  local text = cfText('Exits', {
    alignment = "center", 
    width = self.console:getColumnCount(),
    cap = "{",
    spacer = "=",
    inside = false,
    mirror = true,
    textBold = true,
  }) .. "\n\n"
  self.console:cecho(text)
end

function exits.Window:render()
  local str = ''
  local dirList = {}

  for _, dir in pairs(self.order) do
    local status = self.directions[dir]
    if status == 'unknown' then
      table.insert(dirList, string.format("<green>?%s", dir))
    elseif status == 'known' then
      table.insert(dirList, string.format("<reset>%s", dir))
    end
  end

  self.console:clear()
  self:echoTitle()
  self.console:cecho(string.format("%s<reset>\n", table.concat(dirList, ' ')))
end

evHandlers.onBoot = registerAnonymousEventHandler('erion.sys.boot', exits.boot, true)
