ErionUI = ErionUI or {}
ErionUI.Data = ErionUI.Data or {}

local Dataset = {}

-- Test
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

  local location = data.location or {
    area = '',
    room = '',
    sector = '',
    vnum = ''
  }

  erion.data = Dataset:new('data', {
    character = character,
    location = location
  })
  ErionUI.Data = erion.data
end

function Dataset:new(path, data)
  data = data or {}

  local key = undot(path)
  local dataset = {}
  local metadata = { path = path, key = key }
  metadata.__index = metadata
  setmetatable(dataset, metadata)
  self.__index = self
  setmetatable(metadata, self)

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
  return Dataset:new(dot(self.key, key), data)
end

function Dataset:setchanges(data, changes)
  changes = changes or {}
  local typeData = type(data)
  local changedData = {}
  assert(type(data) == "table", "Data must be a table")

  debugc("updating")
  for key, value in pairs(self) do
    local dataValue = data[key]

    -- Don't require every value
    if dataValue then
      local typeValue = type(value)
      local typeDataValue = type(dataValue)

      assert(typeValue == typeDataValue, "Data must have same shape. " .. typeValue .. 'vs' .. typeDataValue)

      if typeValue == "table" then
        local nestedChanges = value:setchanges(dataValue, changes)
        if next(nestedChanges) ~= nil then
          changedData[key] = nestedChanges
        end
      elseif value ~= dataValue then
        changedData[key] = dataValue
        self[key] = dataValue
        table.insert(changes, { path = dot(self.path, key), value = dataValue })
        debugc(string.format("Changed: %s - %s", key, dataValue))
      else
        debugc(string.format("Unchanged: %s", key))
      end
    end
  end
  if next(changedData) ~= nil then
    table.insert(changes, { path = self.path, value = changedData})
  end

  return changedData
end

function Dataset:update(data) 
  debugc('ok')
  local changes = {}
  self:setchanges(data, changes)

  for _,change in ipairs(changes) do
    raiseEvent(change.path, change.value)
    debugc(string.format("Raised %s", change.path))
  end
end

registerAnonymousEventHandler('erion.sys.boot', initialize, true)

