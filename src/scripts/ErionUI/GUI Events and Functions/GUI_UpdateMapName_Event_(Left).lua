--Update the map information panel

function UpdateMapName (event, RNM, ANM, RMS, VNM)
  clearWindow("MapNameConsole")
  
  cecho("MapNameConsole", "<b>Area Map\n")
  cecho("MapNameConsole", "---------------------------------\n")
  cecho("MapNameConsole", "<grey>Area: <royal_blue>"..ANM.."\n")
  cecho("MapNameConsole", "<grey>Room: <royal_blue>"..RNM.."\n")
  cecho("MapNameConsole", "<grey>Sector: <royal_blue>"..RMS.."\n")
  cecho("MapNameConsole", "<grey>VNUM: <royal_blue>"..VNM)
  

end

registerAnonymousEventHandler("GUI_UpdateMapName", "UpdateMapName")