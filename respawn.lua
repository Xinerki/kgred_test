local function chatMessage(msg)
	TriggerEvent('chatMessage', '', {0, 0, 0}, msg)
end

alreadyDead = false

function processDeathEvent()
	while true do
		Wait (0)
		-- SetPedDropsWeaponsWhenDead(PlayerPedId(), true)
		
		if IsPedDeadOrDying(PlayerPedId()) == 1 then
			if alreadyDead == false then
				alreadyDead = true
				Citizen.CreateThread(onPlayerDead)
			end
		end
		
		if IsPedDeadOrDying(PlayerPedId()) == false then
			if alreadyDead == true then
				alreadyDead = false
				Citizen.CreateThread(onPlayerNotDeadAnymore)
			end
		end
	end
end

function processScreenFilter()
	ClearTimecycleModifier()
	SetTimecycleModifier("dying")
	while true do
		Wait(500)
		
		local player = PlayerPedId()
		maxh = GetEntityMaxHealth(player)
		h = GetEntityHealth(player)
		float = 1.0-h/maxh
		
		if float >= 1.0 then float = 0.5 end
		
		-- SetTextFont( 4 )
		-- SetTextProportional( 0 )
		-- SetTextScale( 0.5, 0.5 )
		-- SetTextColour( 255, 255, 255, 255 )
		-- SetTextDropShadow( 0, 0, 0, 0, 255 )
		-- SetTextEdge( 1, 0, 0, 0, 255 )
		-- SetTextEntry( "STRING" )
		-- AddTextComponentString( tostring(float*2) )
		-- DrawText( 0.015, 0.015 )
		
		SetTimecycleModifierStrength(float*2)
	end
end

Citizen.CreateThread(processDeathEvent)
-- Citizen.CreateThread(processScreenFilter)

function StartMusicEvent(event)
	PrepareMusicEvent(event)
	return TriggerMusicEvent(event) == 1
end

function onPlayerDead()
	-- SetTimecycleModifier("DeathFailClarity")
	
	-- Wait(500)
	
	-- StartMusicEvent("RESPAWN_CLOUDS_START")

	-- DoScreenFadeOut(0)

	local killer = GetPedSourceOfDeath(PlayerPedId())
	if killer and IsEntityAPed(killer) and killer ~= PlayerPedId() then
		SetGameplayEntityHint(killer, 0.0, 0.0, 1.0, true, -1, 1000, 1000, 1)
		-- AddOwnedExplosion(PlayerPedId(), GetEntityCoords(killer), 11, 1.0, true, false, true)
		
		-- if IsPedAPlayer(killer) then
			-- local pName = GetPlayerName(PlayerPedId())
			-- local kName = GetPlayerName(killer)
			-- chatMessage(kName .. " killed "..pName)
		-- end
	end
	-- print("killer = "..killer or "none!")
	
	Wait(1000)
	
	repeat Wait(0) 
		if IsControlJustPressed(0, "INPUT_ENTER") then
			if killer and IsEntityAPed(killer) and killer ~= PlayerPedId() then
				DoScreenFadeOut(250)
				Wait(250)
				NetworkSetInSpectatorMode(true, killer)
				DoScreenFadeIn(250)
			end
		end
	until IsControlJustPressed(0, "INPUT_ATTACK") or IsControlJustPressed(0, "INPUT_JUMP")
	
	
	DoScreenFadeOut(1500)
	
	Wait(1500+500)
	
	local x, y, z = table.unpack(GetEntityCoords(PlayerPedId()))
	
	local x = x + math.random(-50, 50)
	local y = y + math.random(-50, 50)
	-- local z = z + math.random(-50, 50) -- what the fuck why did i do this?!?!
	
	success, vec3, heading = GetRandomVehicleNode(x,y,z, 50.0, 1, true, true)
	
	if success then
		x, y, z = table.unpack(vec3)
	end
	
	local success, vec3 = GetSafeCoordForPed(x, y, z, false, 16)
	local x, y, z = table.unpack(vec3)
		
	NetworkResurrectLocalPlayer(x, y, z-1.0, heading, true, true, true)
	
	ClearTimecycleModifier()
	NetworkSetInSpectatorMode(false, killer)
	StopGameplayHint(1000)
	-- StartMusicEvent("RESPAWN_CLOUDS_STOP")
	
	ShakeGameplayCam("JUMPCUT_SHAKE",  1.0)
	DoScreenFadeIn(250)
	Wait(250)

end

function onPlayerNotDeadAnymore()
	-- ClearTimecycleModifier()
	-- ClearPedBloodDamage(PlayerPedId())
	-- ClearPedFacialDecorations(PlayerPedId())
	-- StartPlayerSwitch(PlayerPedId(), PlayerPedId(), 0, 2)
	-- SwitchInPlayer(PlayerPedId())
end
	-- StopPlayerSwitch()
	ClearTimecycleModifier()
	-- SetTimecycleModifier("v_bahama")