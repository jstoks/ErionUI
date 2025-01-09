ErionUI = ErionUI or {}
ErionUI.EventHandlers = ErionUI.EventHandlers or {}
ErionUI.EventHandlers.Chat = ErionUI.EventHandlers.Chat or {}

local evHandlers = ErionUI.EventHandlers.Chat

local function onBoot()
  local boxCSS = [[
    background-color: rgba(0,0,0,100);
    border-style: solid;
    border-width: 1px;
    border-radius: 5;
    border-color: white;
    margin: 1px;
  ]]

  local chatWindow = Adjustable.Container:new({
    name = "ChatWindow",
    titleText = "Chat Messages",
    x = "-25%", y = 0,
    width = "25%",
    height = "100%",
    adjLabelstyle = boxCSS, 
    attached = "right" ,
  })

  local chatLog = Geyser.MiniConsole:new({
    name = "ChatLog",
    x = "0", y = "0",
    width="100%", height="100%",
    autoWrap = true,
    scrollBar = true,
    color = "black",
    fontSize = 11,
  }, chatWindow)

  evHandlers.onChatLine = registerAnonymousEventHandler(
    'erion.chat.line', function (ev, line)
      chatLog:cecho(line)
    end
  )
end

for key, handler in pairs(evHandlers) do
  if handler then
    killAnonymousEventHandler(evHandlers[key])
  end
end

evHandlers.onBoot = registerAnonymousEventHandler("erion.sys.boot", onBoot)


-- function BuildMapLable()
--   ErionLabel = Geyser.Label:new({
--     name="MapLable",
--     x=5, y="51%",
--     width = "98%", height = "4%",
--     }, RightContainer)
--   ErionLabel:setColor("Black")
--   ErionLabel:setFontSize(9)
--   --ErionLabel:setFont("Bitstream Vera Sans Mono")
--   ErionLabel:setFont("Copperplate Gothic Light")
--   ErionLabel:echo("Erion Map", "grey", "cub")
--   
-- 
-- end
-- 
-- function BuildMapper ()
-- 
--   local mapper = Geyser.Mapper:new({
--     name = "ErionMap",
--     embedded = true,
--     x = 0, y = "56%", -- edit here if you want to move it
--     width = "100%", height = "50%"
--   }, RightContainer)
-- 
-- end
