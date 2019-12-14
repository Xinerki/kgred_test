
Citizen.CreateThread(function()
	view1=CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
	SetCamCoord(view1, 10.5, 13.6, 75.3)
	SetCamRot(view1, 0.0, 0.0, 180.0, 0.0)
	SetCamFov(view1, 45.0)
end)

function translateAngle(x1, y1, ang, offset)
  x1 = x1 + math.sin(ang) * offset
  y1 = y1 + math.cos(ang) * offset
  return {x1, y1}
end

camEnabled = false

Citizen.CreateThread(function()
	while true do Wait(0)
		localPlayer = PlayerPedId()

		if camEnabled then
			-- if IsPedInAnyVehicle(localPlayer, false) == 1 then
				-- x,y,z = table.unpack(GetEntityCoords(GetVehiclePedIsIn(localPlayer, false)))
				-- rotx, roty, rotz = table.unpack(GetEntityRotation(GetVehiclePedIsIn(localPlayer, false)))
				
				-- if IsEntityUpsidedown(GetVehiclePedIsIn(localPlayer, false)) == 1 then 
					-- rotz = -rotz 
				-- end
				
				-- speed = GetEntitySpeed(GetVehiclePedIsIn(localPlayer, false))/2
				-- local ang = 0
				-- local cz = GetGameplayCamRelativeHeading()
				-- local rz = (rotz+cz)+ang
				-- local markPos = translateAngle(x, y, math.rad(-rz), -15+speed/4)
				-- local x, y = table.unpack(markPos)
				-- SetCamCoord(view1, x, y, z+25)
				-- SetCamRot(view1, -50.0, 0.0, rz)
				
			-- else
				x,y,z = table.unpack(GetEntityCoords(localPlayer))
				rotz = GetEntityHeading(localPlayer)
				
				if IsEntityUpsidedown(GetVehiclePedIsIn(localPlayer, false)) == 1 then 
					rotz = -rotz 
				end
				
				local ang = 0
				local cz = GetGameplayCamRelativeHeading()
				local rz = (rotz+cz)+ang
				local markPos = translateAngle(x, y, math.rad(-rz), -15)
				local x, y = table.unpack(markPos)
				SetCamCoord(view1, x, y, z+25)
				SetCamRot(view1, -50.0, 0.0, rz)
			-- end
		end
	end
end)

RegisterCommand('td', function()
	print("swapping to " .. tostring(not camEnabled) .. "\n")
	camEnabled = not camEnabled
	-- RenderScriptCams(p0, p1, p2, p3, p4, p5)
	print(RenderScriptCams(camEnabled, 1, 500, true, true))
end)