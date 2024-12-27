--Just functions I may need to call

--Rounidng Function
  function round(x, n)
    n = math.pow(10, n or 0)
    x = x * n
    if x >= 0 then x = math.floor(x + 0.5) else x = math.ceil(x - 0.5) end
    return x / n
  end
  
--A counter to keep ScoreBuffer/Window clean
  function CleanScoreBuffer ()
    if Score_Buffer_Count == 0 then
      clearWindow("ScoreBuffer")
      Score_Buffer_Count = 0
      Score_Buffer_Count = Score_Buffer_Count + 1
    elseif Score_Buffer_Count == 16 then
      Score_Buffer_Count = 0
    else
      Score_Buffer_Count = Score_Buffer_Count + 1
    end
  end
  
  function SilentScoreCapture()
    send("score", false)
    tempTrigger("For more character information use aff, mults, sigil, worth, and whois.",
      function()
        moveCursor("main", 1, getLastLineNumber("main")-1)
        for i = 0, 17, 1 do
          deleteLine()
          moveCursorDown()
        end
      end, 1)
  end
    