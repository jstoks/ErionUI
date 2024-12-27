-- Define functions to draw left container UI

function BuildLeftContainer()
  LeftContainer = Geyser.Container:new({
  Name = "MapContainer",
  x=0, y=0,
  width = 265, height="100%",
})
end

function BuildErionLabel()
  ErionLabel = Geyser.Label:new({
    name="ErionLabel",
    x=10, y=0,
    width = "98%", height = "70px",
    }, LeftContainer)
  ErionLabel:setColor("Black")
  ErionLabel:setFontSize(20)
  --ErionLabel:setFont("Bitstream Vera Sans Mono")
  ErionLabel:setFont("Copperplate Gothic Light")
  ErionLabel:echo("ErionMud", "grey", "cub")
end

function BuildStatsConsole()
  StatsConsole = Geyser.MiniConsole:new({
    name = "StatsConsole",
    x = 30, y = 80,
    width = "98%-30", height = "400px",
    autoWrap = false,
    scrollBar = false,
    color = "black",
    fontSize = 10,
  }, LeftContainer)
end

function BuildMapNameConsole()
  MapNameConsole = Geyser.MiniConsole:new({
    name = "MapNameConsole",
    x = 30, y = "100%-433px",
    width = "240px", height = "100px",
    autoWrap = false,
    scrollBar = false,
    color = "black",
    fontSize = 9,
  }, LeftContainer)
end

function BuildMapConsole()
  MapConsole = Geyser.MiniConsole:new({
    name = "MapConsole",
    x= 65, y="100%-340px",
    width="140", height="300px", 
    autoWrap = false,
    scrollBar = false,
    color = "black",
    fontSize = 15,
  }, LeftContainer)
end

function BuildExitsConsole()
  ExitsConsole = Geyser.MiniConsole:new({
    name = "ExitsConsole",
    x = 60, y = "100%-70px",
    width = "180px", height = "40px",
    autoWrap = true,
    scrollBar = false,
    color = "black",
    fontSize = 10,
  }, LeftContainer)
end