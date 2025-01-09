-- Function to redraw status console UI(s)

function UpdateStatus (event, LVL, FLV, NXP, GLD, QPS, HPS, MDP, QTM, ETM, GTM, JTM, XPE, QPE, QTE, PLT)
    clearWindow("StatsConsole")
    
    cecho("StatsConsole", "<grey><b>Character Status</b>".."\n")
    cecho("StatsConsole", "------------------------------------\n")
    cecho("StatsConsole", "<grey>Level: <royal_blue>"..LVL.."<grey>  Faux: <royal_blue>"..FLV.."\n")
    cecho("StatsConsole", "<grey>EXP to Lvl: <royal_blue>"..NXP.."\n")
    cecho("StatsConsole", "<grey>Gold: <yellow>"..GLD.."\n")
    cecho("StatsConsole", "<grey>QP: <purple>"..QPS.."\n")
    cecho("StatsConsole", "<grey>House Points: <dark_green>"..HPS.."\n")
    cecho("StatsConsole", "<grey>Mud Pies: <tan>"..MDP.."\n")
    cecho("StatsConsole", "\n")
    cecho("StatsConsole", "<grey>Timers <royal_blue>\n")
    cecho("StatsConsole", "------------------------------------\n")
    if QTM == "" then cecho("StatsConsole", "<grey>Quest:<cyan>         Availible!\n")
    else cecho("StatsConsole", "<grey>Quest: <white>        "..QTM.."\n") end
    if ETM == "" then cecho("StatsConsole", "<grey>Expedition:    <cyan>Availible!\n")
    else cecho("StatsConsole", "<grey>Expedition:<white>    "..ETM.."\n") end
    if JTM == "" then cecho("StatsConsole", "<grey>Junkyard:<cyan>      Availible!\n")
    else cecho("StatsConsole", "<grey>Junkyard:<white>      "..JTM.."\n") end
    if PLT == "" then cecho("StatsConsole", "<grey>Pilgrimage:<cyan>    Availible!\n")
    else cecho("StatsConsole", "<grey>Pilgrimage:<white>      "..PLT.."\n") end
    if GTM == "" then cecho("StatsConsole", "<grey>GlobalQuest:<cyan>   Inactive!\n")
    else cecho("StatsConsole", "<grey>GlobalQuest:<white>   "..GTM.."\n") end
    cecho("StatsConsole", "\n")
    cecho("StatsConsole", "<grey><b>Events <royal_blue>\n")
    cecho("StatsConsole", "------------------------------------\n")
    
    if (XPE ~= "" or nil) or (QPE ~= "" or nil) or (QTE ~= "" or nil) then

      if (XPE ~= "") then
        cecho("StatsConsole", "<grey>2x XP:<white>        "..XPE.."\n")
      end
       
      if (QPE ~= "") then
        cecho("StatsConsole", "<grey>2x QP:<white>        "..QPE.."\n")
      end
       
      if (QTE ~= "") then
        cecho("StatsConsole", "<grey>No Quest Timer:<white>"..QTE.."\n")
      end
       
    else
        cecho("StatsConsole", "<grey>No Events Active.\n")
    end
      
         
     
end

registerAnonymousEventHandler("GUI_UpdateStatus", "UpdateStatus")