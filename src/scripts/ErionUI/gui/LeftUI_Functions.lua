function BuildLeftContainer()
  LeftContainer = erion.gui.LeftContainer
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
    width = "98%-30", height = "300px",
    autoWrap = false,
    scrollBar = false,
    color = "black",
    fontSize = 10,
  }, LeftContainer)
end
