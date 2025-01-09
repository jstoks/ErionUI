-- Function to redraw Bottom Status Console UI

function UpdatePrompt (event, CHP, MHP, CMP, MMP, THP, TNM, LMP, PRE, PHP)
  clearWindow("StatusBar")

  --Prompt Line 1
  cecho("StatusBar","== [HP: ")
  if (CHP/MHP) >= 0.66 then 
    cecho("StatusBar","<green>"..CHP.."<grey>/")
  elseif (CHP/MHP) >= 0.33 then 
    cecho("StatusBar","<yellow>"..CHP.."<grey>/") 
  else
    cecho("StatusBar","<red>"..CHP.."<grey>/")
  end
  cecho("StatusBar","<green>"..MHP.."<grey>] [MP: ")
  
  if (CMP/MMP) >= 0.66 then
    cecho("StatusBar","<cyan>"..CMP.."<grey>/")
  elseif (CMP/MMP) >= 0.33 then
    cecho("StatusBar","<yellow>"..CMP.."<grey>/")
  else
    cecho("StatusBar","<red>"..CMP.."<grey>/")
  end
  cecho("StatusBar","<cyan>"..MMP.."<grey>] [Limit: ")

  if (LMP ~= "100" or " 100") then
    cecho("StatusBar", "<purple>"..LMP.."%<grey>]")
  else
    cecho("StatusBar", "<purple>READY!<grey>]")
  end
  if PRE ~= "" then
    CPRE = ansi2string(PRE)
    cecho("StatusBar", " <red>"..PRE.." <grey>==\n")
  else
    cecho("StatusBar", " <grey>== \n")
  end
  
  -- Prompt Line 2
  
  if (TNM == "") then
    cecho("StatusBar", "<grey>== [Target: <white>None<grey>] ")
  else
    CTNM = ansi2string(TNM)
    CTHP = ansi2string(THP)
    cecho("StatusBar", "<grey>== [Target: <white>")
    cecho("StatusBar", "<white>"..CTNM.."<grey> (HP: <red>"..CTHP.."<grey>) ] ")
  end
  
  if PHP == "" then
    cecho("StatusBar", "<grey>==\n")
  else
    cecho("StatusBar", "<grey>[Pets: ")
    cecho("StatusBar", "<white>"..PHP.."<grey>] ==\n")
  end
  
  hp = tonumber(CHP)
  hp_max = tonumber(MHP)
  hp_dec = (hp/hp_max)*100
  hp_per = round(hp_dec, 0)
  hpbar:setValue(hp,hp_max)
  hpbar:setText("HP: "..hp_per.."%")
  
  mp = tonumber(CMP)
  mp_max = tonumber(MMP)
  mp_dec = (mp/mp_max)*100
  mp_per = round(mp_dec, 0)
  enbar:setValue(mp,mp_max)
  enbar:setText("MP: "..mp_per.."%")
  
  
  
end

registerAnonymousEventHandler("GUI_UpdatePrompt", "UpdatePrompt")