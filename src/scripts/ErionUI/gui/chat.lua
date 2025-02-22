erion = erion or {}
erion.gui = erion.gui or {}
erion.gui.chat = erion.gui.chat or {}
erion.gui.chat.handlers = erion.gui.chat.handlers or {}

local gui = erion.gui
local chat = gui.chat
local evHandlers = erion.gui.chat.handlers
local Ecmo = require('ErionUI.ecmo')

chat.boot = function()
  debugc("Chat: boot")
  createBuffer('ChatBuffer')
  setWindowWrap('ChatBuffer', 1000)
  erion.sys.killHandlers(evHandlers)
  evHandlers.onInit = registerAnonymousEventHandler('erion.sys.init', chat.init, true)
  evHandlers.onShutdown = registerAnonymousEventHandler('erion.sys.shutdown', chat.shutdown, true)
end

function chat.shutdown()
end

chat.init = function()
  debugc("Chat: init")

  chat.window = Adjustable.Container:new({
    name = "ChatWindow",
    titleText = "Chat Messages",
    x = "-25%", y = 0,
    width = "25%",
    height = "100%",
    adjLabelstyle = boxCSS,
    attached = "right" ,
  })

  local inactiveTabStylesheet = [[
    background-color: rgb(60,60,60,255); 
    border-width: 1px; 
    border-style: solid; 
    border-color: rgb(180,180,180,255); 
    border-radiust: 1px;
  ]]

  local tabStylesheet = [[
    background-color: rgb(0,0,0,255); 
    border-width: 1px 1px 0 1px; 
    border-style: solid; 
    border-color: rgb(200,200,200,255); 
    border-radius: 1px;
    text-decoration: underline;
  ]]

  chat.tabs = Ecmo:new({
    x = "0",
    y = "0",
    width = "100%",
    height = "100%",
    activeTabFGColor = "cyan",
    inactiveTabFGColor = "white",
    allTab = true,
    allTabName = "All",
    fontSize = 13,
    tabFontSize = 12,
    tabBold = true,
    gap = 2,
    consoleColor = "black",
    consoles = {
      "Chat",
      "All", 
      "Misc",
    },
    mapTab = false,
    activeTabCSS = tabStylesheet,
    inactiveTabCSS = inactiveTabStylesheet,
  }, chat.window) 

  local cb = lux.ChanneledBuffers:new()

  cb:addChannel('chat')
  cb:addChannel('newbie')
  cb:addChannel('grats')
  cb:addChannel('quote')
  cb:addChannel('roleplay')
  cb:addChannel('client')
  cb:addChannel('Newbies')
  cb:addChannel('Class')
  cb:addChannel('Healers')
  cb:addChannel('Auction')
  cb:addChannel('music')
  cb:addChannel('Quest')
  cb:addChannel('Global Quest')
  cb:addChannel('mudevent')
  cb:addChannel('Player Deaths')
  cb:addChannel('COLOSSEUM')
  cb:addChannel('GUESS')
  cb:addChannel('SCRAMBLE')
  cb:addChannel('Levels')
  cb:addChannel('Logout')
  cb:addChannel('Login')
  cb:addChannel('NEW Player')
  cb:addChannel('killed')
  cb:addChannel('Rankings')
  cb:addChannel('Expedition')
  cb:addChannel('Achievement')

  cb:addBuffer('chat', function (line) chat.tabs:decho('Chat', line) end)
  cb:addBuffer('misc', function (line) chat.tabs:decho('Misc', line) end)
  cb:defaultBuffer('chat')

  cb:connect('chat', 'chat')
  cb:connect('newbie', 'chat')
  cb:connect('grats', 'chat')
  cb:connect('quote', 'chat')
  cb:connect('roleplay', 'chat')
  cb:connect('client', 'chat')
  cb:connect('Newbies', 'chat')
  cb:connect('Class', 'chat')
  cb:connect('Healers', 'chat')
  cb:connect('Auction', 'chat')
  cb:connect('music', 'chat')

  cb:connect('Quest', 'misc')
  cb:connect('Global Quest', 'misc')
  cb:connect('mudevent', 'misc')
  cb:connect('Player Deaths', 'misc')
  cb:connect('COLOSSEUM', 'misc')
  cb:connect('GUESS', 'misc')
  cb:connect('SCRAMBLE', 'misc')
  cb:connect('Levels', 'misc')
  cb:connect('Logout', 'misc')
  cb:connect('Login', 'misc')
  cb:connect('NEW Player', 'misc')
  cb:connect('killed', 'misc')
  cb:connect('Rankings', 'misc')
  cb:connect('Expedition', 'misc')
  cb:connect('Achievement', 'misc')

  chat.channelBuffer = cb

  debugc("chat ready")

  evHandlers.onChatLine = registerAnonymousEventHandler(
    'erion.chat.line', function (ev, channel, line)

      chat.channelBuffer:pushLine(channel, line .. "\n")
    end
  )
  
  -- evHandlers.onResized = registerAnonymousEventHandler(
  --   "AdjustableContainerRepositionFinish", function (ev, containerName)
  --     debugc('chat: resized - ' .. containerName)
  --     if containerName ~= "ChatWindow" then
  --       return
  --     end

  --     chat.reWrap()

  --   end
  -- )

  -- evHandlers.onReflow = registerAnonymousEventHandler('erion.sys.reflow', chat.reWrap)
end

function chat.reWrap()
  local columns = getColumnCount('ChatLog')
  clearWindow('ChatLog')
  setWindowWrap('ChatLog', columns - 1)

  local lines = getLastLineNumber("ChatBuffer")
  for i = 0, lines-1, 1 do
    moveCursor("ChatBuffer", 0, i)
    selectCurrentLine("ChatBuffer")
    copy("ChatBuffer")
    appendBuffer('ChatLog')
  end
end


evHandlers.onBoot = registerAnonymousEventHandler("erion.sys.boot", gui.chat.boot, true)
