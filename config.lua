Config = {}
Config.MedibagItem = "medibag" --ox inventory item
Config.MedibagProp = "xm_prop_x17_bag_med_01a" --Medibag prop, customize this if you want
Config.Notifications = false --Enable/Disable notifications on pickup and place
Config.MedibagTarget = {
    {
        canInteract = function(_, distance, _)
            return not IsEntityDead(PlayerPedId()) and distance < 2.0
        end,
        event = 'lion_medibag:pickupMedbag', --Dont edit this until you dont know what are you doing
        icon = 'fa-solid fa-briefcase-medical',
        label = "Pickup Medibag",
        distance = 2.0
    },
}
Config.Locale = { -- Edit if you want
    ['pickedupmedbag'] = "Medibag has been picked up",
    ['placemedbag'] = "Medibag has been placed",
}

Notify = function(title, desciption, duration) -- If you want just replace with your own notifications
    lib.notify({
        title = title,
        description = desciption,
        icon = 'fa-solid fa-briefcase-medical',
        iconColor = "#ed1b24",
        duration = duration
    })
end