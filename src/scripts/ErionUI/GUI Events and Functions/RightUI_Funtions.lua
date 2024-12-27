-- Define functions to draw right container UI

function BuildRightContainer ()
  RightContainer = RightContainer or Adjustable.Container:new({
    Name = "RightContainer",
    titleText = "Chat Log",
    x="-20%", y="0%",
    width = "20%", height= "100%-80",
    adjLabelstyle = "background-color:rgba(0,0,0,100%); border: 2px solid rgb(20,20,20);",
    buttonstyle=[[
        QLabel{ border-radius: 3px; background-color: rgba(40,40,40,100%);}
        QLabel::hover{ background-color: rgba(60,60,60,50%);}
        ]],
    titleTxtColor = "white",
    autoload = false,
    autosave = false,
    locked = true,
    attached = right,
    lockStyle = light,
    menuStyle = dark,
  })
end

function BuildChatConsole ()
  ChatLog = Geyser.MiniConsole:new({
    name = "ChatLog",
    --width="99%", height="48%", --for mapper
    width="99%", height="99%-40",
    autoWrap = true,
    scrollBar = true,
    color = "black",
    fontSize = 11,
  }, RightContainer)
end

function BuildMapLable()
  ErionLabel = Geyser.Label:new({
    name="MapLable",
    x=5, y="51%",
    width = "98%", height = "4%",
    }, RightContainer)
  ErionLabel:setColor("Black")
  ErionLabel:setFontSize(9)
  --ErionLabel:setFont("Bitstream Vera Sans Mono")
  ErionLabel:setFont("Copperplate Gothic Light")
  ErionLabel:echo("Erion Map", "grey", "cub")
  

end

function BuildMapper ()

  local mapper = Geyser.Mapper:new({
    name = "ErionMap",
    embedded = true,
    x = 0, y = "56%", -- edit here if you want to move it
    width = "100%", height = "50%"
  }, RightContainer)

end