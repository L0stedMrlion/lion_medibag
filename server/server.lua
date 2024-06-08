local ox_inventory = exports.ox_inventory

RegisterServerEvent('lion_medibag:placeMedbag')
AddEventHandler('lion_medibag:placeMedbag',function ()
	ox_inventory:RemoveItem(source, Config.MedibagItem, 1, nil, nil, nil)
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
