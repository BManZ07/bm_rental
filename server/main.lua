ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent("nrv_rental:verus")
AddEventHandler("nrv_rental:verus", function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local amount = 100
    print(xPlayer.getMoney())

    if xPlayer.getMoney() > amount then
        xPlayer.removeMoney(amount) 
    end
end)

RegisterNetEvent("nrv_rental:winky")
AddEventHandler("nrv_rental:winky", function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local amount = 200
    print(xPlayer.getMoney())

    if xPlayer.getMoney() > amount then
        xPlayer.removeMoney(amount) 
    end
end)

RegisterNetEvent("nrv_rental:rumpo")
AddEventHandler("nrv_rental:rumpo", function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local amount = 1000
    print(xPlayer.getMoney())

    if xPlayer.getMoney() > amount then
        xPlayer.removeMoney(amount) 
    end
end)

ESX.RegisterServerCallback('nrv_rental:getMoney', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerMoney = xPlayer.getMoney()
    cb(playerMoney)
end)
