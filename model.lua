local function PerformRequest(hash)
    print("requesting model " .. hash)

    RequestModel(hash, 0) -- RequestModel

    local times = 1

    print("requested " .. times .. " times")

    while not Citizen.InvokeNative(0x1283B8B89DD5D1B6, hash) do -- HasModelLoaded
        Citizen.InvokeNative(0xFA28FE3A6246FC30, hash, 0) -- RequestModel

        times = times + 1

        print("requested " .. times .. " times")

        Citizen.Wait(0)
		
		if times >= 100 then break end
    end
end
		
function lePlayerModel(name)
	local model = GetHashKey(name)
	local player = PlayerId()
	
	if not IsModelValid(model) then return end
	PerformRequest(model)
	
	if HasModelLoaded(model) then
		-- SetPlayerModel(player, model, false)
		Citizen.InvokeNative(0xED40380076A31506, player, model, false)
		Citizen.InvokeNative(0x283978A15512B2FE, PlayerPedId(), true)
		SetModelAsNoLongerNeeded(model)
	end
end

RegisterCommand('model', function(source, args)
	CreateThread(function()
		if args[1] then
			if IsModelValid(GetHashKey(args[1])) then
				lePlayerModel(args[1])
			end
		end
	end)
end)

RegisterCommand('outfit', function(source, args)
	CreateThread(function()
		if args[1] then
			SetPedOutfitPreset(PlayerPedId(), tonumber(args[1]), 1)
			-- martson's cowboy outfit is 26
		end
	end)
end)