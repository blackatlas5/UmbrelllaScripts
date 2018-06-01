local BountyHunter = {}

BountyHunter.AutoTrack = Menu.AddOptionBool({"Hero Specific", "Bounty Hunter"}, "Enable AutoTracking", false)
BountyHunter.AutoShur = Menu.AddOptionBool({"Hero Specific", "Bounty Hunter"}, "Enable AutoShuriken", false)


function BountyHunter.OnUpdate()
	myHero = Heroes.GetLocal()
	if not myHero or not Menu.IsEnabled(BountyHunter.AutoTrack) or not Entity.IsAlive(myHero) or NPC.GetUnitName(myHero) ~= "npc_dota_hero_bounty_hunter"
	 then return end

	  	
	 	track = NPC.GetAbility(myHero, "bounty_hunter_track")
	 	
	 	if track and Ability.IsReady(track) and Ability.GetManaCost(track) <= NPC.GetMana(myHero) then
	 		
	 		for _,hero in pairs(Heroes.GetAll()) do
	 			if NPC.HasModifier(hero, "modifier_bounty_hunter_track_effect")	then return end
			if hero ~= nil and hero ~= 0 and NPCs.Contains(hero) and NPC.IsEntityInRange(myHero,hero,Ability.GetCastRange(track)) and not Entity.IsSameTeam(hero,myHero) then
				if Entity.IsAlive(hero) and not Entity.IsDormant(hero) and not NPC.IsIllusion(hero) and BountyHunter.IsHasGuard(hero) == "nil" then
					if Entity.GetHealth(hero) < 300 
						or NPC.GetUnitName(hero) == "npc_dota_hero_riki" 
						or NPC.GetUnitName(hero) == "npc_dota_hero_weaver" 
						or NPC.GetUnitName(hero) == "npc_dota_hero_axe" 
						or NPC.GetUnitName(hero) == "npc_dota_hero_antimage" 
						or NPC.GetUnitName(hero) == "npc_dota_hero_invoker" 
						or NPC.GetUnitName(hero) == "npc_dota_hero_queenofpain"
						or NPC.GetUnitName(hero) == "npc_dota_hero_clinkz"
						or NPC.GetUnitName(hero) == "npc_dota_hero_treant"										
						then
						
												Ability.CastTarget(track, hero)
						
					end	
				end
			end 
			
		end			
	 end


	 

	if not myHero or not Menu.IsEnabled(BountyHunter.AutoShur) or not Entity.IsAlive(myHero) or NPC.GetUnitName(myHero) ~= "npc_dota_hero_bounty_hunter"
	 then return end
	 
	 	shuriken = NPC.GetAbility(myHero, "bounty_hunter_shuriken_toss")
	 	
	 	if shuriken and Ability.IsReady(shuriken) and Ability.GetManaCost(shuriken) <= NPC.GetMana(myHero) then
	 		for _,dead in pairs(Heroes.GetAll()) do
			if dead ~= nil and dead ~= 0 and NPCs.Contains(dead) and NPC.IsEntityInRange(myHero,dead,Ability.GetCastRange(shuriken)) and not Entity.IsSameTeam(dead,myHero) then
				if Entity.IsAlive(dead) and not Entity.IsDormant(dead) and not NPC.IsIllusion(dead) and BountyHunter.IsHasGuard(dead) == "nil" then
					
						if  Ability.GetLevel(shuriken) == 1 and Entity.GetHealth(dead) < 90 then 
							Ability.CastTarget(shuriken, dead)
											
											elseif Ability.GetLevel(shuriken) == 2 and Entity.GetHealth(dead) < 140 then 
							Ability.CastTarget(shuriken, dead)
											
											elseif Ability.GetLevel(shuriken) == 3 and Entity.GetHealth(dead) < 200 then 
							Ability.CastTarget(shuriken, dead)
											
											elseif Entity.GetHealth(dead) < 280 then
							Ability.CastTarget(shuriken, dead)
											

						end	
				end
			end
		end			
	 end

end 


function BountyHunter.IsHasGuard(npc)
	local guarditis = "nil"

	if NPC.IsLinkensProtected(npc) then guarditis = "Linkens" end
	if NPC.HasModifier(npc,"modifier_item_blade_mail_reflect") then guarditis = "BM" end
	local spell_shield = NPC.GetAbility(npc, "antimage_spell_shield")
	if spell_shield and Ability.IsReady(spell_shield) and (NPC.HasModifier(npc, "modifier_item_ultimate_scepter") or NPC.HasModifier(npc, "modifier_item_ultimate_scepter_consumed")) then
		guarditis = "Lotus"
	end
	if NPC.HasModifier(npc,"modifier_item_lotus_orb_active") then guarditis = "Lotus" end
	if 	NPC.HasState(npc,Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) or 
		NPC.HasState(npc,Enum.ModifierState.MODIFIER_STATE_OUT_OF_GAME) or
		NPC.HasModifier(npc,"modifier_medusa_stone_gaze_stone") or
		NPC.HasModifier(npc,"modifier_winter_wyvern_winters_curse") or
		NPC.HasModifier(npc,"modifier_templar_assassin_refraction_absorb") or
		NPC.HasModifier(npc,"modifier_nyx_assassin_spiked_carapace") or
		NPC.HasModifier(npc,"modifier_abaddon_borrowed_time") or
		NPC.HasModifier(npc,"modifier_item_aeon_disk_buff") or
		NPC.HasModifier(npc,"modifier_special_bonus_spell_block") then
			guarditis = "Immune"
	end
	if NPC.HasModifier(npc,"modifier_legion_commander_duel") then
		local duel = NPC.GetAbility(npc, "legion_commander_duel")
		if duel then
			if NPC.HasModifier(npc, "modifier_item_ultimate_scepter") or NPC.HasModifier(npc, "modifier_item_ultimate_scepter_consumed") then
				guarditis = "Immune"
			end
		else
			for _,hero in pairs(Heroes.GetAll()) do
				if hero ~= nil and hero ~= 0 and NPCs.Contains(hero) and not Entity.IsSameTeam(hero,npc) and NPC.HasModifier(hero,"modifier_legion_commander_duel") then
					local dueltarget = NPC.GetAbility(hero, "legion_commander_duel")
					if dueltarget then
						if NPC.HasModifier(hero, "modifier_item_ultimate_scepter") or NPC.HasModifier(hero, "modifier_item_ultimate_scepter_consumed") then
							guarditis = "Immune"
						end
					end
				end
			end
		end
	end
	local aeon_disk = NPC.GetItem(npc, "item_aeon_disk")
	if aeon_disk and Ability.IsReady(aeon_disk) then guarditis = "Immune" end
	return guarditis
end





return BountyHunter