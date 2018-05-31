local Timber = {}

Timber.optionEnable = Menu.AddOptionBool({"Hero Specific", "Timbersaw"}, "Enable", false)
Timber.optionKey = Menu.AddKeyOption({"Hero Specific", "Timbersaw"}, "Combo Key", Enum.ButtonCode.KEY_T)

function Timber.OnUpdate()
	if not Menu.IsEnabled(Timber.optionEnable) then return end
	local myHero = Heroes.GetLocal()
	if not myHero then return end
	if not Entity.IsAlive(myHero) or NPC.IsStunned(myHero) or NPC.GetUnitName(myHero) ~= "npc_dota_hero_timbersaw" then return end



local enemy = Input.GetNearestHeroToCursor(Entity.GetTeamNum(myHero), Enum.TeamType.TEAM_ENEMY, )
--Первый скилл
local Q = NPC.GetAbility(myHero, "timbersaw_whirling_death")
if enemy and Entity.IsAlive(enemy) then
      if Timber.heroCanCastSpells(myHero, enemy) == true then
      	if Ability.IsCastable(Q, myMana) then
      		Ability.CastTarget(Q, myHero)
      		return
      	end
      end
  end
end

return Timber