Config = {}
Config.MedibagItem = "medibag"
Config.MedibagProp = "xm_prop_x17_bag_med_01a"
Config.Notifications = false
Config.MedibagTarget = {
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
Config.Locale = {
    ['pickedupmedbag'] = "Medibag has been picked up",
    ['placemedbag'] = "Medibag has been placed",
    ['cantcarry'] = "You can't carry this!",
}

Notify = function(title, desciption, duration) -- REPLACE WITH YOUR OWN NOTIFICATIONS
    lib.notify({
        title = title,
        description = desciption,
        icon = 'fa-solid fa-briefcase-medical',
        iconColor = "#ed1b24",
        duration = duration
    })
end
