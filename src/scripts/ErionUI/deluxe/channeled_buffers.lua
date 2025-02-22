lux = lux or {}
lux.ChanneledBuffers = lux.ChanneledBuffers or {}
lux.ChanneledBuffers.__index = lux.ChanneledBuffers

-- pull in global methods
local next = next
local table_concat = table.concat
local table_remove = table.remove
local table_insert = table.insert
local string_format = string.format

local Channel = {}
Channel.__index = Channel
local Buffer = {}
Buffer.__index = Buffer

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
  local keys = {}
  for key, _ in pairs(self.buffers) do
    table_insert(keys, key)
  end
  return str .. table_concat(keys, ', ')
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

function lux.ChanneledBuffers:new()
  options = options or {}
  local obj = {
    channels = {},
    buffers = {},
    lines = {},
    currentLine = 0,
    lineLimit = 10000
  }

  setmetatable(obj, self)

  obj:addChannel('__default__')

  return obj
end

-- Adds a channel to the chat system
function lux.ChanneledBuffers:addChannel(channelName)
  if not self.channels[channelName] then
    self.channels[channelName] = Channel:new(channelName)
  end
end

function lux.ChanneledBuffers:addBuffer(bufferName, pushLine)
  if not self.buffers[bufferName] then
    self.buffers[bufferName] = Buffer:new(bufferName, pushLine)
  end
end


function lux.ChanneledBuffers:connect(channelName, bufferName)
  if self:assertChannel(channelName) and self:assertBuffer(bufferName) then
    self.channels[channelName]:connectTo(self.buffers[bufferName])
    self.buffers[bufferName]:connectTo(self.channels[channelName])
  end
end

function lux.ChanneledBuffers:defaultBuffer(bufferName)
  self:addChannel('__default__')
  self:disconnectAllFromChannel('__default__')
  self:connect('__default__', bufferName)
end

function lux.ChanneledBuffers:disconnect(channelName, bufferName)
  if self:assertChannel(channelName) and self:assertBuffer(bufferName) then
    self.channels[channelName]:disconnectFrom(self.buffers[bufferName])
    self.buffers[bufferName]:disconnectFrom(self.channels[channelName])
  end
end

function lux.ChanneledBuffers:disconnectAllFromChannel(channelName)
  if self:assertChannel(channelName) then
    local channel = self.channels[channelName]

    for bufferName, buffer in pairs(channel.buffers) do
      channel:disconnectFrom(buffer)
      buffer:disconnectFrom(channel)
    end
  end
end

function lux.ChanneledBuffers:assertBuffer(bufferName)
  if not self.buffers[bufferName] then
    debugc("Buffer does not exist: " .. (bufferName or 'nil'))
    return false
  end
  return true
end
  
function lux.ChanneledBuffers:assertChannel(channelName)
  if not self.channels[channelName] then
    debugc("Channel does not exist: " .. (channelName or "nil"))
    return false
  end
  return true
end
  
function lux.ChanneledBuffers:pushLine(channelName, text)
  if self:assertChannel(channelName) then
    local idx = self:nextLineIndex()

    self.lines[idx] = { channelName = channelName, text = text}

    self.channels[channelName]:pushLine(text)
  else
    local idx = self:nextLineIndex()

    self.lines[idx] = { channelName = '__default__', text = text}


    self.channels['__default__']:pushLine(text)
  end
end

function lux.ChanneledBuffers:replayAll()
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

function lux.ChanneledBuffers:nextLineIndex()
  self.currentLine = self.currentLine + 1
  if self.currentLine > self.lineLimit then
    self.currentLine = 1
  end
  return self.currentLine
end



