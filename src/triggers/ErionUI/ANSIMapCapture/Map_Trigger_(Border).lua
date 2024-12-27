if CMap == 0 then
  MapConsole:clear()
  
  selectCaptureGroup(1)
  copy()
  MapConsole:appendBuffer()
  replace()
  
  CMap = 1
else
  
  selectCaptureGroup(1)
  copy()
  MapConsole:appendBuffer()
  replace()

  CMap = 2
end

if CMap == 2 then
  CMap = 0
end