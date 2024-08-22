local ox_inventory = exports.ox_inventory

RegisterServerEvent('lion:removeitem')
AddEventHandler('lion:removeitem',function(item)
	ox_inventory:RemoveItem(source, item, 1, nil, nil, nil)
end)

RegisterServerEvent("lion_medibag:canPickupMedbag")
AddEventHandler("lion_medibag:canPickupMedbag", function(medibagNetId)
    if ox_inventory:CanCarryItem(source, Config.MedibagItem, 1) then
        ox_inventory:AddItem(source, Config.MedibagItem, 1, nil, nil, nil)
        TriggerClientEvent("lion_medibag:pickupMedbagResponse", source, true, medibagNetId)
    else
        TriggerClientEvent("lion_medibag:pickupMedbagResponse", source, false, medibagNetId)
    end
end)

local function IsAdmin(src)
    ESX = exports["es_extended"]:getSharedObject()
    local xPlayer = ESX.GetPlayerFromId(src)

    return Config.AdminGroups[xPlayer.getGroup()]
end

lib.callback.register('lion:checkperms', function(source)
    return IsAdmin(source)
end)

if Config.DependencyCheck then
if not lib.checkDependency('ox_lib', '3.25.0') then lib.print.warn("You need ox_lib to run lion_medibag! If you have ox_lib on the server you see this message, because you use older version, you can use it the older version, but if is anything working for you I wont help you!") end
if not lib.checkDependency('ox_target', '1.17.0') then lib.print.warn("You need ox_target to run lion_medibag! If you have ox_target on the server you see this message, because you use older version, you can use it the older version, but if is anything working for you I wont help you!") end
if not lib.checkDependency('ox_inventory', '2.42.0') then lib.print.warn("You need ox_inventory to run lion_medibag! If you have ox_inventory on the server you see this message, because you use older version, you can use it the older version, but if is anything working for you I wont help you!") end
end
