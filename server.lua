local QBCore = exports['qb-core']:GetCoreObject()
--============================================================================ Items

QBCore.Functions.CreateUseableItem("anchor", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
		TriggerClientEvent('fishing:client:anchor', source)
    end
end)

QBCore.Functions.CreateUseableItem("fishingrod", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
 		TriggerClientEvent('fishing:fishstart', source)
    end
end)

QBCore.Functions.CreateUseableItem("fishicebox", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
		TriggerClientEvent('fishing:client:useFishingBox', source, item.info.boxid)  
    end
end)



QBCore.Functions.CreateUseableItem("fishingloot", function(source, item)
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
		Player.Functions.RemoveItem("fishingloot", 1)
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['fishingloot'], "remove", 1)
		TriggerClientEvent('QBCore:Notify', src, "Opening Box", "primary")
		SetTimeout(1000, function()
			Player.Functions.AddItem('fishingkey', 1, nil, {["quality"] = 100}) 
			TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['fishingkey'], "add", 1)

			Player.Functions.AddItem(Config.smallLootboxReward, 1, nil, {["quality"] = 100}) 
			TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config.smallLootboxReward], "add", 1)

			Player.Functions.AddMoney('cash', Config.smallLootboxCash, "fishingloot")
			TriggerClientEvent('QBCore:Notify', src, "You found a couple items and $"..Config.smallLootboxCash, "success")
		end)
    end
end)

QBCore.Functions.CreateUseableItem("fishtacklebox", function(source, item)
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then

		TriggerClientEvent('QBCore:Notify', src, "Opening Tackel Box", "success")
		Player.Functions.RemoveItem("fishtacklebox", 1)
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['fishtacklebox'], "remove", 1)

		SetTimeout(1250, function()
			Player.Functions.AddItem('pearlscard', 1, nil, {["quality"] = 100}) 
			TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['pearlscard'], "add", 1)
		end)
    end
end)

--============================================================================ Events

RegisterNetEvent('fishing:server:removeFishingBait', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(source)
    Player.Functions.RemoveItem('fishbait', 1)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['fishbait'], "remove", 1)
end)

RegisterNetEvent("fishing:server:addTackleBox", function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	TriggerClientEvent('QBCore:Notify', src, "There seems to tackle box left over from another fisherman", "primary")
	SetTimeout(1000, function()
		Player.Functions.AddItem('fishtacklebox', 1, nil, {["quality"] = 100}) 
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['fishtacklebox'], "add", 1)
	end)
end) 


