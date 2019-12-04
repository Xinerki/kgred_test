
local function RequestIpl(iplName)
    Citizen.InvokeNative(0x59767C5A7A9AE6DA, iplName)
end

local function IsIplActive(iplName)
    return Citizen.InvokeNative(0xD779B9B910BD3B7C, iplName, Citizen.ResultAsInteger())
end

local function RemoveIpl(iplName)
    Citizen.InvokeNative(0x5A3E5CF7B4014B96, iplName)
end

ipls = {
	-- Blackwater
	1173561253, -- some camps
	1470738186, -- the fuckin ground
	-1632348233, -- detail
	1081087978, -- more detail?
	
	-- Beecher's Hope
	-974480336, -- house part
	255093300, -- more house
	1467774743, -- yeah
	411742897, -- more
}

Citizen.CreateThread(function()
	for i,v in ipairs(ipls) do
		RequestIpl(v)
	end
end)