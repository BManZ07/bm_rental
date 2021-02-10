ESX              = nil
local PlayerData = {}
local isNear = false
local isInMarker = false
local menuOpen = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
    end
end)


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local veh = GetVehiclePedIsIn(playerPed, false) 
		local isInCar = IsPedInVehicle(playerPed, veh, false)

		local coords = GetEntityCoords(playerPed)
		if isNear == true then
			DrawMarker(1, 4513.8706054688, -4523.6484375, 3.2231163978577, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.5, 1.5, 1.5, 0, 0, 255, 100, false, true, 2, false, nil, nil, false)
			if isInMarker == true then
				if not menuOpen then
					ESX.ShowHelpNotification("Press ~INPUT_CONTEXT~ to rent car.")

					if IsControlJustReleased(0, 38) then
						menuOpen = true
						OpenRentalMenu()
					end
				end
			else
				if menuOpen then
					menuOpen = false
					ESX.UI.Menu.CloseAll()
				end
			end
		end		
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(500)
		local playerPed = PlayerPedId()
		local veh = GetVehiclePedIsIn(playerPed, false) 
		local isInCar = IsPedInVehicle(playerPed, veh, false)
		local coords = GetEntityCoords(playerPed)

		if GetDistanceBetweenCoords(coords, 4513.8706054688, -4523.6484375, 3.2231163978577, true) < 15.0 then
			isNear = true
		else
			isNear = false
		end

		if GetDistanceBetweenCoords(coords, 4513.8706054688, -4523.6484375, 3.2231163978577, true) < 2.0 then
			isInMarker = true
		else
			isInMarker = false
		end

	end
end)


function OpenRentalMenu(island)
    local elements = {}
    local ped = GetPlayerPed(-1)
    local veh = GetVehiclePedIsIn(ped, false)

	table.insert(elements, {label = "Rent Vehicle",     value = 'rent'})
	table.insert(elements, {label = "Return Vehicle",     value = 'return'})


	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'extras', {
		title    = "Vehicle Rental",
		align    = 'top-left',
		elements = elements
	}, function(data, menu)

		if data.current.value == 'rent' then
			VehiclesMenu()
		else
			DeleteVehicle(GetVehiclePedIsIn(GetPlayerPed(-1)))
		end

	end, function(data, menu)
		menu.close()
	end)
end

function VehiclesMenu(island)
    local elements = {}
    local ped = GetPlayerPed(-1)

	table.insert(elements, {label = "Verus | $100",     value = 'verus'})
	table.insert(elements, {label = "Manchez | $100",     value = 'manchez'})
	table.insert(elements, {label = "Winky | $200",     value = 'winky'})
	table.insert(elements, {label = "Rumpo Trail | $1000",     value = 'rumpo'})
	table.insert(elements, {label = "Chevy Suburban | $1000",     value = 'chevy'})


	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'extras', {
		title    = "Vehicles",
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
			
		ESX.TriggerServerCallback('nrv_rental:getMoney', function(playerMoney) 
			if data.current.value == 'verus' then
				if playerMoney >= 100 then
					local vehHash = GetHashKey('verus')
					RequestModel(vehHash)
					Wait(1000)
					CreateVehicle(vehHash, 4511.11, -4515.73, 4.13, 19.91, 1, 0)
					Wait(10)
					TriggerServerEvent('nrv_rental:verus')
				else
					exports['mythic_notify']:DoHudText('error', "Insufficient Funds!")
				end
			elseif data.current.value == 'manchez' then
				if playerMoney >= 100 then
					local vehHash = GetHashKey('manchez2')
					RequestModel(vehHash)
					Wait(1000)
					CreateVehicle(vehHash, 4511.11, -4515.73, 4.13, 19.91, 1, 0)
					Wait(10)
					TriggerServerEvent('nrv_rental:verus')
				else
					exports['mythic_notify']:DoHudText('error', "Insufficient Funds!")
				end
			elseif data.current.value == 'winky' then
				if playerMoney >= 200 then
					local vehHash = GetHashKey('winky')
					RequestModel(vehHash)
					Wait(1000)
					CreateVehicle(vehHash, 4511.11, -4515.73, 4.13, 19.91, 1, 0)
					Wait(10)
					TriggerServerEvent('nrv_rental:winky')
				else
					exports['mythic_notify']:DoHudText('error', "Insufficient Funds!")
				end
			elseif data.current.value == 'rumpo' then
				if playerMoney >= 1000 then
					local vehHash = GetHashKey('rumpo3')
					RequestModel(vehHash)
					Wait(1000)
					CreateVehicle(vehHash, 4511.11, -4515.73, 4.13, 19.91, 1, 0)
					Wait(10)
					TriggerServerEvent('nrv_rental:rumpo')
				else
					exports['mythic_notify']:DoHudText('error', "Insufficient Funds!")
				end
			elseif data.current.value == 'chevy' then
				if playerMoney >= 1000 then
					local vehHash = GetHashKey('subn')
					RequestModel(vehHash)
					Wait(1000)
					CreateVehicle(vehHash, 4511.11, -4515.73, 4.13, 19.91, 1, 0)
					Wait(10)
					TriggerServerEvent('nrv_rental:rumpo')
				else
					exports['mythic_notify']:DoHudText('error', "Insufficient Funds!")
				end
			end
		end)

	end, function(data, menu)
		OpenRentalMenu()
	end)
end
