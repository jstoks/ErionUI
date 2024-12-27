-- Does a full UI refresh

function GUIRefresh (event)

  --Left UI
  
  SetupGUI() -- Will need to move this
  BuildLeftContainer()
  BuildErionLabel()
  BuildStatsConsole()
  BuildMapNameConsole()
  BuildMapConsole()
  BuildExitsConsole()
  
  --Right UI
  
  BuildRightContainer()
  BuildChatConsole()
  
  --Bottom UI
  
  BuildStatusBarContainer()
  SetCMDStyle()
  SetBarStyle()
  
  echo("UI Refreshed!\n")
  
end

registerAnonymousEventHandler("GUI_Refresh", "GUIRefresh")

