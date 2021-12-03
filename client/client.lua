ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

local tint = nil

RegisterCommand("checktint", function()
    if ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' then
        local vehicle, distance = ESX.Game.GetClosestVehicle()
        local playerPed = PlayerPedId()
        if vehicle and distance <= 2 then

            ExecuteCommand("me Přikládá tint metr na sklo")
            RequestAnimDict('weapons@first_person@aim_rng@generic@projectile@sticky_bomb@')
                while not HasAnimDictLoaded('weapons@first_person@aim_rng@generic@projectile@sticky_bomb@') do
            Citizen.Wait(100)
                end

            exports['pogressBar']:drawBar(3000, "Přikládání tint metru na sklo")
            TaskPlayAnim(playerPed, 'weapons@first_person@aim_rng@generic@projectile@sticky_bomb@', 'plant_vertical', 8.0, -8, -1, 4, 0, 0, 0, 1)
            Citizen.Wait (2500)
            ExecuteCommand("do Přístroj měří propustnost skel")
            
            exports['pogressBar']:drawBar(12000, "Probíhá měření propustnosti skla")
            Citizen.Wait (12000)
            
            if GetVehicleWindowTint(vehicle) == -1  then
                SendNUIMessage({    
                    tint = 'None',
                    exports['mythic_notify']:SendAlert('Inform', 'Toto vozidlo má zatmavení skla: Stock')
                })
            elseif GetVehicleWindowTint(vehicle) == 0 then
                SendNUIMessage({
                    tint = 'Stock',
                    exports['mythic_notify']:SendAlert('Inform', 'Toto vozidlo má zatmavení skla: None'),
                })
            elseif GetVehicleWindowTint(vehicle) == 1 then
                SendNUIMessage({
                    tint = 'Pure Black',
                    exports['mythic_notify']:SendAlert('Inform', 'Toto vozidlo má zatmavení skla: Pure Black'),
                })
            elseif GetVehicleWindowTint(vehicle) == 2 then
                SendNUIMessage({
                    tint = 'Dark Smoke',
                    exports['mythic_notify']:SendAlert('Inform', 'Toto vozidlo má zatmavení skla: Dark Smoke'),
                })
            elseif GetVehicleWindowTint(vehicle) == 3 then
                SendNUIMessage({
                    tint = 'Light Smoke',
                    exports['mythic_notify']:SendAlert('Inform', 'Toto vozidlo má zatmavení skla: Light Smoke'),
                })
            elseif GetVehicleWindowTint(vehicle) == 4 then
                SendNUIMessage({
                    tint = 'Limo',
                    exports['mythic_notify']:SendAlert('Inform', 'Toto vozidlo má zatmavení skla: Stock'),
                })
            elseif GetVehicleWindowTint(vehicle) == 5 then
                SendNUIMessage({
                    tint = 'Green',
                    exports['mythic_notify']:SendAlert('Inform', 'Toto vozidlo má zatmavení skla: Limo'),
                })
            elseif GetVehicleWindowTint(vehicle) == 6 then
                SendNUIMessage({
                    tint = 'Limo',
                    exports['mythic_notify']:SendAlert('Inform', 'Toto vozidlo má zatmavení skla: Green'),
                })
            end
        else 
            exports['mythic_notify']:SendAlert('Inform', 'Jsi daleko od vozidla!')
        end
    end
end, false)