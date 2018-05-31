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
--првоерка нажатия
  if Menu.IsKeyDown(Fura.optionKey) then
    Fura.Combo(myHero) 
  end

--функция съеба

  local tpout = NPC.GetAbilityByIndex(myHero, 2)
  local sprouts = NPC.GetAbilityByIndex(myHero, 1)
  local X = Ability.GetManaCost(tpout)
  local Y = Ability.GetManaCost(sprout)


  if Fura.heroCanCastSpells(myHero, enemy) == true then
        if not (NPC.HasModifier(myHero, "modifier_item_invisibility_edge_windwalk") then
          if X > 50 and Y > 130 then 
            if Menu.IsEnabled(Fura.optionEnable) then
              Ability.CastTarget(sprout, myHero) and Ability.CastTarget(tpout, myHero)
            end
          end
        end 
  end
       
end




return Fura