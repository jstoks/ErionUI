
--A couple of variables that I need to ensure are set at 0 initally
CMap = CMap or 0
Score_Buffer_Count = Score_Buffer_Count or 0

function StartUp ()
  
  
  tempRegexTrigger("Welcome to Erion!|Reconnecting",
    function()
      raiseEvent("SetDefaultMudSettings")
      local ConnectType = matches[1]
      echo("\n Match: " .. ConnectType)
      
      tempTimer(1, [[
        cecho("<green><b>If this is you first time running the UI, ")
        cechoLink("<purple>CLICK HERE!!", function()
          setFont("Bitstream Vera Sans Mono")
          setFontSize(11) end, 
        "UI Setup", true)
        cecho("\n<green><b>This will set the font to a uniform size.")
      ]])
      
      if ConnectType == "Reconnecting" then
      tempTimer(1.5, [[
        send("look", false)
      ]])
      end
      
    end, 1)
end

registerAnonymousEventHandler("erion.sys.boot", "StartUp", true)
