local currentLineEmpty = getCurrentLine():gsub("%s*", "")
moveCursorEnd("MainBuffer")
moveCursorUp("MainBuffer", 1, false)
local mainBufferLineEmpty = getCurrentLine("MainBuffer"):gsub("%s*","")

if currentLineEmpty == "" and currentLineEmpty == mainBufferLineEmpty then
  deleteLine()
else
  selectCurrentLine()
  copy()
  appendBuffer("MainBuffer")
end
