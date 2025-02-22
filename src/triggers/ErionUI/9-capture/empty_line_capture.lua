local emptyLine = getCurrentLine():gsub("%s*", "")
moveCursorEnd("MainBuffer")
local maybeEmptyLine = getCurrentLine("MainBuffer"):gsub("%s*","")

if empyLine == maybeEmptyLine then
  deleteLine()
end
