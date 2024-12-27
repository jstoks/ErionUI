local function initialize()
  erion = erion or {}
  local data = erion.data or {}

  local character = data.character or {
    hp = {
      current = 0,
      max = 0,
    },
    mp = {
      current = 0,
      max = 0,
    },
    exp = {
      current = 0,
      next = 0,
    },
  }

  erion.data = Dataset:new('data', {
    character = character
  })
end


local Dataset = {}
local Changeset = {}
local Change = {}

local Log = Log or require('FancyErion.loginator')
local log = log or Log:new({ name = "dataset", level = "debug" })

function Dataset:new(key, data)
  data = data or {}

  local dataset = { key = key }
  self.__index = self
  setmetatable(dataset, self)

  for k,v in pairs(data) do
    if type(v) == "table" then
      dataset[k] = dataset:define(k, v)
    else
      dataset[k] = v
    end
  end

  return dataset
end

function Dataset:define(key, data)
  return Dataset:new(self.key .. '.' .. key, data)
end

function Dataset:changeset(data)
  local typeData = type(data)
  local changes = {}
  assert(type(data) == "table", "Data must be a table")

  for key, value in pairs(self) do
    local dataValue = data[key]

    -- Don't require every value
    if dataValue then
      local typeValue = type(value)
      local typeDataValue = type(dataValue)
      let changeKey = makeKey(self.key, key)

      assert(typeValue == typeDataValue, "Data must have same shape. " .. typeValue .. 'vs' .. typeDataValue)

      if typeValue == "table" then
        changes[key] = value:changeset(dataValue)
      elseif value ~= dataValue then
        changes[key] = Change:new(changeKey, dataValue, value)
        self[key] = dataValue
        log:debug("Set " .. changeKey .. ' = ' .. dataValue)
      else
        log:debug("Values equal for key: " .. changeKey)
      end
    end
  end

  return Changeset:new(self.key, changes)
end

function Dataset:update(data) 
  local changeset = self:changeset(data)
  changeset:broadcast('erion')
end

function Changeset:new(key, changes)
  local obj = {
    changes = changes or {},
    key = key,
  }
  self.__index = self
  setmetatable(obj, self)
  return obj
end

function Changeset:broadcast(prefix)
  for key, change in pairs(self.changes) do
    change:broadcast(prefix)
  end
end

function Change:new(key, value, oldValue)
  local obj = { key = key, value = value, oldValue = oldValue }
  self.__index = self
  setmetatable(obj, self)
  return obj
end

function Change:broadcast(prefix)
  local eventName = prefix .. '.' .. self.key
  raiseEvent(eventName, self.value, self.oldValue)
  log:debug(string.format("raiseEvent(%s,%s,%s)", eventName, self.value, self.oldValue))
end

initialize()
