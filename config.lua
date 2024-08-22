lib.locale()

local bags = {}
local medibagprop, medibagtarget = Config.MedibagProp, Config.MedibagTarget
local ox_target = exports.ox_target

RegisterNetEvent("lion_medibag:placeMedbag")
AddEventHandler("lion_medibag:placeMedbag", function()
    TriggerServerEvent("lion_medibag:placeMedbag")
end)

RegisterNetEvent("lion_medibag:pickupMedbag")
AddEventHandler("lion_medibag:pickupMedbag", function()
    local playerPed = cache.ped
    local pedCoords = GetEntityCoords(playerPed)
    lib.playAnim(playerPed, "random@domestic", "pickup_low", 5.0, 1.0, -1, 48, 0, 0, 0, 0)
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
AddEventHandler("lion_medibag:place", function()
        lib.RequestModel(medibagprop)
        local playerPed = PlayerPedId()
        local itemCount = lib.callback.await("ox_inventory:getItemCount", false, Config.MedibagItem, {})
        local pedCoords = GetEntityCoords(playerPed)
        if itemCount >= 1 then
            lib.playAnim(playerPed, "random@domestic", "pickup_low", 5.0, 1.0, -1, 48, 0, 0, 0, 0)
            TriggerServerEvent("lion:removeitem", Config.MedibagItem)
            local Medibag = CreateObject(medibagprop, pedCoords.x, pedCoords.y, pedCoords.z - 1, true, false, false)
            SetEntityHeading(Medibag, GetEntityHeading(playerPed))
            PlaceObjectOnGroundProperly(Medibag)
            table.insert(bags, Medibag)
            SetModelAsNoLongerNeeded(medibagprop)
            ox_target:addLocalEntity(Medibag, medibagtarget)
        end
    end
)

AddEventHandler("onResourceStop", function(resourceName)
    if resourceName == GetCurrentResourceName() then
        for _, medibag in pairs(bags) do
            if DoesEntityExist(medibag) then
                DeleteEntity(medibag)
            end
        end
    end
end)

if Config.Command then
    RegisterCommand(Config.Commandname, function()
        local admin = lib.callback.await('lion:checkperms', false)

        if admin then
            local medibagFound = false

            for _, medibag in pairs(bags) do
                if DoesEntityExist(medibag) then
                    medibagFound = true
                    DeleteEntity(medibag)
                end
            end

            if medibagFound then
                Notify("Medibag", locale("medibagsdeleted"), "fa-solid fa-suitcase-medical", "#ed1b24", 2500)
            else
                Notify("Medibag", locale("nomedibangsfound"), "fa-solid fa-exclamation-triangle", "#cc0000", 2500)
            end

        else
            Notify("Server", locale("notadmin"), "fa-solid fa-user", "#cc0000", 2500)
        end
    end, false)
end

if Config.EnableHealing then
    ox_target:addGlobalPlayer(Config.HealingTarget)
end
