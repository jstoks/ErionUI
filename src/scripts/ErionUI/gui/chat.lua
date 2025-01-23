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

  local chatWindow = Adjustable.Container:new({
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

  local chatTabs = Ecmo:new({
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
      "System",
    },
    mapTab = false,
    activeTabCSS = tabStylesheet,
    inactiveTabCSS = inactiveTabStylesheet,
  }, chatWindow) 

  local buffers = {
    Chat = 'ChatBuffer',
    All = 'AllBuffer',
    System = 'SystemBuffer',
  }

  evHandlers.onChatLine = registerAnonymousEventHandler(
    'erion.chat.line', function (ev, line, type)
      debugc("chat type: " .. type)
      type = type or 'Chat'
      if type == 'Games' then
        type = "System"
      end

      tab = type

      debugc("Chat: line")
      line = line .. "\n"
      chatTabs:decho(tab, line)
      --decho("ChatBuffer", line)
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
