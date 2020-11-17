local _, PinHelper = ...;

SLASH_MapPinHelper1 = '/pin';

function MapPinHelper_HelpText()
	print("Map Pin Helper Commands Function")
	print("----------------------------")
	print(" - Must supply coordinates (two numbers) for example: /pin 42 42")
	print(" - Note that valid coordinates are between 0 - 100")
	print(" - You can also clear pins with: /pin clear")
	print("----------------------------")
end

function mysplit(inputString)
        separator = "%s"
        local t={}
        for str in string.gmatch(inputString, "([^"..separator.."]+)") do
                table.insert(t, str)
        end
        return t
end

function MapPinHelper_DoPin(options)
	valid = false
	if #options == 2 then
		x = options[1]
		y = options[2]
		valid = true
	end
	if (valid and x<=1 and y<=1) then
		map=C_Map;
		player='player';
		location=map.GetBestMapForUnit(player);
		map.SetUserWaypoint(UiMapPoint.CreateFromCoordinates(location,x,y));
		hyperlink = C_Map.GetUserWaypointHyperlink()
		print("Creating new map pin at (x" .. (options[1] * 100) .. ", y" .. (options[2] * 100) .. ") : " .. hyperlink)
		C_SuperTrack.SetSuperTrackedUserWaypoint(true)
	else
		MapPinHelper_HelpText()
end

end

function SlashCmdList.MapPinHelper(msg, editbox)
	if msg == "clear" then
		C_Map.ClearUserWaypoint()
		C_SuperTrack.SetSuperTrackedUserWaypoint(false)
		print("Clearing active map pin.")
	else
		local options = {}
		terms = mysplit(msg)
		for key, value in pairs(terms) do
			foundDot = false
			if string.find(value, "%.") or string.find(value,"%,") then
				foundDot = true
			end
			value = value:gsub("%.", "")
			value = value:gsub("%,", "")
			value = string.match(value,"^(%d+)$")
			if value then
				if foundDot then
					n = string.len(value)
					value = (value / (10^n))
				else
					value = (value/(10^2))
				end
				table.insert(options,value)
			end
		end
		MapPinHelper_DoPin(options)
end

end