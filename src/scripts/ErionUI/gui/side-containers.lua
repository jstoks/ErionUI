ErionUI = ErionUI or {}
ErionUI.Gui = ErionUI.Gui or {}

local gui = ErionUI.Gui

gui.LeftContainer = Geyser.Container:new({
  name = "LeftContainer",
  x=0, y=0,
  width = 265, height="100%",
})

-- gui.RightContainer = Adjustable.Container:new({
--   Name = "RightContainer",
--   titleText = "Chat Log",
--   x="-20%", y="0%",
--   width = "20%", height= "100%-80",
--   adjLabelstyle = "background-color:rgba(0,0,0,100%); border: 2px solid rgb(20,20,20);",
--   buttonstyle=[[
--       QLabel{ border-radius: 3px; background-color: rgba(40,40,40,100%);}
--       QLabel::hover{ background-color: rgba(60,60,60,50%);}
--       ]],
--   titleTxtColor = "white",
--   autoload = false,
--   autosave = false,
--   locked = true,
--   attached = right,
--   lockStyle = light,
--   menuStyle = dark,
-- })
