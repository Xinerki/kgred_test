RegisterCommand('crun', function(source, args, rawCommand)
	RunCode('return ' .. rawCommand:sub(5))
end, false)



function RunCode(code)
	local code, err = load(code, '@runcode')

	if err then
		print(err)
		return nil, err
	end

	local status, result = pcall(code)
	print(result)

	if status then
		return result
	else
		return nil, result
	end
end


-- p = PlayerId()
function p()
	return PlayerId()
end

-- ps = GetPlayerServerId(PlayerId())
function ps()
	return GetPlayerServerId(PlayerId())
end

-- ped = PlayerPedId()
function ped()
	return PlayerPedId()
end

-- pv = PlayerVehicle
function pv()
	return GetVehiclePedIsIn(ped(), false)
end

-- lpv = LastPlayerVehicle
function lpv()
	return GetVehiclePedIsIn(ped(), true)
end

-- fix = Fixes the specified vehicle
function fix(veh)
	SetVehicleFixed(veh)
	return ""
end
