RegisterServerEvent('lion_medibag:placeMedbag')
AddEventHandler('lion_medibag:placeMedbag',function ()
	exports.ox_inventory:RemoveItem(source, Config.MedibagItem, 1, nil, nil, nil)
end)

RegisterServerEvent('lion_medibag:pickupMedbag')
AddEventHandler('lion_medibag:pickupMedbag',function ()
	exports.ox_inventory:AddItem(source, Config.MedibagItem, 1, nil, nil, nil)
end)