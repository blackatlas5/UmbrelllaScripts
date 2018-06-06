local Sven = {}

enemy = nil
me = nil



Sven.Enable = Menu.AddOptionBool({ "Hero Specific", "Sven" }, "Enable Combo?", false)
Sven.Key = Menu.AddKeyOption({ "Hero Specific", "Sven" }, "Combo Key", Enum.ButtonCode.BUTTON_CODE_NONE)
Sven.AddWarcry = Menu.AddOptionBool({"Hero Specific", "Sven", "Combo"}, "WarCry", false)
Sven.AddUltimate = Menu.AddOptionBool({"Hero Specific", "Sven", "Combo"}, "Ultimate", false)
Sven.AddBKB = Menu.AddOptionBool({"Hero Specific", "Sven", "Combo"}, "BKB", false)
Sven.AddSatanic = Menu.AddOptionBool({"Hero Specific", "Sven", "Auto Satanic"}, "Enable", false)
Sven.AddBloodthorn = Menu.AddOptionBool({"Hero Specific", "Sven", "Combo"}, "Bloodthorn", false)
Sven.AddStun = Menu.AddOptionBool({"Hero Specific", "Sven", "Combo"}, "Stun", false)
Sven.AddBlink = Menu.AddOptionBool({"Hero Specific", "Sven", "Combo"}, "Blink Dagger", false)
Sven.AddMOM = Menu.AddOptionBool({"Hero Specific", "Sven", "Combo"}, "Mask Of Madn@ss", false)
Sven.Satan = Menu.AddOptionSlider({"Hero Specific", "Sven", "Auto Satanic"}, "hp for acrivation", 400, 2000, 1000)

function Sven.OnUpdate()
  

  me = Heroes.GetLocal()
  mana = NPC.GetMana(me)
  hp = Menu.GetValue(Sven.Satan)

    if not me or NPC.GetUnitName(me) ~= "npc_dota_hero_sven" then return end

    if Menu.IsKeyDown(Sven.Key) and Menu.IsEnabled(Sven.Enable) then Sven.Combo(me, enemy) end
    satanic = NPC.GetItem(me, "item_satanic")
    if satanic and Entity.GetHealth(me) < hp and Menu.IsEnabled(Sven.AddSatanic) and Ability.IsCastable(satanic, mana) and Ability.IsReady(satanic) then
              Ability.CastNoTarget(satanic)
            return
            end

end

function Sven.Combo(me, enemy)

      enemy = Input.GetNearestHeroToCursor(Entity.GetTeamNum(me), Enum.TeamType.TEAM_ENEMY)
      warcry = NPC.GetAbility(me, "sven_warcry")
      stun = NPC.GetAbility(me, "sven_storm_bolt")
      ultimate = NPC.GetAbility(me, "sven_gods_strength")
      bkb = NPC.GetItem(me, "item_black_king_bar")
      blink = NPC.GetItem(me, "item_blink")
      mom = NPC.GetItem(me, "item_mask_of_madness")
      bloodthorn = NPC.GetItem(me, "item_bloodthorn")



      if Entity.IsSameTeam(enemy,me) then return end
      if Entity.GetHealth(enemy) > 0 then




if warcry and Menu.IsEnabled(Sven.AddWarcry) and Ability.IsCastable(warcry, mana) and Ability.IsReady(warcry) then
  Ability.CastNoTarget(warcry)
return
end

if bkb and Menu.IsEnabled(Sven.AddBKB) and Ability.IsCastable(bkb, mana) and Ability.IsReady(bkb) then
  Ability.CastNoTarget(bkb)
 return
end

if ultimate and Menu.IsEnabled(Sven.AddUltimate) and Ability.IsCastable(ultimate, mana) and Ability.IsReady(ultimate) then
  Ability.CastNoTarget(ultimate)
 return
end

if blink and Menu.IsEnabled(Sven.AddBlink) and Ability.IsReady(blink) then
   Ability.CastPosition(blink, Entity.GetAbsOrigin(enemy))
  return
end

if not NPC.IsLinkensProtected(enemy) and bloodthorn and Menu.IsEnabled(Sven.AddBloodthorn) and Ability.IsReady(bloodthorn) then
   Ability.CastTarget(bloodthorn, enemy)
  return
end


over = Entity.GetHeroesInRadius(enemy, 255, Enum.TeamType.TEAM_FRIEND)





if NPC.IsLinkensProtected(enemy) then
  for _,hero in pairs(over) do
  if stun and Menu.IsEnabled(Sven.AddStun) and Ability.IsCastable(stun, mana) and Ability.IsReady(stun) then
     Ability.CastTarget(stun, hero)
else
   if stun and Menu.IsEnabled(Sven.AddStun) and Ability.IsCastable(stun, mana) and Ability.IsReady(stun) then
   Ability.CastTarget(stun, enemy)
 return
end
end
end
end




if mom and Menu.IsEnabled(Sven.AddMOM) and Ability.IsCastable(mom, mana) and Ability.IsReady(mom) then
   Ability.CastNoTarget(mom)
  return
end

        end

end

return Sven
