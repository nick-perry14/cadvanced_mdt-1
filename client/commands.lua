-- Command handling
RegisterCommand(
    "mdt",
    function()
        -- TODO: Add permissions checking
        SendNUIMessage({action = "showMdt"})
        SetNuiFocus(true, true)
    end,
    false -- Allow anyone to issue this command
)
