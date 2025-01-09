function InitUI ()

--Buffers for word wrapping
  createBuffer("MainBuffer")
  createBuffer("ChatBuffer")
  createBuffer("ScoreBuffer")

--UI Functions

--Setting Borders
  setBorderRight(0)
  setBorderLeft(275)
  setBorderBottom(40)
  setBorderColor(0, 0, 0)

--Left (LeftUI Functions)
  BuildLeftContainer()
  BuildErionLabel()
  BuildStatsConsole()
  --BuildMapNameConsole()
  BuildMapConsole()
  BuildExitsConsole()
  
--Right (LeftUI Functions)
  --BuildRightContainer()
  --BuildChatConsole()
  --BuildMapLable()
  --BuildMapper()

  
  --RightContainer:attachToBorder("right")
  --RightContainer:connectToBorder("right")
  --RightContainer:lockContainer("light")
  
--Bottom (BottomUI Functions)
  BuildStatusBarContainer()
  SetCMDStyle()
  SetBarStyle()

end

registerAnonymousEventHandler("erion.sys.boot", "InitUI", true)
