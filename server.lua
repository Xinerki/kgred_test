
RegisterServerEvent("test:sendMusicEvent")
AddEventHandler("test:sendMusicEvent", function(event)
	if event then
		print ("MUSIC EVENT '"..event.."' STARTED")
		TriggerClientEvent("test:receiveMusicEvent", -1, event)
	end
end)

RegisterServerEvent("test:sendTimeChange")
AddEventHandler("test:sendTimeChange", function(time)
	if time then
		print ("TIME CHANGED TO "..tonumber(time))
		TriggerClientEvent("test:receiveTimeChange", -1, time)
	end
end)

RegisterServerEvent("test:sendWeatherChange")
AddEventHandler("test:sendWeatherChange", function(weather)
	if weather then
		print ("WEATHER CHANGED TO "..tonumber(weather))
		TriggerClientEvent("test:receiveWeatherChange", -1, weather)
	end
end)