local bags = {}
local bagOptions = Config.MedibagTarget
local medibagprop = Config.MedibagProp

RegisterNetEvent("lion_medibag:placeMedbag")
AddEventHandler(
    "lion_medibag:placeMedbag",
    function()
        TriggerServerEvent("lion_medibag:placeMedbag")
    end
)

RegisterNetEvent("lion_medibag:pickupMedbag")
AddEventHandler("lion_medibag:pickupMedbag", function()
    local playerPed = PlayerPedId()
    local pedCoords = GetEntityCoords(playerPed)
    lib.playAnim(playerPed, "random@domestic", "pickup_low", 5.0, 1.0, -1, 48, 0, 0, 0, 0)

    if Config.Notifications then
        Notify("Medibag", Config.Locale["pickedupmedbag"], 2000)
    end

    local medibag = GetClosestObjectOfType(pedCoords, 2.0, GetHashKey(medibagprop), false, false, false)
    TriggerServerEvent("lion_medibag:canPickupMedbag", NetworkGetNetworkIdFromEntity(medibag))
end)

RegisterNetEvent("lion_medibag:pickupMedbagResponse")
AddEventHandler("lion_medibag:pickupMedbagResponse", function(canCarry, medibagNetId)
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
    else
    end
end)

RegisterNetEvent("lion_medibag:place")
AddEventHandler(
    "lion_medibag:place",
    function()
        lib.RequestModel(medibagprop)
        while not HasModelLoaded(medibagprop) do
            Citizen.Wait(10)
        end
        local playerPed = PlayerPedId()
        local itemCount = lib.callback.await("ox_inventory:getItemCount", false, Config.MedibagItem, {})
        local pedCoords = GetEntityCoords(playerPed)
        if itemCount >= 1 then
            lib.playAnim(playerPed, "random@domestic", "pickup_low", 5.0, 1.0, -1, 48, 0, 0, 0, 0)
            TriggerEvent("lion_medibag:placeMedbag")
            if Config.Notifications then
                Notify("Medibag", Config.Locale["placemedbag"], 2000)
            end
            local newMedBag = CreateObject(medibagprop, pedCoords.x, pedCoords.y, pedCoords.z - 1, true, false, false)
            SetEntityHeading(newMedBag, GetEntityHeading(playerPed))
            PlaceObjectOnGroundProperly(newMedBag)
            table.insert(bags, newMedBag)
        end
    end
)

AddEventHandler(
    "onResourceStop",
    function(resourceName)
        if resourceName == GetCurrentResourceName() then
            for _, medibag in pairs(bags) do
                if DoesEntityExist(medibag) then
                    DeleteEntity(medibag)
                end
            end
        end
    end
)
exports.ox_target:addModel(medibagprop, bagOptions)
