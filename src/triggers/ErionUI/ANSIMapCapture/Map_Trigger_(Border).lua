if CMap == 0 then
  MapConsole:clear()
  
  selectCaptureGroup('map')
  copy()
  MapConsole:appendBuffer()
  selectCaptureGroup('clear')
  replace()
  
  CMap = 1
else
  
  selectCaptureGroup('map')
  copy()
  MapConsole:appendBuffer()
  selectCaptureGroup('clear')
  replace()

  CMap = 2
end

if CMap == 2 then
  CMap = 0
end
