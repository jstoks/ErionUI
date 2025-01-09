-- Functions to handle building the bottom UI

function BuildStatusBarContainer () --Define Status Bar
  StatusBar = Geyser.MiniConsole:new({
    name = "StatusBar",                   
    x=400, y="100%-40",                   
    width = 1100, height=40,
    scrollBar = false,            
    color = "black",
    fontSize = 11,
  })  

end

function SetCMDStyle () --Move Command Line

  setCmdLineStyleSheet("main", [[
    QPlainTextEdit {
      padding-left: 270px;       /* change 100 to your number */
      background-color: black;   /* change it to your background color */
    }
  ]])

end

function SetBarStyle () --Sets bar settings
  --Health
  hpbar = Geyser.Gauge:new({
    name="hpbar",
    x=275, y="100%-38",
    width=120, height=13,
  })
  hpbar.front:setStyleSheet([[
    background-color: #cc0000;
    border-radius: 2;
  ]])
  hpbar.back:setStyleSheet([[
    background-color: #660000;
    border-radius: 2;
  ]])
  hpbar.text:setStyleSheet([[
    text-align: right;
    padding-right: 5px;
  ]])
  hpbar:setAlignment("center")

  --Energy
  enbar = Geyser.Gauge:new({
    name="enbar",
    x=275, y="100%-18",
    width=120, height=13,
  })
  enbar.front:setStyleSheet([[
    background-color: #3d85c6;
    border-radius: 2;
  ]])
  enbar.back:setStyleSheet([[
    background-color: #073763;
    border-radius: 2;
  ]])
  enbar.text:setStyleSheet([[
    text-align: right;
    padding-right: 5px;
  ]])
  enbar:setAlignment("center")
end