RegisterCommand(
    "mdt",
    function()
        -- TODO: Add permissions checking
        SendNUIMessage(
            {
                action = "showMdt"
            }
        )
        SetNuiFocus(true, true)
    end,
    false
)

RegisterNUICallback(
    "hideMdt",
    function()
        SetNuiFocus(false, false)
    end
)
