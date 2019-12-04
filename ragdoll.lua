

function translateAngle(x1, y1, ang, offset)
  x1 = x1 + math.sin(ang) * offset
  y1 = y1 + math.cos(ang) * offset
  return {x1, y1}
end

function getVelocityPoint( posX, posY, posZ, pointX, pointY, pointZ, strength )
	local vectorX = posX-pointX
	local vectorY = posY-pointY
	local vectorZ = posZ-pointZ
	local length = ( vectorX^2 + vectorY^2 + vectorZ^2 )^0.5
	
	local propX = vectorX^2 / length^2
	local propY = vectorY^2 / length^2
	local propZ = vectorZ^2 / length^2
		
	local finalX = ( strength^2 * propX )^0.5
	local finalY = ( strength^2 * propY )^0.5
	local finalZ = ( strength^2 * propZ )^0.5
	
	if vectorX > 0 then finalX = finalX * -1 end
	if vectorY > 0 then finalY = finalY * -1 end
	if vectorZ > 0 then finalZ = finalZ * -1 end
	
	return finalX, finalY, finalZ
end

local move = false
local ang = 0

function processAngles()
	local up = 0
	local down = 0
	
	local left = 0
	local right = 0
	
	if IsControlPressed(0, `INPUT_MOVE_UP_ONLY`) --[[ UP ]] then
		up = 1
	else
		up = 0
	end
	
	if IsControlPressed(0, `INPUT_MOVE_DOWN_ONLY`) --[[ DOWN ]] then
		down = 1
	else
		down = 0
	end
	
	if IsControlPressed(0, `INPUT_MOVE_LEFT_ONLY`) --[[ LEFT ]] then
		left = 1
	else
		left = 0
	end
	
	if IsControlPressed(0, `INPUT_MOVE_RIGHT_ONLY`) --[[ RIGHT ]] then
		right = 1
	else
		right = 0
	end
	
	if IsControlPressed(0, `INPUT_MOVE_UP_ONLY`) or IsControlPressed(0, `INPUT_MOVE_DOWN_ONLY`) or IsControlPressed(0, `INPUT_MOVE_LEFT_ONLY`) or IsControlPressed(0, `INPUT_MOVE_RIGHT_ONLY`) then
		move = true
	else
		move = false
	end
	
	ang = (up*0)+(down*180)+(left*90)+(right*-90)
end

function ragdollStuff()
	while true do Wait(0)
		processAngles()
		
		if IsControlPressed(0, `INPUT_ENTER`) then
			local ped = PlayerPedId()
			local pos = GetEntityCoords(ped)
			local px, py, pz = table.unpack(pos)
			local rot = GetEntityRotation(ped)
			local rx, ry, rz = table.unpack(rot)
			local cz = GetGameplayCamRelativeHeading()
			local rz = (rz+cz)+ang
			local markPos = translateAngle(px, py, math.rad(-rz), 1)
			local x, y = table.unpack(markPos)
			-- SetPedToRagdollWithFall(PlayerPedId(), 2000, 2000, 2, GetEntityForwardVector(PlayerPedId()), 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
			
			SetPedToRagdoll(PlayerPedId(), 2000, 2000, 3)
			-- GivePlayerRagdollControl(PlayerPedId(), true)
			
			if move then
				local x,y,z=getVelocityPoint(px, py, pz, x, y, pz, 20.0)
				SetEntityVelocity(ped, x, y, z)
			end
			
			-- DrawMarker(1, x, y, pz-1, 0.0, 0.0, 0.0, 0, 0, 0, 1.0, 1.0, 1.0, 255, 255, 0 , 255, false, false, false, false) 
		end
	end
end

Citizen.CreateThread(ragdollStuff)