local Fura = {}
--Меню
Fura.optionEnable = Menu.AddOptionBool({"Hero Specific", "Escape"}, "Enable", false)
Fura.optionKey = Menu.AddKeyOption({"Hero Specific", "Escape"}, "Combo Key", Enum.ButtonCode.KEY_T)


function sleep(ms) 
    local b = os.clock() * 1000 
    while os.clock() * 1000 - b <= ms do end 
end


function Fura.Combo(myHero, sprout, tpout, x)

	myHero = Heroes.GetLocal()
	myMana = NPC.GetMana(myHero)


 sprout = NPC.GetAbility(myHero, "furion_sprout")
 tpout = NPC.GetAbility(myHero, "furion_teleportation")
 

          
          if Menu.IsEnabled(Fura.optionEnable) then
               Ability.CastTarget(sprout, myHero) 
                           end  
                         
delay(1000)

          if  Menu.IsEnabled(Fura.optionEnable) then
              	Ability.CastTarget(tpout, myHero) 
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