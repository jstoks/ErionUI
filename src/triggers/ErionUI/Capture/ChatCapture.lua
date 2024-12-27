selectCurrentLine()
copy()
deleteLine() --Remove Captured Line (Comment out to disable)

moveCursorEnd("MainBuffer")
selectCurrentLine("MainBuffer")
deleteLine("MainBuffer")

moveCursorUp(2)
--selectCurrentLine()

for i = 1, 3, 1 do
  if getCurrentLine() == "" then
    debugc("Deleted: "..getCurrentLine())
    deleteLine()
  end
  moveCursorDown()
  selectCurrentLine()
end


appendBuffer("ChatLog")
appendBuffer("ChatBuffer")