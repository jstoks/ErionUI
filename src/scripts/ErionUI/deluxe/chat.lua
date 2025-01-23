lux = lux or {}

-- pull in global methods
local next = next
local table_concat = table.concat
local table_remove = table.remove
local string_format = string.format

local ECMO = require('ErionUI.ecmo')

local Channel = {}
local Buffer = {}

function Channel:new(name)
  obj = {
    name = name,
    buffers = {},
  }
  setmetatable(obj, self)
  return obj
end

function Channel:connectTo(buffer)
  if not self.buffers[buffer.name] then
    self.buffers[buffer.name] = buffer
  end
end

function Channel:disconnectFrom(buffer)
  if self.buffers[buffer.name] then
    table_remove(self.buffers, buffer.name)
  end
end

function Channel:pushLine(text)
  for name, buffer in pairs(self.buffers) do
    buffer.pushLine(text)
  end
end

function Channel:describe()
  local str = self.name .. " => "
  if next(self.buffers) == nil
  return string_format("%s => %s", self.name, table_concat(self.buffers, ', '))
end

function Buffer:new(name, pushLine)
  obj = {
    name = name,
    channels = {},
    pushLine = pushLine,
  }
  setmetatable(obj, self)
  return obj
end

function Buffer:connectTo(channel) 
  if not self.channels[channel.name] then
    self.channels[channel.name] = channel
  end
end

function Buffer:disconnectFrom(channel)
  if self.channels[channel.name] then
    table_remove(self.channels, channel.name)
  end
end

function lux.ConsoleSystem:new(options)
  options = options or {}
  local obj = {
    channels = {},
    buffers = {},
    lines = {},
    currentLine = 0,
    lineLimit = options.lineLimit or 10000
  }

  setmetatable(obj, self)
  return obj
end

lux.__ConsoleSystem = {}

-- Adds a channel to the chat system
function lux.ConsoleSystem:addChannel(channelName)
  if not self.channels[channelName] then
    self.channels[channelName] = Channel:new(channelName)
  end
end

function lux.ConsoleSystem:addBuffer(bufferName, pushLine)
  if not self.buffers[bufferName] then
    self.buffers[bufferName] = Buffer:new(channelName, pushLine)
  end
end


function lux.ConsoleSystem:connect(channelName, bufferName)
  if self:assertChannel(channelName) and self:assertBuffer(bufferName) then
    self.channels:connectTo(self.buffers[bufferName])
    self.buffers:connectTo(self.channels[channelName])
  end
end

function lux.ConsoleSystem:disconnect(channelName, bufferName)
  if self:assertChannel(channelName) and self:assertBuffer(bufferName) then
    self.channels[channelName]:disconnectFrom(self.buffers[bufferName])
    self.buffers[bufferName]:disconnectFrom(self.channels[channelName])
  end
end

function lux.ConsoleSystem:assertBuffer(bufferName)
  if not self.buffers[bufferName] then
    debugc("Buffer does not exist: " .. bufferName)
    return nil
  end
end
  
function lux.ConsoleSystem:assertChannel(channelName)
  if not self.channels[channelName] then
    debugc("Channel does not exist: " .. channelName)
    return nil
  end
end
  
function lux.ConsoleSystem:pushLine(channelName, text)
  if self:assertChannel(channelName) then
    local idx = self:nextLineIndex()

    self.lines[idx] = { channelName = channelName, text = text}

    self.channels[channelName]:pushLine(text)
  end
end

function lux.ConsoleSystem:replayAll()
  local currentLine = self.currentLine
  local lineLimit = self.lineLimit 
  local channels = self.channels
  local lines = self.lines
  local line = nil
  local idx = currentLine + 1

  while idx <= lineLimit do
    line = lines[idx]
    channels[line.channelName]:pushLine(line.text)
    idx = idx + 1
  end

  idx = 1

  while idx <= currentLine do
    line = lines[idx]
    channels[line.channelName]:pushLine(line.text)
    idx = idx + 1
  end
end

function lux.ConsoleSystem:nextLineIndex()
  self.currentLine = self.currentLine + 1
  if self.currentLine > self.lineLimit then
    self.currentLine = 1
  end
  return self.currentLine
end



