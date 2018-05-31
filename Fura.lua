local Fura = {}
--Меню
Fura.optionEnable = Menu.AddOptionBool({"Hero Specific", "Escape"}, "Enable", false)
Fura.optionKey = Menu.AddKeyOption({"Hero Specific", "Escape"}, "Combo Key", Enum.ButtonCode.KEY_T)

function Fura.OnUpdate()
  --Проверка пикнутого героя
  if not Menu.IsEnabled(Fura.optionEnable) or not Engine.IsInGame() or not Heroes.GetLocal() then 
    return 
  end
  local myHero = Heroes.GetLocal()
  if NPC.GetUnitName(myHero) ~= "npc_dota_hero_furion" then 
    return 
  end

  if Menu.IsKeyDown(Fura.optionKey) then
    Fura.Combo(myHero) 
  end

end

function Fura.Combo()
--функция съеба       
          
          if Menu.IsEnabled(Fura.optionEnable) then
                          Ability.CastTarget(NPC.GetAbilityByIndex(myHero, 1), myHero)  
                            then
               Ability.CastTarget(NPC.GetAbilityByIndex(myHero, 2), myHero)
            end                
  

end




return Fura