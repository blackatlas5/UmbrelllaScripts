local Fura = {}
--Меню
Fura.optionEnable = Menu.AddOptionBool({"Hero Specific", "Escape"}, "Enable", false)
Fura.optionKey = Menu.AddKeyOption({"Hero Specific", "Escape"}, "Combo Key", Enum.ButtonCode.KEY_T)



function Fura.Combo(myHero, sprout, tpout, x)

	myHero = Heroes.GetLocal()
	myMana = NPC.GetMana(myHero)


 sprout = NPC.GetAbility(myHero, "furion_sprout")
 tpout = NPC.GetAbility(myHero, "furion_teleportation")
 

          
          if Menu.IsEnabled(Fura.optionEnable) then
               Ability.CastTarget(sprout, myHero) 
               return
                           end                        


          if  Menu.IsEnabled(Fura.optionEnable) and Abilitu.IsCastable(tpout, myMana) then
              	Ability.CastTarget(tpout, myHero) 
              	return
                           end                                  
 end


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



return Fura
