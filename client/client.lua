local bags = {}
local medibagprop = Config.MedibagProp

local function placeMedbag()
    TriggerServerEvent('lion_medibag:placeMedbag')
end
RegisterNetEvent('lion_medibag:placeMedbag', placeMedbag)

RegisterNetEvent('lion_medibag:pickupMedbag', function()
    local pedCoords = GetEntityCoords(cache.ped)
    lib.playAnim(cache.ped, "random@domestic", "pickup_low", 5.0, 1.0, -1, 48, 0, 0, 0, 0)

    if Config.Notifications then
        Notify("Medibag", Config.Locale["pickedupmedbag"], 2000)
    end

    local medibag = GetClosestObjectOfType(pedCoords, 2.0, GetHashKey(medibagprop), false, false, false)
    TriggerServerEvent("lion_medibag:canPickupMedbag", NetworkGetNetworkIdFromEntity(medibag))
end)

RegisterNetEvent("lion_medibag:pickupMedbagResponse", function(canCarry, medibagNetId)
    if canCarry then
        local medibag = NetworkGetEntityFromNetworkId(medibagNetId)
        if medibag ~= 0 then
            DeleteEntity(medibag)
            for i, bag in ipairs(bags) do
                if bag == medibag then
                    table.remove(bags, i)
                    break
                end
            end
        end
    end
end)

RegisterNetEvent("lion_medibag:place", function()
    lib.requestModel(medibagprop)
    local itemCount = lib.callback.await("ox_inventory:getItemCount", false, Config.MedibagItem, {})
    local pedCoords = GetEntityCoords(cache.ped)
    if itemCount >= 1 then
        lib.playAnim(cache.ped, "random@domestic", "pickup_low", 5.0, 1.0, -1, 48, 0, 0, 0, 0)
        placeMedbag()
        if Config.Notifications then
            Notify("Medibag", Config.Locale["placemedbag"], 2000)
        end
        local newMedBag = CreateObject(medibagprop, pedCoords.x, pedCoords.y, pedCoords.z - 1, true, false, false)
        SetEntityHeading(newMedBag, GetEntityHeading(cache.ped))
        PlaceObjectOnGroundProperly(newMedBag)
        bags[#bags + 1] = newMedBag
    end
end)

AddEventHandler("onResourceStop", function(resourceName)
    if resourceName == cache.resource then
        for i = 1, #bags do
            local bagId = bags[i];
            if DoesEntityExist(bagId) then
                DeleteEntity(bagId)
            end
        end
    end
end)

exports.ox_target:addModel(medibagprop, Config.MedibagTarget)
