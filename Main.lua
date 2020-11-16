local _, PinHelper = ...;

SLASH_MapPinHelper1 = '/pin';

function SlashCmdList.MapPinHelper(msg, editbox)
	if msg == "clear" then
		C_Map.ClearUserWaypoint()
		print("Clearing active map pin.")
	else
		local options = {}
		local searchResult = { string.match(msg,"^(%d+)%s(%d+)$") }
		for i,v in pairs(searchResult) do
        		if (v ~= nil and v ~= "") then
            		options[i] = v
       		 end
    	end

	if #options == 2 then
		x=(options[1] / 100);
		y=(options[2] / 100);
	
		map=C_Map;
		player='player';
		location=map.GetBestMapForUnit(player);
		map.SetUserWaypoint(UiMapPoint.CreateFromCoordinates(location,x,y));
		print("Creating new map pin at " .. options[1] .. " - " .. options[2])
	else
		print("Map Pin Helper Commands")
		print("----------------------------")
		print(" - Must supply coordinates (two numbers) for example: /pin 42 42")
		print(" - You can also clear pins with: /pin clear")
		print("----------------------------")
	end
end
end