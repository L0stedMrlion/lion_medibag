local bags = {}
local bagOptions = Config.MedibagTarget
local medibagprop = Config.MedibagProp
local medibagIds = {}

RegisterNetEvent("lion_medibag:placeMedbag")
AddEventHandler(
    "lion_medibag:placeMedbag",
    function()
        TriggerServerEvent("lion_medibag:placeMedbag")
    end
)

RegisterNetEvent("lion_medibag:pickupMedbag")
AddEventHandler(
    "lion_medibag:pickupMedbag",
    function()
        local playerPed = PlayerPedId()
        local pedCoords = GetEntityCoords(playerPed)
        lib.playAnim(playerPed, "random@domestic", "pickup_low", 5.0, 1.0, -1, 48, 0, 0, 0, 0)
        TriggerServerEvent("lion_medibag:pickupMedbag")
        if Config.Notifications then
            Notify("Medibag", Config.Locale["pickedupmedbag"], 2000)
        end
        local medibagId = GetClosestObjectOfType(pedCoords, 2.0, GetHashKey("xm_prop_x17_bag_med_01a"), false, false, false)
        if medibagId ~= 0 then
            DeleteEntity(medibagId)
            table.remove(medibagIds, table.find(medibagIds, medibagId))
        end
    end
)

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
            local newBag = CreateObject(medibagprop, pedCoords.x, pedCoords.y, pedCoords.z - 1, true, false, false)
            SetEntityHeading(newBag, GetEntityHeading(playerPed))
            PlaceObjectOnGroundProperly(newBag)
            table.insert(bags, newBag)
            table.insert(medibagIds, newBag)
        end
    end
)

AddEventHandler(
    "onResourceStop",
    function(resourceName)
        if resourceName == GetCurrentResourceName() then
            for _, bag in pairs(bags) do
                if DoesEntityExist(bag) then
                    DeleteEntity(bag)
                end
            end
        end
    end
)
exports.ox_target:addModel(medibagprop, bagOptions)
