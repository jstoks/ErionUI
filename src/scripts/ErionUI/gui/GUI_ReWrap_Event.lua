function Rewrap_Main ()
--   setWindowWrap("main", getColumnCount("main")-1)
--   debugc("Wrapping Main")
--   
--   local Num = getLastLineNumber("MainBuffer")
-- 
--   clearWindow()
--   for i = 0, Num, 1 do
--     moveCursor("MainBuffer", 0, i)
--     selectCurrentLine("MainBuffer")
--     copy("MainBuffer")
--     appendBuffer("main")
--   end
--   Rewrap_Chat()
end

function Rewrap_Chat ()
--   setWindowWrap("ChatLog", getColumnCount("ChatLog")-1)
--   debugc("Wrapping Chat")
-- 
--   local Num = getLastLineNumber("ChatBuffer")
--   
--   clearWindow("ChatLog")
--   for i = 0, Num-1, 1 do
--     moveCursor("ChatBuffer", 0, i)
--     selectCurrentLine("ChatBuffer")
--     copy("ChatBuffer")
--     appendBuffer("ChatLog")
--   end
end
 

registerAnonymousEventHandler("AdjustableContainerRepositionFinish", "Rewrap_Main")
