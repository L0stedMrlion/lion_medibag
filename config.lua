Config = {}
Config.DependencyCheck = true -- Checks if you have all dependencies

Config.MedibagProp = "xm_prop_x17_bag_med_01a" -- Medibag prop
Config.Ambulancejob = {["ambulance"] = 0} -- or do just "ambulance" or any job you want to see Healing Target

Config.MedibagItem = "medibag" -- Medibag item name from ox_inventory
Config.BandageItem = "bandage" -- Bandage item name from ox_inventory

Config.Command = true -- If enabled, the command is only for groups you set below
Config.Commandname = "deletemedibags" -- Name of the command, if default do /deletemedibags
Config.AdminGroups = { -- Only works as ESX groups
    ["admin"] = true
}

Config.MedibagTarget = { -- Target of the medibag
    {
        canInteract = function(_, distance, _)
            return not IsEntityDead(PlayerPedId()) and distance < 2.0
        end,
        event = 'lion_medibag:pickupMedbag',
        icon = 'fa-solid fa-briefcase-medical',
        label = "Pickup Medibag",
        distance = 2.0
    },
}

Config.EnableHealing = true -- Enables whole healing thing, edit however you want
Config.HealingTarget = {
    label = "Heal",
    icon = 'fa-solid fa-heart',
    distance = 2.0,
    groups = Config.Ambulancejob,
    items = Config.BandageItem,
    onSelect = function()
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        local closestPlayer = lib.getClosestPlayer(playerCoords, 2.1, false)

        if closestPlayer then
            local closestPlayerPed = GetPlayerPed(closestPlayer)
            local health = GetEntityHealth(closestPlayerPed)
            local maxHealth = GetEntityMaxHealth(closestPlayerPed)

            if health < maxHealth then
                TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
                Wait(6000)
                ClearPedTasks(playerPed)
                SetEntityHealth(closestPlayerPed, maxHealth)
                TriggerServerEvent("lion:removeitem", "bandage")
            else
                Notify("Medibag", locale("fullhp"), "fa-solid fa-heart", "#ed1b24", 2500)
            end
        else
            Notify("Medibag", locale("noplayernearby"), "fa-solid fa-user", "#ed1b24", 2500)
        end
    end
}

Notify = function(title, desciption, icon, iconColor, duration) -- Replace with your own notifications
    lib.notify({
        id = "medibag",
        title = title,
        description = desciption,
        icon = icon,
        iconColor = iconColor,
        duration = duration
    })
end