RegisterNetEvent('fishing:server:catch', function() 
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local luck = math.random(1, 100)
    local itemFound = true
    local itemCount = 1

    if itemFound then
        for i = 1, itemCount, 1 do
            if luck == 100 then
				local weight = math.random(850,1000)
				local info = {species = "Orca",lbs = weight,type = "Exotic"}
				TriggerClientEvent('fishing:client:spawnFish', src, 1)
				Player.Functions.AddItem('killerwhale', 1, nil, info, {["quality"] = 100})
				TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['killerwhale'], "add", 1)
				TriggerClientEvent('QBCore:Notify', src, "You caught a killer whale!\nThese are endangered species and are illegal to possess", "primary")
			elseif luck >= 95 and luck <= 100 then
				Player.Functions.AddItem('fishinglootbig', 1, nil, {["quality"] = 100})
				TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['fishinglootbig'], "add", 1)
				TriggerClientEvent('QBCore:Notify', src, "You found a Treasure Chest!", "success")
			elseif luck >= 90 and luck <= 95 then
				local weight = math.random(10,28)
				local info = {species = "Bottlenose",lbs = weight, type = "Exotic"}
				TriggerClientEvent('fishing:client:spawnFish', src, 2)
				Player.Functions.AddItem('dolphin', 1, nil, info, {["quality"] = 100})
				TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['dolphin'], "add", 1)
				TriggerClientEvent('QBCore:Notify', src, "You caught a dolphin!\nThese are endangered species and are illegal to possess", "primary")
			elseif luck >= 85 and luck <= 90 then
				local weight = math.random(20,30)
				local info = {species = "Hammerhead Shark", lbs = weight, type = "Exotic"}
				TriggerClientEvent('fishing:client:spawnFish', src, 3)
				Player.Functions.AddItem('sharkhammer', 1, nil, info, {["quality"] = 100})
				TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['sharkhammer'], "add", 1)
				TriggerClientEvent('QBCore:Notify', src, "You caught a hammerhead shark!\nThese are endangered species and are illegal to possess", "primary")
			elseif luck >= 80 and luck <= 85 then
				local weight = math.random(1,6)
				local info = {species = "Tiger Shark", lbs = weight, type = "Exotic"}
				TriggerClientEvent('fishing:client:spawnFish', src, 4)
				Player.Functions.AddItem('sharktiger', 1, nil, info, {["quality"] = 100})
				TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['sharktiger'], "add", 1)
				TriggerClientEvent('QBCore:Notify', src, "You caught a tiger shark!\nThese are endangered species and are illegal to possess", "primary")
			elseif luck >= 75 and luck <= 80 then
				local weight = math.random(4,9)
				local info = {species = "Manta ray", lbs = weight, type = "Normal"}
				TriggerClientEvent('fishing:client:spawnFish', src, 5)
				Player.Functions.AddItem('stingray', 1, nil, info, {["quality"] = 100})
				TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['stingray'], "add", 1)
				TriggerClientEvent('QBCore:Notify', src, "You caught a "..weight.."lbs Stingray!", "success")
			elseif luck >= 70 and luck <= 75 then
				local weight = math.random(10,15)
				local info = {species = "Flounder", lbs = weight, type = "Normal"}
				TriggerClientEvent('fishing:client:spawnFish', src, 6)
				Player.Functions.AddItem('flounder', 1, nil, info, {["quality"] = 100})
				TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['flounder'], "add", 1)
				TriggerClientEvent('QBCore:Notify', src, "You caught a " .. weight .. "lbs Flounder", "success")
			elseif luck >= 65 and luck <= 70 then
				Player.Functions.AddItem('fishingboot', 1, nil, {["quality"] = 100})
				TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['fishingboot'], "add", 1)
				TriggerClientEvent('QBCore:Notify', src, "You caught a fishing boot!", "primary")
			elseif luck >= 60 and luck <= 65 then
				local weight = math.random(1,6)
				local info = {species = "Bass", lbs = weight, type = "Normal"}
				TriggerClientEvent('fishing:client:spawnFish', src, 6)
				Player.Functions.AddItem('bass', 1, nil, info, {["quality"] = 100})
				TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['bass'], "add", 1)
				TriggerClientEvent('QBCore:Notify', src, "You caught a " .. weight .. "lbs Bass", "success")
			elseif luck >= 55 and luck <= 60 then
				Player.Functions.AddItem('fishingloot', 1, nil, {["quality"] = 100})
				TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['fishingloot'], "add", 1)
				TriggerClientEvent('QBCore:Notify', src, "You found a small box!", "success")
			elseif luck >= 50 and luck <= 55 then
				local weight = math.random(5,7)
				local info = {species = "Cod", lbs = weight, type = "Normal"}
				TriggerClientEvent('fishing:client:spawnFish', src, 6)
				Player.Functions.AddItem('codfish', 1, nil, info, {["quality"] = 100})
				TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['codfish'], "add", 1)
				TriggerClientEvent('QBCore:Notify', src, "You caught a " .. weight .. "lbs  Cod", "success")
			elseif luck >= 45 and luck <= 50 then
				Player.Functions.AddItem('fishingtin', 1, nil, {["quality"] = 100})
				TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['fishingtin'], "add", 1)
				TriggerClientEvent('QBCore:Notify', src, "You caught a fishing tin!", "primary")
			elseif luck >= 0 and luck <= 45 then
				local weight = math.random(1,5)
				local info = {species = "Mackerel", lbs = weight, type = "Normal"}
				TriggerClientEvent('fishing:client:spawnFish', src, 6)
				Player.Functions.AddItem('mackerel', 1, nil, info, {["quality"] = 100})
				TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['mackerel'], "add", 1)
				TriggerClientEvent('QBCore:Notify', src, "You caught a " .. weight .. "lbs Mackerel", "success")
            end
            Citizen.Wait(500)
        end
    end
end)






